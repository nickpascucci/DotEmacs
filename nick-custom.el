(defun indent-whole-buffer ()
  "Indent the buffer."
  (interactive)
  (save-excursion 
    (mark-whole-buffer)
    (indent-region (region-beginning) (region-end))))

(defun in-terminal-p () 
  "Detect if Emacs is running in a terminal."
  (not window-system))

(defun matching-header ()
  "Get the matching header file for this source file."
  (let (
        (file-base-name (file-name-sans-extension (buffer-file-name)))) 
    (cond ((file-readable-p (concat file-base-name ".h")) 
           (concat file-base-name ".h")) 
          ((file-readable-p (concat file-base-name ".hpp")) 
           (concat file-base-name ".hpp"))
          (t nil))))

(defun c-new-file-templatize ()
  "Add a template to new C/C++ files."
  (when (not (file-exists-p (buffer-file-name)))
    (insert "src")
    (yas/expand)
    ))

(add-hook 'c-mode-common-hook 'c-new-file-templatize)

;; A C expression can end with either a semicolon or an opening curly
;; brace. 
(setq c-expression-end ";")
(setq c-comment-single-line "^[\t ]*//.*?$")
(setq c-expression-begin (concat c-expression-end "[
:space:]*."))

(defun move-past-comments ()
  "Move point to the next uncommented line."
  (interactive)
  (beginning-of-line)
  (while (looking-at c-comment-single-line)
    (forward-line)))

(defun skip-whitespace ()
  "Skip over spaces, tabs, and newlines."
  (re-search-forward "[\n[:space:]]*"))

(defun mark-c-def () 
  "Mark the C definition containing point."
  (interactive)
  ;; Search backwards for the previous expression's end
  (re-search-backward c-expression-begin (point-min) t)

  (forward-char)
  (skip-whitespace)
  (move-past-comment)
  (skip-whitespace)

  ;; Set the mark just after it and search forward for the end of this
  ;; expression
  (set-mark (point))
  (re-search-forward c-expression-end (point-max) t)
  (list (mark) (point)))

(defun mark-and-message ()
  (interactive)
  (let ((point-and-mark (mark-c-def)))
    (message "%s : %s" (car point-and-mark) 
             (car (cdr point-and-mark)))))

(defun header-p (file-name)
  (string-match ".*\\.\\(hpp\\|h\\)$" file-name))

(defun mirror-definition () 
  "Mirror a function definition to the matching header or source
  file."
  (interactive)
  (save-excursion 
    (semantic-fetch-tags)
    (setq tag (semantic-current-tag))
    
    (save-current-buffer
      (set-buffer (get-file-buffer (ff-other-file-name)))
;;      (if (semantic-get-))
      ;;(insert "Waldo was here")
      ))
  )

(defun is-comment-line ()
  (interactive)
  (message (looking-at c-comment-single-line)))

(defun insert-date (&optional arg)
  "Insert today's date at POINT. If a prefix is specified, format
similar to 'July 30, 2012'. Otherwise, format is similar to 
'07.30.2012'."
  (interactive "P")
  (insert (if arg 
              (format-time-string "%B %e, %Y")
              (format-time-string "%m.%d.%Y"))))

;; TODO Generalize these into macros
(defun number-format (fmt val &optional base)
  (if (stringp val)
      (setq val (string-to-int val base)))
  (format fmt val))

(defun num-format-region (fmt start end &optional base)
  (let ((hex-value (number-format 
                    fmt (buffer-substring start end) base)))
    (delete-region start end)
    (insert hex-value)))

(defun region-dec-to-hex (start end)
  (interactive "r")
  (num-format-region "%02X" start end))

(defun region-hex-to-dec (start end)
  (interactive "r")
  (num-format-region "%d" start end 16))

(defun show-project ()
  (if (ede-current-project)
   (add-to-list 'mode-line-format 
                '(:eval  
                  (concat " " (elt (ede-current-project) 2) " ")))))

(defun repeat-string (string times)
  (let ((built "")) 
    (dotimes (x times)
      (setf built (concat built string))) 
    built))

(defun new-todo (body)
  "Create a new TODO item in the default file."
  (interactive "MTODO: ")
  (with-current-buffer (find-file-noselect todo-file t)
    (save-excursion 
      (goto-char (point-max)) 
      (insert "* TODO " body))
    (save-buffer))
  (message (format "Saved." todo-file)))

;; The regexp-replace patterns used in this macro:
;; \(.*?\)_\([a-zA-Z]\)\(.*?\)
;; \1\,(capitalize \2)\3
(fset 'underline-to-camelcase
   [?\M-x ?m ?a ?r ?k ?- ?e ?s backspace backspace ?s ?e ?x ?p return ?\M-x ?r ?e ?p ?l ?a ?c ?e ?- ?r ?e ?g ?e ?x ?p return ?\\ ?\( ?. ?* ?? ?\\ ?\) ?_ ?\\ ?\( ?\[ ?a ?- ?z ?A ?- ?Z ?\] ?\\ ?\) ?\\ ?\( ?. ?* ?? ?\\ ?\) return ?\\ ?1 ?\\ ?, ?\( ?c ?a ?p ?i ?t ?a ?l ?i ?z ?e ?  ?\\ ?2 ?\) ?  backspace ?\\ ?3 return ?\M-b ?\M-b ?\C-x ?\C-x])

(c-add-style "my-c-style" '((c-continued-statement-offset 4)))
(defun java-indent-setup ()
  (interactive)
  (c-set-offset 'arglist-intro '++)
  (c-set-offset 'brace-list-entry '++))
(add-hook 'java-mode-hook 'java-indent-setup)

(defun move-line-down ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines 1))
    (forward-line)
    (move-to-column col)))

(defun move-line-up ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines -1))
    (move-to-column col)))

(defun easy-grep (term)
  (interactive "sSearch for: ")
  (rgrep term "*"))
