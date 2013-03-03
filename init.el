;; First: Remove unnecessary GUI stuff.
(setq inhibit-startup-message t)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Load directories and custom elisp files.
(add-to-list 'load-path "~/.emacs.d/")
(let ((default-directory "~/.emacs.d"))
  (normal-top-level-add-subdirs-to-load-path))
(let ((default-directory "~/.emacs.d/vendor/"))
  (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'custom-theme-load-path "~/.emacs.d/vendor")

(load "~/.emacs.d/vendor/haskell-mode-2.8.0/haskell-site-file")

;; Load up all literate org-mode files in this directory
(setq dotfiles-dir "/home/nick/.emacs.d/")
(setq org-custom-library-dir (expand-file-name "extras" dotfiles-dir))
(mapc #'org-babel-load-file (directory-files org-custom-library-dir t "\\.org$"))
(mapc #'org-babel-load-file (directory-files dotfiles-dir t "\\.org$"))

(require 'ecb-autoloads)
(require 'flymake)
(require 'magit)
(require 'uniquify)
(require 'org-drill)
(require 'tramp)
(require 'uniquify)
(require 'repeat)
(require 'smartparens)

(require 'nick-custom)

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
