;; Load directories and custom elisp files.
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/ecb")
(add-to-list 'load-path "~/.emacs.d/pylookup")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/w3m")
(add-to-list 'load-path "~/.emacs.d/vendor")
(add-to-list 'load-path "~/.emacs.d/vendor/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/vendor/processing-emacs")
(add-to-list 'load-path "~/.emacs.d/vendor/solarized")
(add-to-list 'load-path "~/.emacs.d/vendor/magit-1.1.1")
(progn (cd "~/.emacs.d/vendor")
       (normal-top-level-add-subdirs-to-load-path))

(require 'ecb-autoloads) ;; Emacs Code Browser autoloading
(require 'git) ;; Git integration
(require 'magit)

(autoload 'fci-mode "fill-column-indicator" "Show the fill column." t)
(autoload 'ido "ido" "Interactive Do Mode" t)
(autoload 'linum "linum" "Line numbering" t)
(autoload 'magit "magit" "Git integration." t)
(autoload 'markdown-mode "markdown-mode" "Edit markdown files." t)
(autoload 'pylookup "pylookup" "Python documentation." t)
(autoload 'pymacs "pymacs" "Python extensions for emacs." t)
(autoload 'w3m-load "w3m-load" "Pager/Web browser integration." t)
(autoload 'yasnippet "yasnippet" "Snippets for emacs" nil)
(autoload 'yas/initialize "yasnippet" "Yasnippet initialize." nil)
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(autoload 'color-theme-solarized "color-theme-solarized" "Solarized theme." t)


;; UI tweaks.
(global-font-lock-mode t)
(windmove-default-keybindings)
(setq use-file-dialog nil)
(ido-mode t)
(setq ido-ignore-extensions t)

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

;; Display line and column numbers above minibuffer.
(setq line-number-mode t)
(setq column-number-mode t)

;; Move to line
(global-set-key "\C-l" 'goto-line) ;; Blows away "recenter"

;; Turn on line numbering inline.
(global-linum-mode 1)

;; Remove unnecessary GUI stuff
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(blink-cursor-mode 0) ;; no blinking

;; Pretty colors!
(set-background-color "#0F0F0C") ;;"#152033")
(set-face-background 'region "#202020") ;;"#07121C")
(set-face-foreground 'default "gray70")
(set-cursor-color "#404040")

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
(setq auto-mode-alist (cons '("\\.md$" . markdown-mode) auto-mode-alist))

;; TODO Make this relative.
(setq pylookup-program
      "~/.emacs.d/pylookup/pylookup.py")
(setq pylookup-db-file
      "~/.emacs.d/pylookup/pylookup.db")
(global-set-key "\C-c h" 'pylookup-lookup)
(setq browse-url-browser-function 'w3m-browse-url)

;; Word counts.
(load-library "word-count")

;; Set defaults for formatting
(defun programming-defaults ()
      (fci-mode)
      (auto-fill-mode))

(add-hook 'c-mode-hook 'programming-defaults)
(add-hook 'c++-mode-hook 'programming-defaults)
(add-hook 'python-mode-hook 'programming-defaults)
(add-hook 'lua-mode-hook 'programming-defaults)
(add-hook 'java-mode-hook 'programming-defaults)
(add-hook 'latex-mode-hook 'programming-defaults)

;; Initializations.
(add-hook 'after-init-hook '(lambda () (org-agenda-list)))
(setq initial-buffer-choice t)
(switch-to-buffer "*Org Agenda*")
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
 '(ac-use-quick-help nil)
 '(backup-by-copying-when-linked t)
 '(completion-ignored-extensions (quote (".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" ".git/" ".bzr/" "CVS/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".fasl" ".ufsl" ".fsl" ".dxl" ".pfsl" ".dfsl" ".p64fsl" ".d64fsl" ".dx64fsl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo" "_archive")))
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
 '(ido-enable-flex-matching t)
 '(org-agenda-files (quote ("~/docs/gtd/school.org" "~/docs/gtd/distinction-project.org" "~/docs/gtd/reprap-project.org" "~/docs/gtd/privacy-project.org" "~/docs/gtd/mind-studios.org" "~/docs/gtd/life.org" "~/docs/gtd/hydro-project.org" "~/docs/gtd/gtd.org" "~/docs/gtd/sometime.org")))
 '(org-log-done (quote time))
 '(org-stuck-projects (quote ("+LEVEL=2/-DONE" ("TODO" "NEXT" "WAITING") ("FUTURE") "")))
 '(ropemacs-enable-autoimport t)
 '(semantic-complete-inline-analyzer-displayor-class (quote semantic-displayor-ghost)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-analyse-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(ecb-default-highlight-face ((((class color) (background dark)) (:background "seagreen" :foreground "gray"))))
 '(ecb-directory-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(ecb-history-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(ecb-method-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(ecb-source-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
 '(ecb-tag-header-face ((((class color) (background dark)) (:background "SeaGreen1" :foreground "black"))))
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
 '(isearch ((((class color) (min-colors 88) (background dark)) (:background "#3F8208" :foreground "#E4F7FF"))))
 '(lazy-highlight ((((class color) (min-colors 88) (background dark)) (:background "paleturquoise4" :foreground "gray95"))))
 '(mode-line ((((class color) (min-colors 88)) (:background "grey60" :foreground "black" :box (:line-width -1 :style released-button)))))
 '(org-level-2 ((t (:inherit outline-2 :foreground "gray60"))))
 '(org-level-3 ((t (:inherit outline-3 :foreground "purple" :weight normal))))
 '(org-scheduled ((((class color) (min-colors 88) (background dark)) (:foreground "Orange"))))
 '(org-scheduled-today ((((class color) (min-colors 88) (background dark)) (:foreground "Orange"))))
 '(org-todo ((t (:background "#042028" :foreground "#c60007" :weight bold))))
 '(org-upcoming-deadline ((((class color) (min-colors 88) (background dark)) (:foreground "purple"))))
 '(py-builtins-face ((t (:foreground "gray90" :weight bold))) t)
 '(py-pseudo-keyword-face ((t (:foreground "#2E6EA3"))) t))
(put 'upcase-region 'disabled nil)

(ecb-activate)
