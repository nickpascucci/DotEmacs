;;;; A bunch of random elisp utilities I wrote/copied to make certain operations easier.
(defgroup nick-custom nil "Customization group for custom elisp.")
(require 'cl)
(require 'dash)
(require 's)

(defun np/prepend-subdirs (dir)
  (let ((default-directory dir))
    (setq load-path
          (append
           (let ((load-path (copy-sequence load-path)))
             (append
              (copy-sequence (normal-top-level-add-to-load-path '(".")))
              (normal-top-level-add-subdirs-to-load-path)))
             load-path))))

(defun indent-whole-buffer ()
  "Indent the buffer."
  (interactive)
  (save-excursion
    (mark-whole-buffer)
    (indent-region (region-beginning) (region-end))))

;; Obtained from http://yesybl.org/blogen/?p=25
(defun uniq-lines (beg end)
  "Unique lines in region.
   Called from a program, there are two arguments:
   BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))

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
    (yas/expand)))

;; (add-hook 'c-mode-common-hook 'c-new-file-templatize)

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
  "Mark the C definition containing point and message its value.
Mostly intended for debugging."
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
      )))

(defun is-comment-line ()
  (interactive)
  (message (looking-at c-comment-single-line)))

(defun np/constantize ()
  "Convert a name into constant form (upper case, underscore-separated"
  (interactive)
  (let ((name (buffer-substring (region-beginning) (region-end))))
    (delete-region (region-beginning) (region-end))
    (insert-string (s-join "_" (mapcar #'s-upcase (s-split-words name))))))

(defun insert-date (&optional arg)
  "Insert today's date at POINT. If a prefix is specified, format
similar to 'July 30, 2012'. Otherwise, format is similar to
'07.30.2012'."
  (interactive "P")
  (insert (if arg
              (format-time-string "%B %e, %Y")
              (format-time-string "%m.%d.%Y"))))

(defun insert-date-time (&optional arg)
  "Insert the current time and date at POINT. If a prefix is
   specified, format similarly to 'July 30, 2012 1:00PM'. Otherwise,
   format similar to '07.30.2012 1300.45'."
  (interactive "P")
  (insert-date arg)
  (insert " ")
  (insert (if arg
              (format-time-string "%I:%M%p")
            (format-time-string "%H:%M.%S"))))

(defun insert-day (&optional arg)
  "Insert the day of the week. If a prefix argument is given,
insert the long form; otherwise, insert the abbreviated form."
  (interactive "P")
  (if arg
      (insert (format-time-string "%A"))
    (insert (format-time-string "%a"))))

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
  "Convert a region from decimal to hexadecimal."
  (interactive "r")
  (num-format-region "%02X" start end))

(defun region-hex-to-dec (start end)
  "Convert a region from hexadecimal to decimal."
  (interactive "r")
  (num-format-region "%d" start end 16))

(defun show-project ()
  "Show the current EDE project in the modeline."
  (if (ede-current-project)
   (add-to-list 'mode-line-format
                '(:eval
                  (concat " " (elt (ede-current-project) 2) " ")))))


(defun switch-project (dir)
  "Switch to a new project, opening its buffers and saving the current ones."
  (interactive "DDirectory: ")
  (let ((dirname-start (string-match "repos/" default-directory)))
   (list dirname-start (string-match "/.*" default-directory dirname-start))))

(defun repeat-string (string times)
  (let ((built ""))
    (dotimes (x times)
      (setf built (concat built string)))
    built))

(defun np/insert-repeated-string (string times)
  (interactive "MString: \nnTimes: ")
  (insert (repeat-string string times)))

(defun np/new-todo (body)
  "Create a new TODO item in the default file."
  (interactive "MTODO: ")
  (with-current-buffer (find-file-noselect todo-file t)
    (save-excursion
      (goto-char (point-max))
      (insert "** TODO " body))
    (save-buffer))
  (message (format "Saved." todo-file)))

(setq log-file "~/worklog.org")

(defun np/new-worklog (add-link body)
  "Create a new work log item in the default file. When called
with a prefix argument, add a link to the current line."
  (interactive "P\nM(log) ")
  (let ((file-name (buffer-file-name))
        (line-number (line-number-at-pos)))
   (with-current-buffer (find-file-noselect log-file t)
     (save-excursion
       (goto-char (point-max))
       (insert-day)
       (insert ", ")
       (insert-date-time)
       (when (and (not (null file-name)) add-link)
         (insert (concat " [[file:" file-name "::" (int-to-string line-number) "]"
                         "[" (file-name-nondirectory file-name) "]]")))
       (insert " - " body))
     (save-buffer)))
  (message (format "Saved." log-file)))


(defun np/show-log ()
  (interactive)
  (find-file log-file))

(defun nxml-where ()
      "Display the hierarchy of XML elements the point is on as a path."
      (interactive)
      (let ((path nil))
        (save-excursion
          (save-restriction
            (widen)
            (while (condition-case nil
                       (progn
                         (nxml-backward-up-element) ; always returns nil
                         t)
                     (error nil))
              (setq path (cons (xmltok-start-tag-local-name) path)))
            (message "/%s" (mapconcat 'identity path "/"))))))

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

(defun save-frame-config ()
  "Save the current frame and window configuration."
  (interactive)
  (setq saved-frame-configuration (current-frame-configuration))
  (setq saved-window-configuration (current-window-configuration)))

(defun restore-frame-config ()
  "Restore the saved frame and window configuration."
  (interactive)
  (set-frame-configuration saved-frame-configuration)
  (set-window-configuration saved-window-configuration))

;; assumes using reset-ui based layout
(defun toggle-visor ()
  "Toggle the full screen ANSI terminal."
  (interactive)
  (if (string= "term-mode" major-mode)
      (progn
        (message "Visor off.")
        (bury-buffer)
        (restore-frame-config))
    (save-frame-config)
    (delete-other-windows)
    (let ((visor-buffer (get-buffer "*Visor*")))
      (if visor-buffer
          (switch-to-buffer visor-buffer)
        (ansi-term "/bin/bash" "Visor")))
    (message "Visor on!")))

(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10).
Obtained from http://xahlee.blogspot.com/2011/09/emacs-lisp-function-to-trim-string.html"
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string)))

(defun region-to-lines ()
  "Split a region into lines, with one word per line."
  (interactive)
  (insert
   (trim-string
    (replace-regexp-in-string
     "[[:space:]]+" "\n"
     (delete-and-extract-region (region-beginning) (region-end)))))
  (goto-char (region-end)))

(defun split-and-mark-region ()
  "Split a region into lines and place a cursor at then end of each one a la Sublime Text."
  (interactive)
  (unless (and (region-active-p)
               (not mm/master))
    (error "Mark a region to split first"))
  (region-to-lines)
  (exchange-point-and-mark)
  (mc/edit-ends-of-lines))

(fset 'left-shift-region-safe
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([21 45 52 134217848 105 110 100 101 110 116 45 114 105 103 105 100 108 121 return] 0 "%d")) arg)))

(defun simple-shell-command (cmd)
  (with-temp-buffer
    (call-process cmd nil t)
    (trim-string
     (buffer-substring-no-properties (point-min) (point-max)))))

(defun hostname ()
  (simple-shell-command "hostname"))

(defun uptime ()
  (simple-shell-command "uptime"))

(defun yas/insert-by-name (name)
  (flet ((dummy-prompt
          (prompt choices &optional display-fn)
          (declare (ignore prompt))
          (or (find name choices :key display-fn :test #'string=)
              (throw 'notfound nil))))
    (let ((yas/prompt-functions '(dummy-prompt)))
      (catch 'notfound
        (yas/insert-snippet t)))))

(defun np/insert-org-code-block ()
  (interactive)
  (yas/insert-by-name "code-block"))


(defun np/show-timers ()
  (interactive)
  (switch-to-buffer "*Timer List*")
  (erase-buffer)
  (insert "Interval | Function\n")
  (dolist (timer timer-list)
    (insert (int-to-string (elt timer 4)))
    (insert " | ")
    (pp (elt timer 5) (current-buffer))
    (insert "\n")))

(defun np/center-text-in-frame ()
  (interactive)
  (let ((fringe-size (/ (- (frame-width) fill-column) 2))
        (style-pair nil))
    (message (concat "Fringe size: " (int-to-string fringe-size)))
    (cons fringe-size style-pair)
    (cons fringe-size style-pair)
    (set-fringe-style style-pair)))

(defun java-describe (symbol-name)
  "Cribbed from http://nflath.com/2009/07/accessing-javadoc-via-emacs/"
  (interactive "MJava Class: ")
  (message (concat "Looking up " symbol-name))
  (let ((doc-pages (replace-regexp-in-string
		    "^.*class-use/.*\n"
		    ""
		    (shell-command-to-string
		     (concat "find ~/dev/docs/java/api -name "
		     	     symbol-name
			     ".html"))
		   )))
    (message (concat "Found these hits: [" doc-pages "]"))
    (browse-url (first (s-split "\n" doc-pages)))))

(global-set-key (kbd "C-h j") 'java-describe)

(defun np/replace-this (replacement)
  (interactive "MReplace with: ")
  (query-replace (buffer-substring (region-beginning) (region-end)) replacement))

;; TODO Make this into a generic string-splitting function
(defun np/split-at-fill-column ()
  (interactive)
  (move-to-column (- fill-column 1))
  (newline-and-indent))

(setq git-merge-mid-marker "=======")
(setq git-merge-head-marker "<<<<<<< HEAD")

(defun np/select-git-merge (keep)
  "Select the chunk to keep in a git merge conflict block."
  (interactive "nDiff to keep <0/1/2>: ")
  (message (concat "Keeping " (if (equal 1 keep) "theirs"
                                (if (equal 0 keep) "ours" "both"))))
  (beginning-of-line)
  (save-excursion
    (let* ((upper-bound (point))
          (lower-bound (save-excursion (search-forward-regexp "^>>>>>>> .*$")
                                       (point)))
          (midpoint (save-excursion (search-forward-regexp git-merge-mid-marker)
                                    (point)))
          (elements (s-lines (np/get-merge-region upper-bound lower-bound)))
          (regions (-split-with (lambda (s) (not (equal git-merge-mid-marker s))) elements))
          (ours (first regions))
          (theirs (rest (car (rest regions))))
          )
      (kill-region upper-bound lower-bound)
      (case keep
        (0 (insert (s-join "\n" ours)))
        (1 (insert (s-join "\n" theirs)))
        (2 (insert (s-join "\n" (append ours theirs))))
        (t (message (concat (int-to-string keep) " is not valid."))
           (yank))))))

(defun np/git-merge-all (keep)
  (interactive "nSide to keep <0/1>: ")
  (save-excursion
    (while (search-forward-regexp git-merge-head-marker (point-max) t)
      (beginning-of-line)
      (np/select-git-merge keep))))

(defun np/get-merge-region (upper lower)
  "Get the body of a Git merge region between, but not including,
the lines containing upper and lower."
  (save-excursion
    (let ((first-line (progn (goto-char upper)
                             (next-line)
                             (beginning-of-line)
                             (point)))
          (last-line (progn (goto-char lower)
                            (previous-line)
                            (end-of-line)
                            (point))))
      (buffer-substring first-line last-line))))

(defun np/buffer-matches (regexp buf)
  (string-match regexp (buffer-name buf)))

(defun np/buffers-matching (regexp)
  (-filter (apply-partially #'np/buffer-matches regexp) (buffer-list)))

(setq np/jabber-buffer-regexp "\\*-jabber-chat-.*-\\*")
(defun np/bury-chat-buffers ()
  (interactive)
  ;; Bury the buffers first so that they aren't selected when we bury windows.
  (mapc #'bury-buffer (np/buffers-matching np/jabber-buffer-regexp))
  ;; Then remove all of the buffers in view.
  (let ((start-window (selected-window)))
    (mapc (lambda (window)
            (when (np/buffer-matches np/jabber-buffer-regexp (window-buffer window))
              (select-window window)
              (bury-buffer)))
          (window-list))
    (select-window start-window)))

(defun np/transform-value-at-pt (transformation)
  (let* ((original (string-to-number (word-at-point)))
        (value (funcall transformation original)))
    (mark-word)
    (delete-region (region-beginning) (region-end))
    (insert (number-to-string value))))

(defun np/increment-value-at-pt (increment)
  (interactive "p")
  (np/transform-value-at-pt (apply-partially #'+ (or increment 1))))

(defun np/decrement-value-at-pt (decrement)
  (interactive "p")
  (np/transform-value-at-pt (lambda (x) (- x (or decrement 1)))))

(defun* np/next-value (current values &key (test #'equal))
  "Select the value following 'current in 'values, wrapping to the front of the list if needed."
  (let ((index (position current values :test test)))
     (when index (nth (mod (1+ index) (length values))
                      values))))

(defun np/handle-java-imports (auto-import)
  (interactive "P")
  (if auto-import
      (np/auto-import)
    (java-organize-imports)))

(defun np/reap-buffers (pred &optional dry-run)
  "Close buffers matching PRED.

  PRED should be a predicate taking the buffer name and file name and
  returning truthy if the buffer should be reaped."
  (mapc
   (lambda (buf)
     (let ((file-name (buffer-file-name buf))
           (buffer-name (buffer-name buf)))
       (when (and file-name
                  (funcall pred buffer-name file-name))
         (message (concat "Reaping buffer " buffer-name))
         (unless dry-run (kill-buffer buf)))))
   (buffer-list))
  t)

(defun np/reap-matching-files (pattern)
  "Close buffers whose filenames match PATTERN. If a prefix argument is
   supplied, just tell what buffers would have been closed."
  (interactive "sKill files matching: ")
  (np/reap-buffers (lambda (buffer-name file-name) (string-match pattern file-name))))

(defun np/reap-matching-buffers (pattern)
  "Close buffers whose buffer names match PATTERN. If a prefix argument is
   supplied, just tell what buffers would have been closed."
  (interactive "sKill buffers matching: ")
  (np/reap-buffers (lambda (buffer-name file-name) (string-match pattern buffer-name))))

;; Keybindings

(add-hook 'java-mode-hook (lambda () (local-set-key [f9] 'np/handle-java-imports)))
(global-set-key (kbd "C-+") 'np/increment-value-at-pt)
(global-set-key (kbd "C--") 'np/decrement-value-at-pt)
(global-set-key (kbd "C-c n b") 'np/bury-chat-buffers)
(global-set-key (kbd "C-h j") 'java-describe)
(global-set-key [f11] 'toggle-visor)
(global-set-key (kbd "C-c n l") #'np/new-worklog)
(provide 'nick-custom)
