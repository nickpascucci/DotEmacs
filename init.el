;; First: Remove unnecessary GUI stuff.
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(setq inhibit-startup-message t)

;; Load directories and custom elisp files.
(setq init-start-time (float-time))

(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/jdee-2.4.0.1/lisp")
(let ((default-directory "~/.emacs.d"))
  (normal-top-level-add-subdirs-to-load-path))
(let ((default-directory "~/.emacs.d/vendor/"))
  (normal-top-level-add-subdirs-to-load-path))

(load "~/.emacs.d/vendor/haskell-mode-2.8.0/haskell-site-file")

(require 'ace-jump-mode)
(require 'color-theme)
(require 'expand-region)
(require 'ecb-autoloads)
(require 'flymake)
(require 'git)
(require 'flymake)
(require 'magit)
(require 'uniquify)
(require 'magit)
(require 'multiple-cursors)
(require 'org-drill)
(require 'powerline)
(require 'tramp)
(require 'uniquify)
(require 'repeat)
(require 'smartparens)

(autoload 'android "android" "Android mode." t)
(autoload 'android-mode "android-mode" "Android mode 2." t)
(autoload 'arduino-mode "arduino-mode" "Arduino mode." t)
(autoload 'coffee-mode "coffee-mode" "CoffeeScript mode." t)
(autoload 'fci-mode "fill-column-indicator" "Show the fill column." t)
(autoload 'ido "ido" "Interactive Do Mode" t)
(autoload 'ido-goto-symbol "idomenu" "Interactive Do imenu" t)
(autoload 'linum "linum" "Line numbering" t)
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(autoload 'magit "magit" "Git integration." t)
(autoload 'markdown-mode "markdown-mode" "Edit markdown files." t)
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(autoload 'pylookup "pylookup" "Python documentation." t)
(autoload 'pymacs "pymacs" "Python extensions for emacs." t)
(autoload 'visible-mark-mode "visible-mark" "Make marks visible." t)
(autoload 'yas/initialize "yasnippet" "Yasnippet initialize." nil)

(setq custom-file "~/.emacs.d/emacs-custom.el")

;; Custom lisp.
(load-file "~/.emacs.d/nick-custom.el")

;; UI tweaks.
(global-font-lock-mode t)
(windmove-default-keybindings)
(setq use-file-dialog nil)
(setq ido-ignore-extensions t)
(ido-mode t)
(pending-delete-mode t)
(setq powerline-color1 "#222")      ;; dark grey;
(setq powerline-color2 "#333")      ;; slightly lighter grey
(setq powerline-arrow-shape 'slant) ;; mirrored arrows,


;; Ace Jump Mode
(global-set-key (kbd "C-c C-SPC") 'ace-jump-mode)

;; Expand Region
(global-set-key (kbd "C-=") 'er/expand-region)

;; Mark-multiple
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-M-m") 'mark-more-like-this) ; like the other two, but takes an argument (negative is previous)
(global-set-key (kbd "C-*") 'mc/mark-all-like-this)

;; Multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/add-multiple-cursors-to-region-lines)
(global-set-key (kbd "C-c C-e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-c C-a") 'mc/edit-beginnings-of-lines)

(defun context-dependent-compile ()
  (interactive)
  (if (equal major-mode 'python-mode)
      (flymake-compile)
    (compile)))
;; Revert buffer quickly
(global-set-key "\C-c\C-r" 'revert-buffer)

;; Line folding keyboard shortcuts.
(global-set-key "\C-ch" 'hide-subtree)
(global-set-key "\C-cs" 'show-subtree)

;; Clean up whitespace
(global-set-key [f10] 'whitespace-cleanup)

;; Make buffer names unique.
(setq uniquify-buffer-name-style 'reverse)

;; Tabs are evil!
(setq-default indent-tabs-mode nil)

;; Make TAB insert 2 spaces.
(setq c-basic-offset 2)

;; Set the TRAMP default method to SSH
(setq tramp-default-method "ssh")

;; Move backup files into their own dir.
(setq backup-directory-alist '(("." . "~/.emacs-backups")))
(setq backup-by-copying-when-linked t)
(setq vc-make-backup-files t)
(setq auto-save-interval 60)

;; Put the autosave (#foo.txt#) files in their own directory.
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
(make-directory "~/.emacs.d/autosaves/" t)

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight regions and add special behaviors to regions.
;; "C-h d transient" for more info.
(setq transient-mark-mode t)

;; Fix up some of the weird behavior of transient mark mode.
(defun exchange-point-and-mark-no-activate ()
  "Identical to \\[exchange-point-and-mark] but will not activate the region."
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark nil))
(define-key global-map [remap exchange-point-and-mark]
  'exchange-point-and-mark-no-activate)

;; Display line and column numbers above minibuffer.
(setq line-number-mode t)
(setq column-number-mode t)

;; Move to line
(global-set-key "\C-l" 'goto-line) ;; Blows away "recenter"

;; Scroll one line at a time
(global-set-key "\M-n" 'scroll-up-line)
(global-set-key "\M-p" 'scroll-down-line)

;; Ido imenu keybinding
(global-set-key (kbd "C-`") 'ido-goto-symbol)

(blink-cursor-mode 0) ;; no blinking

;; Eval Lisp commands
(global-set-key "\C-ce" 'eval-region)

;; Replace alt for common commands. C-x ENTER to supplement M-x.
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; Replace Alt+< and Alt+> for moving to top/end of buffer
(global-set-key "\C-c," 'beginning-of-buffer)
(global-set-key "\C-c." 'end-of-buffer)
(global-set-key "\C-x," 'beginning-of-buffer)
(global-set-key "\C-x." 'end-of-buffer)

;; Backwards killing!
(global-set-key "\C-c\C-k" 'backward-kill-word)

;; Make C-q copy.
(global-set-key "\C-q" 'kill-ring-save)

;; ORG MODE
;; Various settings inspired by http://doc.norang.ca/org-mode.html
;; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

;; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

;; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode 'both)

;; Org-mode keys
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-ct" 'new-todo)

;; Org mode files
;;(load-file "/home/nick/docs/gtd/org-files.el")
;;(setq todo-file "/home/nick/docs/gtd/dragnet.org")

;; Org capture templates
(setq org-directory "/home/nick/docs/gtd/")
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "/gtd.org") "Tasks")
         "* TODO %?\n %i\n")
        ("l" "Link" plain (file (concat org-directory "/links.org"))
         "- %?\n %x\n")))
(setq org-default-notes-file (concat org-directory "/notes.org"))

;; Org mode TODOs
;; A stuck project is a TODO task that is not DONE and not scheduled.
(setq org-stuck-projects '("TODO={.+}/-DONE" nil nil "SCHEDULED:\\|DEADLINE:"))
(setq org-agenda-todo-ignore-scheduled t)

;; Interaction with the X clipboard.
(global-set-key [f8] 'clipboard-yank)
(global-set-key [f7] 'clipboard-kill-ring-save)
(setq x-select-enable-primary t)
(setq x-select-enable-clipboard t)

;; Easily apply macro to multiple lines
(global-set-key [f5] 'apply-macro-to-region-lines)

;; Clean up excess whitespace in the buffer
(global-set-key [f10] 'whitespace-cleanup)

;; C/C++ header/source toggle
(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key (kbd "C-c o") 'ff-find-other-file)))

(add-hook 'markdown-mode-hook 'auto-fill-mode)

;; Turn off line numbering for certain major modes.
(setq linum-disabled-modes-list '(fundamental-mode eshell-mode wl-summary-mode
                                                   compilation-mode))
(defun linum-on()
  (unless (or (minibufferp) (member major-mode linum-disabled-modes-list))
    (linum-mode 1)))

;; Processing integration
(autoload 'processing-mode "processing-mode" "Processing mode" t)
(add-to-list 'auto-mode-alist '("\\.pde$" . processing-mode))
(setq processing-location "~/Development/Processing/processing-1.2.1")

;; Lua mode
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" .lua-mode))

;; Python mode
;;(load-library "nick-python")
(setq python-indent 2)

;; Python Documentation
(autoload 'pylookup-lookup "pylookup")
(autoload 'pylookup-update "pylookup")

;; Markdown Mode
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

;; TODO Make this relative.
(setq pylookup-program
      "~/.emacs.d/pylookup/pylookup.py")
(setq pylookup-db-file
      "~/.emacs.d/pylookup/pylookup.db")
(global-set-key "\C-c?" 'pylookup-lookup)
(setq browse-url-browser-function 'w3m-browse-url)

;; Word counts.
(load-library "word-count")

;; C++ Assembly name demangling
(defun demangle (&optional b e)
  (interactive "r")
  (shell-command-on-region b e "c++filt"))

;; CEDET Setup
(global-ede-mode t)
(semantic-mode t)

;; (global-semantic-stickyfunc-mode t)
(global-semantic-idle-summary-mode t)
(semantic-add-system-include "/usr/include/Qt/" 'c++-mode)
(semantic-add-system-include "/usr/include/QtCore/" 'c++-mode)
(semantic-add-system-include "/usr/include/QtGui/" 'c++-mode)
(semantic-add-system-include "/usr/include/QtNetwork/" 'c++-mode)

;; (when (file-readable-p "/home/nick/.emacs.d/cedet-projects.el")
;;   (load-file "/home/nick/.emacs.d/cedet-projects.el"))

;; Yasnippet
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

;; More efficient window switching
(defun select-next-window ()
  "Switch to the next window"
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window"
  (interactive)
  (select-window (previous-window)))

(global-set-key (kbd "M-<right>") 'select-next-window)
(global-set-key (kbd "M-<left>")  'select-previous-window)
(global-set-key (kbd "C-x p")  'select-previous-window)

;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
        If no region is selected and current line is not blank and we are
        not at the end of the line, then comment current line.
        Replaces default behaviour of comment-dwim, when it inserts comment at
        the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region
       (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\C-c\C-c" 'comment-dwim-line)

;; Autocomplete
(add-to-list 'load-path "~/.emacs.d/vendor/auto-complete-1.3.1")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             "~/.emacs.d/vendor/auto-complete-1.3.1/dict")
(ac-config-default)

(defun set-ac-sources ()
  "Set the autocomplete sources to match custom configuration."
  (interactive)
  (setq ac-sources '(ac-source-semantic
                     ac-source-yasnippet
                     ac-source-imenu
                     ac-source-words-in-same-mode-buffers)))
(set-ac-sources)

(setq ac-auto-show-menu 0.8)
(setq ac-trigger-key "TAB")

;; Show changes
(global-highlight-changes-mode t)
(setq highlight-changes-visibility-initial-state nil) ;; Hide until requested
(global-set-key (kbd "<f6>") 'toggle-show-changes) ;; toggle change visibility
(global-set-key (kbd "S-<f6>") 'highlight-changes-remove-highlight) ;; remove highlight in region

;; Mutt support
(setq auto-mode-alist
      (append
       '(("/tmp/mutt.*" . mail-mode))
       auto-mode-alist))

;; Set defaults for formatting
(defun programming-defaults ()
;;  (rainbow-mode 1)
  (fci-mode 1)                 ;; Fill Column Indicator
  (setq fill-column 100)
  (setq c-basic-offset 2)
  (setq python-indent-offset 2)
;;  (auto-fill-mode 1)           ;; Automatically wrap comments
  (semantic-stickyfunc-mode 1) ;; Show current function name at the top
  (auto-complete-mode 1)
  (outline-minor-mode 1)
  (yas/minor-mode-on)
  (subword-mode 1)
  (visible-mark-mode 1)
  (global-set-key "\C-c\C-c" 'comment-dwim-line)
  (set-ac-sources)
  (show-project)
;;  (flymake-mode)
  (show-paren-mode t))

;; Rebind ALT Z to toggle zoom in and out of buffer
(global-set-key "\M-z" '(lambda ()
                          (interactive)
                          (set-selective-display (if selective-display nil 3))))
(setq selective-display-depth 1)
(add-hook 'c-mode-common-hook (lambda () (setq selective-display-depth 3)))
(add-hook 'java-mode-common-hook (lambda () (setq selective-display-depth 3)))

;; For some reason, if you don't use the lambda function here semantic won't parse your buffers.
;; If you're getting the error message "Buffer was not set up for parsing", you probably have a hook
;; somewhere that's causing semantic to choke. Check out this thread:
;; http://stackoverflow.com/questions/6782114/disable-cedet-semantic-code-completion-for-lisp-mode
(defun set-programming-defaults-hook ()
  (add-hook 'semantic-init-hook 'programming-defaults t t))

(add-hook 'c-mode-common-hook 'set-programming-defaults-hook)
(add-hook 'python-mode-hook 'set-programming-defaults-hook)
(add-hook 'lua-mode-hook 'set-programming-defaults-hook)
(add-hook 'java-mode-hook 'set-programming-defaults-hook)
(add-hook 'latex-mode-hook 'set-programming-defaults-hook)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq initial-scratch-message
      ";; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.
;;
;; -- Custom Keybindings --
;;
;; The following keybindings are custom-made in init.el:
;; C-<       - Multiple cursors: select instance backward
;; C->       - Multiple cursors: select instance forward
;; C-`       - Search for symbol
;; C-c ,     - Move to beginning of buffer.
;; C-c .     - Move to end of buffer.
;; C-c C-Spc - Ace-jump mode: jump to words by first letter
;; C-c C-c   - Comment region/line
;; C-c C-k   - Kill word backwards. (Same as C-Backspace)
;; C-c C-m   - Same.
;; C-c a     - Org mode: view agenda
;; C-c b     - Org mode: switch buffer
;; C-c c     - Org mode: capture text
;; C-c e     - Evaluate region
;; C-c h     - Hide subtree
;; C-c h     - Python documentation lookup
;; C-c l     - Org mode: store link
;; C-c s     - Show subtree
;; C-c t     - Org mode: new TODO
;; C-l       - Go to line
;; C-q       - Save to kill ring without deleting (copy).
;; C-x ,     - Same.
;; C-x .     - Same.
;; C-x C-m   - Execute command. Supplements M-x.
;; C-x C-y   - Yasnippet expansion
;; C-x p     - Select the previous window
;; M-<left>  - Select the previous window
;; M-<right> - Select the next window
;; M-z       - Collapse/expand all in buffer (not compatible with subtree commands).
;; [f5]      - Apply macro to region lines
;; [f7]      - Save to clipboard
;; [f8]      - Yank from clipboard
;;

;; -- Useful Standard Keybindings --
;; C-c C-x C-a - Org mode: archive entry
;; C-c [   - Org mode: add buffer to agenda list
;; C-h f   - Describe elisp function at point
;; C-x C-x - Exchange point and mark
;; [f3]    - Record macro
;; M-:     - Evaluate elisp sexp
")

(setq gdb-find-source-frame t)
(setq gdb-many-windows t)
(setq gdb-show-main t)
(setq gdb-use-separate-io-buffer t)

(setq fill-column 80)

(setq compilation-scroll-output (quote first-error))
(setq completion-ignored-extensions
      (quote (".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc"
              ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" ".git/" ".bzr/" "CVS/"
              "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem"
              ".x86f" ".sparcf" ".fasl" ".ufsl" ".fsl" ".dxl" ".pfsl" ".dfsl"
              ".p64fsl" ".d64fsl" ".dx64fsl" ".lo" ".la" ".gmo" ".mo" ".toc"
              ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys"
              ".pgs" ".tps" ".vrs" ".pyc" ".pyo" "_archive")))

;; Initializations.
(setq initial-buffer-choice t)

;; When we're not in a GUI we don't want to load custom faces and such.
(if (not (null window-system))
    (progn
      (message "Running in a GUI - loading customizations.")
      (server-start)
      (load custom-file)
      (color-theme-initialize)
      (load-file "~/.emacs.d/vendor/color-theme-soothe.el")
      (global-linum-mode 1))
  ;; TODO extract these into separate functions
  (message "Running in terminal - loading customizations.")
  (load-file "~/.emacs.d/vendor/color-theme-soothe-term.el")
)

;; Google customizations
;; (load-file "~/.emacs.d/google-config.el")
(load-file "~/.emacs.d/nick-google.el")

(setq indent-buffer
   "\C-xh\C-x\C-mindent-region\C-m\C-x\C-x")
(global-set-key "\C-cn" indent-buffer)

(message (format "Configuration loaded in %2.2f seconds." (- (float-time) init-start-time)))
(put 'narrow-to-region 'disabled nil)
