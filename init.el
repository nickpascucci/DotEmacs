;; Load directories and custom elisp files.
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/jdee-2.4.0.1/lisp")
(add-to-list 'load-path "~/.emacs.d/ecb")
(add-to-list 'load-path "~/.emacs.d/pylookup")
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/vendor/haskell-mode-2.8.0")
(add-to-list 'load-path "~/.emacs.d/vendor/magit-1.1.1")
(add-to-list 'load-path "~/.emacs.d/vendor/processing-emacs")

(progn (cd "~/.emacs.d/vendor")
       (normal-top-level-add-subdirs-to-load-path))

;; (load-file "~/.emacs.d/cedet-1.0.1/common/cedet.el")
(load "~/.emacs.d/vendor/haskell-mode-2.8.0/haskell-site-file")

;; (require 'ecb-autoloads) ;; Emacs Code Browser autoloading
(require 'flymake)
(require 'git)
(require 'git-blame)
;; (require 'jde)
(require 'magit)
(require 'uniquify)
(require 'w3m-load)

(autoload 'android "android" "Android mode." t)
(autoload 'android-mode "android-mode" "Android mode 2." t)
(autoload 'arduino-mode "arduino-mode" "Arduino mode." t)
(autoload 'coffee-mode "coffee-mode" "CoffeeScript mode." t)
;; (autoload 'color-theme-solarized "color-theme-solarized" "Solarized theme." t)
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

;; UI tweaks.
(global-font-lock-mode t)
(windmove-default-keybindings)
(setq use-file-dialog nil)
(setq ido-ignore-extensions t)
(ido-mode t)


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
(define-key global-map [remap exchange-point-and-mark] 'exchange-point-and-mark-no-activate)

;; Display line and column numbers above minibuffer.
(setq line-number-mode t)
(setq column-number-mode t)

;; Move to line
(global-set-key "\C-l" 'goto-line) ;; Blows away "recenter"

;; Ido imenu keybinding
(global-set-key (kbd "C-`") 'ido-goto-symbol)

;; Turn on line numbering inline.
(global-linum-mode 1)

;; Remove unnecessary GUI stuff
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(blink-cursor-mode 0) ;; no blinking

;; Pretty colors!
(load "nick-theme.el")

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
(load-library "nick-python")

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
(global-set-key "\C-c h" 'pylookup-lookup)
(setq browse-url-browser-function 'w3m-browse-url)

;; Word counts.
(load-library "word-count")

;; CEDET Setup
(global-ede-mode t)
(semantic-mode t)
(global-semantic-stickyfunc-mode t)
(global-semantic-idle-summary-mode t)


;; (load-file "/home/nick/.emacs.d/cedet-projects.el")

;; Yasnippet
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

;; Use hippie-expand rather than normal expansion
(global-set-key "\M-/" 'hippie-expand)
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs
                                         try-expand-list try-expand-line try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

;; Show the mark in all modes
(visible-mark-mode)

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
        If no region is selected and current line is not blank and we are not at the end of the line,
        then comment current line.
        Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\C-c\C-c" 'comment-dwim-line)

;; Set defaults for formatting
(defun programming-defaults ()
      (fci-mode 1)                    ;; Fill Column Indicator
      (auto-fill-mode 1)              ;; Automatically wrap comments
      (semantic-stickyfunc-mode 1)    ;; Show current function name at the top of the buffer
;;      (senator-minor-mode 1)
      (auto-complete-mode 1)
      (outline-minor-mode 1)
      (yas/minor-mode-on))

;; Rebind ALT Z to toggle zoom in and out of buffer
(global-set-key "\M-z" '(lambda () (interactive) (set-selective-display (if selective-display nil 1))))

;; For some reason, if you don't use the lambda function here semantic won't parse your buffers.
;; If you're getting the error message "Buffer was not set up for parsing", you probably have a hook
;; somewhere that's causing semantic to choke. Check out this thread:
;; http://stackoverflow.com/questions/6782114/disable-cedet-semantic-code-completion-for-lisp-mode
(add-hook 'c-mode-common-hook '(lambda () (add-hook 'semantic-init-hook 'programming-defaults t t)))
(add-hook 'python-mode-hook '(lambda () (add-hook 'semantic-init-hook 'programming-defaults t t)))
(add-hook 'lua-mode-hook '(lambda () (add-hook 'semantic-init-hook 'programming-defaults t t)))
(add-hook 'java-mode-hook '(lambda () (add-hook 'semantic-init-hook 'programming-defaults t t)))
(add-hook 'latex-mode-hook '(lambda () (add-hook 'semantic-init-hook 'programming-defaults t t)))

;; Initializations.
(setq initial-buffer-choice t)
(server-start)

;; Have to wait for ECB's CUSTOMIZE variables to be set
;; ecb-activate is below the custom-set-variables block

;;;;;;;;;;;;;;;;;;;;;;
;; END USER CONFIGS ;;
;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 0.8)
 '(ac-auto-start 5)
 '(ac-trigger-key "TAB")
 '(ac-use-quick-help nil)
 '(auto-save-interval 60)
 '(backup-by-copying-when-linked t)
 '(compilation-scroll-output (quote first-error))
 '(completion-ignored-extensions (quote (".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" ".git/" ".bzr/" "CVS/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".fasl" ".ufsl" ".fsl" ".dxl" ".pfsl" ".dfsl" ".p64fsl" ".d64fsl" ".dx64fsl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo" "_archive")))
 '(ecb-auto-activate t)
 '(ecb-compilation-buffer-names (quote (("*Calculator*") ("*vc*") ("*vc-diff*") ("*Apropos*") ("*Occur*") ("\\*[cC]ompilation.*\\*" . t) ("\\*i?grep.*\\*" . t) ("*JDEE Compile Server*") ("*Help*") ("*Completions*") ("*Backtrace*") ("*Compile-log*") ("*Messages*"))))
 '(ecb-compile-window-height 6)
 '(ecb-compile-window-prevent-shrink-below-height nil)
 '(ecb-compile-window-width (quote edit-window))
 '(ecb-layout-name "left3")
 '(ecb-mode-line-data (quote ((ecb-directories-buffer-name . #("Directories" 0 11 (help-echo "Mouse-2 toggles maximizing, mouse-3 displays a popup-menu"))) (ecb-sources-buffer-name . #("Sources" 0 7 (help-echo "Mouse-2 toggles maximizing, mouse-3 displays a popup-menu"))) (ecb-methods-buffer-name . #("Methods" 0 7 (help-echo "Mouse-2 toggles maximizing, mouse-3 displays a popup-menu"))) (ecb-analyse-buffer-name . "Analyze") (ecb-history-buffer-name . "History"))))
 '(ecb-options-version "2.40")
 '(ecb-tip-of-the-day nil)
 '(ecb-windows-width 0.2)
 '(eol-mnemonic-mac "(Mac)")
 '(fill-column 80)
 '(gdb-find-source-frame t)
 '(gdb-many-windows t)
 '(gdb-show-main t)
 '(gdb-use-separate-io-buffer t)
 '(haskell-mode-hook (quote (turn-on-haskell-indentation turn-on-haskell-doc-mode turn-on-haskell-decl-scan)))
 '(ido-enable-flex-matching t)
 '(initial-scratch-message ";; This buffer is for notes you don't want to save, and for Lisp evaluation.
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
;; [f7]    - Save to clipboard
;; [f8]    - Yank from clipboard
;; C-c h   - Python documentation lookup
;; C-x C-y - Yasnippet expansion
;; M-z     - Collapse/expand all in buffer (not compatible with subtree commands).
;; M-<right> - Select the next window
;; M-<left> - Select the previous window
;; C-x p   - Select the previous window
")
 '(jde-jdk-registry (quote (("1.7.0_03-icedtea" . "/usr/lib/jvm/java-7-openjdk/"))))
 '(mail-host-address nil)
 '(org-agenda-files (quote ("~/docs/gtd/hydro-project.org" "~/docs/gtd/school.org" "~/docs/gtd/privacy-project.org" "~/docs/gtd/reprap-project.org" "~/docs/gtd/mind-studios.org" "~/docs/gtd/life.org" "~/docs/gtd/distinction-project.org" "~/docs/gtd/gtd.org")))
 '(org-log-done (quote time))
 '(ropemacs-enable-autoimport t)
 '(semantic-complete-inline-analyzer-displayor-class (quote semantic-displayor-ghost))
 '(spell-command "ispell")
 '(spell-filter nil)
 '(user-mail-address "npascut1@gmail.com")
 '(yas/fallback-behavior (quote call-other-command)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#05151E" :foreground "gray70" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(ecb-analyse-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(ecb-default-highlight-face ((((class color) (background dark)) (:background "seagreen" :foreground "gray"))))
 '(ecb-directory-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(ecb-history-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(ecb-method-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(ecb-source-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(ecb-tag-header-face ((((class color) (background dark)) (:background "SeaGreen1" :foreground "black"))))
 '(error ((t (:foreground "Red" :weight bold))))
 '(flymake-errline ((((class color) (background dark)) (:foreground "firebrick" :underline "firebrick"))))
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background dark)) (:foreground "#F2B705"))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background dark)) (:foreground "green3"))))
 '(font-lock-constant-face ((((class color) (min-colors 88) (background dark)) (:foreground "goldenrod"))))
 '(font-lock-function-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "mediumseagreen"))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background dark)) (:foreground "white" :weight bold))))
 '(font-lock-string-face ((t (:foreground "orange"))))
 '(font-lock-type-face ((((class color) (min-colors 88) (background dark)) (:foreground "chocolate1"))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "#1F8FFF"))))
 '(font-lock-warning-face ((((class color) (min-colors 88) (background dark)) (:foreground "gold" :underline "gold" :weight bold))))
 '(highlight ((((class color) (min-colors 88) (background dark)) (:background "lightseagreen" :foreground "white"))))
 '(isearch ((((class color) (min-colors 88) (background dark)) (:background "#3F8208" :foreground "#E4F7FF"))))
 '(lazy-highlight ((((class color) (min-colors 88) (background dark)) (:background "paleturquoise4" :foreground "gray95"))))
 '(mode-line ((((class color) (min-colors 88)) (:background "grey60" :foreground "black" :box (:line-width -1 :style released-button)))))
 '(org-agenda-done ((((class color) (min-colors 16) (background dark)) (:foreground "green4"))))
 '(org-level-2 ((t (:inherit outline-2 :foreground "gray60"))))
 '(org-level-3 ((t (:inherit outline-3 :foreground "steelblue" :weight normal))))
 '(org-scheduled ((((class color) (min-colors 88) (background dark)) (:foreground "Orange"))))
 '(org-scheduled-previously ((((class color) (min-colors 88) (background dark)) (:foreground "orangered"))))
 '(org-scheduled-today ((((class color) (min-colors 88) (background dark)) (:foreground "Orange"))))
 '(org-todo ((t (:background "#042028" :foreground "#c60007" :weight bold))))
 '(org-upcoming-deadline ((((class color) (min-colors 88) (background dark)) (:foreground "cadetblue"))))
 '(py-builtins-face ((t (:foreground "gray90" :weight bold))) t)
 '(py-pseudo-keyword-face ((t (:foreground "#2E6EA3"))) t)
 '(visible-mark-face ((t (:background "lightgreen" :foreground "black")))))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
