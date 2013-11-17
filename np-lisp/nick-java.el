(require 's)
(require 'nick-prog-utils)

(setq import-index (make-hash-table :test 'equal))
(setq static-import-index (make-hash-table :test 'equal))
(setq np/java-parent-dir "java/")
(setq np/java-test-parent-dir "javatests/")

(defconst java-test-file-regex ".*Test.java")
(defconst java-import-regex "^import [a-zA-Z0-9\\.]+;[:space:]*$")
(defconst java-static-import-regex "^import static [a-zA-Z0-9.]+;[:space:]*$")
(defconst java-any-import-regex (concat "\\(" java-import-regex "\\|" java-static-import-regex "\\)"))
(defconst np/java-package-regexp "^package .*;.*$")

;; TODO Need a way to persist the index
(defun np/save-import-index (savefile)
  (interactive "FSave index to file: ")
  (save-excursion
    (set-buffer (find-file-noselect savefile))
    (mark-whole-buffer)
    (delete-active-region)
    (let ((print-length nil)) (prin1 (cons import-index static-import-index) (current-buffer)))
    (save-buffer)
    (kill-buffer)))

(defun np/load-import-index (loadfile)
  (interactive "FLoad index from file: ")
  (save-excursion
    (set-buffer (find-file-noselect loadfile))
    (let ((indices (read (current-buffer))))
      (setq import-index (car indices))
      (setq static-import-index (cdr indices))
      (message (concat "Loaded "
                       (int-to-string (hash-table-size import-index)) " objects and "
                       (int-to-string (hash-table-size static-import-index)) " static methods." )))))

(defun np/find-orphaned-index-entries (root-dir)
  "Find all of the index entries that have no matching file under 'root-dir."
  ;; TODO
  )

;; TODO Closest neighbor import/multiple import options for symbol
;; TODO Identify class names in buffer and highlight those missing imports

(defun np/current-buffer-is-test-file ()
  "Returns t if the current file is a test file."
  (s-matches? java-test-file-regex
              (buffer-file-name (current-buffer))))

(defun np/import? (line)
  "Returns t if the line is any type of import statement."
  (s-matches? java-any-import-regex line))

(defun np/class-import? (line)
  "Returns t if the line is a class import statement."
  (s-matches? java-import-regex line))

(defun np/static-import? (line)
  "Returns t if the line is a static import statement."
  (s-matches? java-static-import-regex line))

(defun np/import-start-position ()
  "Returns the position of the first import in the file."
  (save-excursion
    (goto-char (point-min))
    (let ((start-point (re-search-forward java-any-import-regex nil t)))
      (beginning-of-line)
      (if start-point (point)
        (progn
          (when (looking-at np/java-package-regexp) (next-line 2))
          (point))))))

(defun np/import-end-position ()
  "Returns the position of the first line after the last import in the file."
  (save-excursion
    (goto-char (point-max))
    (let ((start-point (re-search-backward java-any-import-regex nil t)))
      (beginning-of-line)
      (if start-point
          (progn
            (next-line)
            (point))
        (progn
          (goto-char (point-min))
          (when (looking-at np/java-package-regexp) (next-line))
          (point))))))

;; TODO deal with edge cases for import start
;; Perhaps it would be good to have a function to add the first import, so that the correct
;; formatting is applied

(defun np/imported-objects ()
  "Get the objects explicitly imported in the current file."
  (let* ((lines (s-lines (buffer-substring-no-properties (point-min) (point-max))))
         (imports (-filter #'np/class-import? lines)))
    (mapcar (lambda (line)
              (s-replace ";" ""
                         (s-replace "import " "" (s-trim line))))
            imports)))

(defun np/imported-methods ()
  "Get the objects explicitly imported in the current file."
  (let* ((lines (s-lines (buffer-substring-no-properties (point-min) (point-max))))
         (imports (-filter #'np/static-import? lines)))
    (mapcar (lambda (line)
              (s-replace ";" ""
                         (s-replace "import static " "" (s-trim line))))
            imports)))

(defun np/object-name (qualified-name)
  "Get the name of the object from a fully qualified name.
For example, (np/object-name \"com.pascucci.foo.Bar\") -> \"Bar\""
  (car (last (split-string qualified-name "\\." t))))

(defun np/add-to-import-index (qualified-name)
  "Add a qualified name to the import index to allow automatic imports of that name."
  (puthash (np/object-name qualified-name) qualified-name import-index))

(defun np/remove-from-import-index (qualified-name)
  "Remove a qualified name from the import index."
  (interactive "MQualified Name: ")
  (let ((object-name (np/object-name qualified-name)))
    (remhash object-name import-index)
    (message (concat "Removed " object-name " from index."))))

(defun np/add-to-static-import-index (qualified-name)
  "Add a qualified name to the static import index to allow automatic imports of that name."
  (puthash (np/object-name qualified-name) qualified-name static-import-index))

(defun np/get-imports-for-object (obj-name)
  "Get the imports in the current file that import obj-name."
  (let ((predicate (lambda (import) (equal obj-name (np/object-name import)))))
    (or (-filter predicate (np/imported-objects))
        (-filter predicate (np/imported-methods)))))

(defun np/add-import ()
  "Add an import for the object under POINT. Won't sort your imports afterwards."
  ;; TODO Sort the imports afterwards
  (interactive)
  (let* ((obj-name (substring-no-properties (or (np/empty-to-nil (word-at-point))
                                                (read-string "Import class: "))))
         (import (np/get-import-for-name obj-name))
         (qualified-name (car import))
         (type (cdr import)))
    (unless obj-name (setq obj-name ))
    (if qualified-name
        (if (not (np/get-imports-for-object obj-name))
            (if (not (np/in-package-p (np/java-package-name) qualified-name))
                (save-excursion
                  (goto-char (np/import-start-position))
                  (insert (concat "import "
                                  (when (eq type 'method) "static ")
                                  qualified-name ";\n"))
                  (message (concat "Added import for " qualified-name)))
              (message (concat obj-name
                               " is visible by default in this package (" (np/java-package-name)
                               ")")))
          (message (concat "There is already an import for " qualified-name)))
      (message (concat "No qualified name found for " obj-name)))))

(defun np/in-package-p (package qualified-name)
  "Test whether 'qualified-name is in 'package."
  (let ((package-with-period (concat package ".")))
   (when (s-starts-with? package-with-period qualified-name)
     (not (s-contains? "." (s-replace package-with-period "" qualified-name))))))

(defun np/get-import-for-name (name)
  "Get the qualified name for an object from the import index."
  (let ((object-name (gethash name import-index))
        (method-name (gethash name static-import-index)))
    (cond
     (object-name (cons object-name 'object))
     (method-name (cons method-name 'method)))))

(defun np/add-all-imports-to-index ()
  "Add all of the imports in the current file to the import index."
  (interactive)
  (let ((class-imports (np/imported-objects))
        (static-imports (np/imported-methods)))
    (mapc (lambda (import)
            (np/add-to-import-index import)
            (message (concat "Added " import " to index")))
          class-imports)
    (mapc (lambda (import)
            (np/add-to-static-import-index import)
            (message (concat "Added static " import " to index")))
          static-imports)))

(defun np/auto-import ()
  "Automatically add imports for any indexed object in the current file."
  (interactive)
  (save-excursion
    (goto-char (np/import-end-position))
    (while (< (point) (point-max))
      (when (and (not (prog/in-comment-p))
                 (not (null (word-at-point))))
       (np/add-import))
      (forward-word))))

(defun np/index-current-directory ()
  "Visit each file in the current directory and add all of its imports to the index."
  (interactive)
  (save-excursion
    (mapc (lambda (filename)
            (let* ((existing-buffer (get-buffer filename))
                   (file-buffer (if existing-buffer existing-buffer
                                  (find-file-noselect filename))))
              (set-buffer file-buffer)
              (np/add-all-imports-to-index)
              (when (not existing-buffer)
                (kill-buffer file-buffer))))
          (directory-files default-directory t "^.*\.java$" nil))))

(defun np/what-is-this ()
  "Show a popup with the qualified name of the object under point."
  (interactive)
  (let* ((obj-name (word-at-point))
         (existing-import (first (np/get-imports-for-object obj-name)))
         (indexed-import (car (np/get-import-for-name obj-name))))
    (if (or existing-import indexed-import)
        (popup-tip (concat (or existing-import indexed-import) "\n"
                           (when existing-import "[Imported] ")
                           (when indexed-import "[Indexed]")))
      (popup-tip "Unknown"))))

;; TODO Get names and types of variables in scope
;; TODO Resolve type of variable by examining names in scope
;; TODO Show javadoc in popup for current method

(defun np/get-bounds-of-current-scope ()
  (save-excursion
    ;; TODO Implement
    ;; Algorithm: Read backwards for the next opening or closing brace.
    ;; If the brace is a closing brace, increment brace counter and continue.
    ;; If the brace is an opening brace, decrement brace counter. If brace counter is 0, set point
    ;; and exit. If not, continue.
))

(defun np/java-new-method ()
  "Insert a new method template. Will insert generic method for
plain Java files and a test method for test files."
  (interactive)
  (if (np/current-buffer-is-test-file)
      (yas/insert-by-name "test-method")
    (yas/insert-by-name "method")))


;; TODO Make this general enough for other file structures
(defun np/java-package-name ()
  "Get the package name of the current buffer in Java format (com.google.foo.bar)."
  (let ((file-name (file-name-directory (buffer-file-name))))
    (s-chop-suffix
     "."
     (replace-in-string
      (second (s-split
               (if (string-match np/java-test-parent-dir file-name)
                   np/java-test-parent-dir
                 np/java-parent-dir)
               file-name))
      "/" "."))))

(defun np/java-package-toplevel-dir ()
  (let ((filename (file-name-directory (buffer-file-name))))
    (when (string-match np/java-parent-dir filename)
      (substring filename 0 (match-end 0)))))

(defun np/java-file-class-name ()
  (let ((buffer-file (buffer-file-name)))
   (when (s-ends-with? ".java" buffer-file)
     (s-chop-suffix ".java" (car (last (s-split "/" buffer-file)))))))

(defun np/class-name-regexp (class-name)
  (concat "\\([^a-zA-Z]\\)" class-name "\\([^a-zA-Z]\\)"))

(defun np/rename-class ()
  "Renames the class under point. Does not change the name elsewhere."
  ;; TODO Rename other uses of the class. Probably requires a search/index of some sort - perhaps ag
  ;; can help here.
  (interactive)
  (let* ((class-name (or (word-at-point) (np/java-file-class-name)))
         (new-name (s-trim (read-string (format "Rename '%s' to: " class-name))))
         (new-file-name (s-replace class-name new-name buffer-file-name)))
   (when (equal class-name (np/java-file-class-name))
     (rename-file (buffer-file-name) new-file-name)
     (let ((point-position (point))
           (undo-history buffer-undo-list))
       (kill-buffer)
       (set-buffer (find-file new-file-name))
       (setq buffer-undo-list undo-history)
       (goto-char point-position)))
   (save-excursion
     (goto-char (point-min))
     (replace-regexp (np/class-name-regexp class-name) (concat "\\1" new-name "\\2")
                     nil (point-min) (point-max)))))

(defun np/change-package (new-package)
  (interactive "DNew package directory: ")
  (if (and new-package (file-directory-p new-package))
    (save-excursion
      ;; Remove the package name from the current file
      (let ((old-file (buffer-file-name)))
        (goto-char (point-min))
        (when (looking-at np/java-package-regexp) (kill-line))
        (write-file (concat new-package (file-name-nondirectory (buffer-file-name))))
        (insert (concat "package " (np/java-package-name) ";\n"))
        (save-buffer)
        (delete-file old-file)))
    (message (concat "Package " new-package " does not exist."))))

(defvar np/java-visibilities '("public" "private" "protected") "Java method/class visibilities")
(defun np/next-visibility (current-visibility)
  (np/next-value current-visibility np/java-visibilities))

(defun np/change-visibility ()
  (interactive)
  (let* ((current-visibility (word-at-point))
         (next-visibility (np/next-visibility current-visibility)))
    (if next-visibility
      (save-excursion
        (mark-word)
        (delete-region (region-beginning) (region-end))
        (insert next-visibility))
      (message (concat "Not sure what the next visibility is for " current-visibility)))))

(defun np/ternary-to-if ()
  "Convert the ternary statement under point to an if statement."
  (let* ((statement (np/current-statement))
         (assignee (first (s-split "=" statement)))
         (condition (first (s-split "?" ))))
  ))

;; Keybindings

(global-set-key [f6] 'np/add-import)
(global-set-key (kbd "C-c C-j C-m") 'np/java-new-method)
(global-set-key (kbd "C-c C-j C-w") 'np/what-is-this)
(global-set-key (kbd "C-c C-j C-v") 'np/change-visibility)

(provide 'nick-java)
