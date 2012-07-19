;; Load directories and custom elisp files.
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/jdee-2.4.0.1/lisp")
(add-to-list 'load-path "~/.emacs.d/ecb")
(add-to-list 'load-path "~/.emacs.d/pylookup")
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/vendor/ace-jump-mode")
(add-to-list 'load-path "~/.emacs.d/vendor/expand-region/")
(add-to-list 'load-path "~/.emacs.d/vendor/haskell-mode-2.8.0")
(add-to-list 'load-path "~/.emacs.d/vendor/magit-1.1.1")
(add-to-list 'load-path "~/.emacs.d/vendor/mark-multiple")
(add-to-list 'load-path "~/.emacs.d/vendor/multiple-cursors/")
(add-to-list 'load-path "~/.emacs.d/vendor/processing-emacs")
(let ((default-directory "~/.emacs.d/vendor"))
       (normal-top-level-add-subdirs-to-load-path))

(load "~/.emacs.d/vendor/haskell-mode-2.8.0/haskell-site-file")

(require 'flymake)
(require 'git)
(require 'git-blame)
(require 'magit)
(require 'uniquify)
(require 'w3m-load)
(require 'ace-jump-mode)
(require 'inline-string-rectangle)
(require 'mark-more-like-this)
(require 'multiple-cursors)
(require 'expand-region)

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

;; Ace Jump Mode
(global-set-key (kbd "C-c C-SPC") 'ace-jump-mode)

;; Expand Region
(global-set-key (kbd "C-=") 'er/expand-region)

;; Mark-multiple
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
(global-set-key (kbd "C-M-m") 'mark-more-like-this) ; like the other two, but takes an argument (negative is previous)
(global-set-key (kbd "C-*") 'mark-all-like-this)

;; Multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/add-multiple-cursors-to-region-lines)
(global-set-key (kbd "C-S-c C-e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-S-c C-a") 'mc/edit-beginnings-of-lines)


;; Line folding keyboard shortcuts.
(global-set-key "\C-ch" 'hide-subtree)
(global-set-key "\C-cs" 'show-subtree)

;; Make buffer names unique.
(setq uniquify-buffer-name-style 'reverse)

;; Tabs are evil!
(setq-default indent-tabs-mode nil)

;; Make TAB insert 2 spaces.
(setq c-basic-offset 2)

;; Move backup files into their own dir.
(setq backup-directory-alist '(("." . "~/.emacs-backups")))
(setq backup-by-copying-when-linked t)

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

;; Turn on line numbering inline.
(global-linum-mode 1)

;; Remove unnecessary GUI stuff
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

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

;; Org-mode keys
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; Org mode TODOs
(setq org-stuck-projects '("TODO={.+}/-DONE" nil nil "SCHEDULED:\\|DEADLINE:"))

;; Interaction with the X clipboard.
(global-set-key [f8] 'clipboard-yank)
(global-set-key [f7] 'clipboard-kill-ring-save)

;; Easily apply macro to multiple lines
(global-set-key [f5] 'apply-macro-to-region-lines)

;; C/C++ header/source toggle
(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key (kbd "C-c o") 'ff-find-other-file)))

;; Turn off line numbering for certain major modes.
(setq linum-disabled-modes-list '(fundamental-mode eshell-mode wl-summary-mode
                                                   compilation-mode org-mode))
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

;; Python Documentation
(autoload 'pylookup-lookup "pylookup")
(autoload 'pylookup-update "pylookup")

;; Markdown Mode
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

;; TODO Make this relative.
(setq pylookup-program
      "~/.emacs.d/pylookup/pylookup.py")
(setq pylookup-db-file
      "~/.emacs.d/pylookup/pylookup.db")
(global-set-key "\C-ch" 'pylookup-lookup)
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
(global-semantic-stickyfunc-mode t)
(global-semantic-idle-summary-mode t)


(load-file "/home/nick/.emacs.d/cedet-projects.el")

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
(setq ac-sources '(ac-source-semantic ac-source-yasnippet ac-source-imenu
                                      ac-source-symbols ac-source-variables ac-source-functions
                                      ac-source-words-in-same-mode-buffers))

(setq ac-auto-show-menu 0.8)
(setq ac-auto-start 3)
(setq ac-trigger-key "TAB")
(setq ac-use-quick-help nil)

;; Mutt support
(setq auto-mode-alist
      (append
       '(("/tmp/mutt.*" . mail-mode))
       auto-mode-alist))



;; Set defaults for formatting
(defun programming-defaults ()
  (fci-mode 1)                 ;; Fill Column Indicator
  (setq fill-column 80)
  (auto-fill-mode 1)           ;; Automatically wrap comments
  (semantic-stickyfunc-mode 1) ;; Show current function name at the top
  (auto-complete-mode 1)
  (outline-minor-mode 1)
  (yas/minor-mode-on)
  (subword-mode 1)
  (visible-mark-mode 1)
  (global-set-key "\C-c\C-c" 'comment-dwim-line))

;; Rebind ALT Z to toggle zoom in and out of buffer
(global-set-key "\M-z" '(lambda ()
                          (interactive)
                          (set-selective-display (if selective-display nil 1))))

;; For some reason, if you don't use the lambda function here semantic won't parse your buffers.
;; If you're getting the error message "Buffer was not set up for parsing", you probably have a hook
;; somewhere that's causing semantic to choke. Check out this thread:
;; http://stackoverflow.com/questions/6782114/disable-cedet-semantic-code-completion-for-lisp-mode
(add-hook 'c-mode-common-hook
          '(lambda () (add-hook 'semantic-init-hook 'programming-defaults t t)))
(add-hook 'python-mode-hook
          '(lambda () (add-hook 'semantic-init-hook 'programming-defaults t t)))
(add-hook 'lua-mode-hook
          '(lambda () (add-hook 'semantic-init-hook 'programming-defaults t t)))
(add-hook 'java-mode-hook
          '(lambda () (add-hook 'semantic-init-hook 'programming-defaults t t)))
(add-hook 'latex-mode-hook
          '(lambda () (add-hook 'semantic-init-hook 'programming-defaults t t)))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq initial-scratch-message
      ";; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

;; -- Custom Keybindings --
;; The following keybindings are custom-made in init.el:
;; C-c h   - Hide subtree
;; C-c s   - Show subtree
;; C-l     - Go to line
;; C-`     - Search for symbol
;; C-c e   - Evaluate region
;; C-x C-m - Execute command. Supplements M-x.
;; C-c C-m - Same.
;; C-c ,   - Move to beginning of buffer.
;; C-x ,   - Same.
;; C-c .   - Move to end of buffer.
;; C-x .   - Same.
;; C-c C-k - Kill word backwards. (Same as C-Backspace)
;; C-q     - Save to kill ring without deleting (copy).
;; C-c l   - Org mode: store link
;; C-c c   - Org mode: capture text
;; C-c a   - Org mode: view agenda
;; C-c b   - Org mode: switch buffer
;; [f5]    - Apply macro to region lines
;; [f7]    - Save to clipboard
;; [f8]    - Yank from clipboard
;; C-c h   - Python documentation lookup
;; C-x C-y - Yasnippet expansion
;; M-z     - Collapse/expand all in buffer (not compatible with subtree commands).
;; M-<right> - Select the next window
;; M-<left> - Select the previous window
;; C-x p   - Select the previous window
;; C-c C-c - Comment region/line
")

(setq gdb-find-source-frame t)
(setq gdb-many-windows t)
(setq gdb-show-main t)
(setq gdb-use-separate-io-buffer t)

(setq fill-column 80)

(setq auto-save-interval 60)
(setq backup-by-copying-when-linked t)
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
(cd "~/dev/")

;; When we're not in a GUI we don't want to load custom faces and such.
(when (not (null window-system))
  (message "Running in a GUI - loading customizations.")
  (server-start)
  (load "nick-theme.el")
  (load custom-file))

(setq indent-buffer
   "\C-xh\C-x\C-mindent-region\C-m\C-x\C-x")
(global-set-key "\C-cn" indent-buffer)

;; The regexp-replace patterns used in this macro:
;; \(.*?\)_\([a-zA-Z]\)\(.*?\)
;; \1\,(capitalize \2)\3
(fset 'underline-to-camelcase
   [?\M-x ?m ?a ?r ?k ?- ?e ?s backspace backspace ?s ?e ?x ?p return ?\M-x ?r ?e ?p ?l ?a ?c ?e ?- ?r ?e ?g ?e ?x ?p return ?\\ ?\( ?. ?* ?? ?\\ ?\) ?_ ?\\ ?\( ?\[ ?a ?- ?z ?A ?- ?Z ?\] ?\\ ?\) ?\\ ?\( ?. ?* ?? ?\\ ?\) return ?\\ ?1 ?\\ ?, ?\( ?c ?a ?p ?i ?t ?a ?l ?i ?z ?e ?  ?\\ ?2 ?\) ?  backspace ?\\ ?3 return ?\M-b ?\M-b ?\C-x ?\C-x])


