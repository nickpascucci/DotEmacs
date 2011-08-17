;; Load directories and custom elisp files.
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/pylookup")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/23m")

;; UI tweaks.
(require 'auto-complete)
(require 'linum)
(require 'yasnippet-bundle)
(require 'pylookup)

(global-font-lock-mode t)
(windmove-default-keybindings)
(setq use-file-dialog nil)

;; Tabs are evil!
(setq-default indent-tabs-mode nil)

;; Make tabs default to 2 spaces.
(setq c-basic-offset 2)

;; Turn off backup files.
(setq make-backup-files nil)

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
;;(set-background-color "gray15")
(set-background-color "black")
(set-face-background 'default "gray15")
(set-face-background 'region "black")
(set-face-foreground 'default "gray80")
(set-face-foreground 'region "gray50")
(set-foreground-color "gray80")

;; Show fill column
(require 'fill-column-indicator)
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

;; Autocomplete
(require 'anything)
(require 'anything-ipython)
(when (require 'anything-show-completion nil t)
  (use-anything-show-completion 'anything-ipython-complete
				'(length initial-pattern)))
(global-set-key [C-tab] 'completion-at-point)

;; Turn off line numbering for certain major modes.
(setq linum-disabled-modes-list '(eshell-mode wl-summary-mode compilation-mode))
(defun linum-on()
  (unless (or (minibufferp) (member major-mode linum-disabled-modes-list))
    (linum-mode 1)))

;; Interpreter interaction.
(require 'comint)

;; Yasnippets
(yas/initialize)
(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)

;; Python mode
(defun python-load-libs ()
  (require 'pymacs)
  (load-library "init-python")
  (message "Done loading python libraries.")
)

;; Make buffer names unique.
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

;; Python Documentation
(autoload 'pylookup-lookup "pylookup")
(autoload 'pylookup-update "pylookup")

;; TODO Make this relative.
(setq pylookup-program
      "~/.emacs.d/pylookup/pylookup.py")
(setq pylookup-db-file
      "~/.emacs.d/pylookup/pylookup.db")
(global-set-key "\C-c h" 'pylookup-lookup)

(require 'w3m-load)
(setq browse-url-browser-function 'w3m-browse-url)


;; Word counts.
(load-library "word-count")

;; Clean up on save.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;;;;;;;;;;;;;;;;;;;;;
;; END USER CONFIGS ;;
;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background dark)) (:foreground "#F2B705"))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background dark)) (:foreground "green3"))))
 '(font-lock-constant-face ((((class color) (min-colors 88) (background dark)) (:foreground "goldenrod"))))
 '(font-lock-function-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "#AD2171"))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background dark)) (:foreground "white" :weight bold))))
 '(font-lock-string-face ((t (:foreground "orange"))))
 '(font-lock-type-face ((((class color) (min-colors 88) (background dark)) (:foreground "chocolate1"))))
 '(font-lock-warning-face ((((class color) (min-colors 88) (background dark)) (:foreground "yellow" :weight bold)))))
(put 'upcase-region 'disabled nil)
