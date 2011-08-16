;; Load directories and custom elisp files.
(add-to-list 'load-path "~/.emacs.d/")

;; UI tweaks.
(global-font-lock-mode t)
(windmove-default-keybindings)
(setq use-file-dialog nil)

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; No backups
(setq make-backup-files nil)

;; Highlight regions and add special behaviors to regions.
;; "C-h d transient" for more info.
(setq transient-mark-mode t)

;; Display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Move to line
(global-set-key "\C-l" 'goto-line) ;; Blows away "recenter"

;; Remove unnecessary GUI stuff
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(blink-cursor-mode 0) ;; no blinking

(set-background-color "gray10")
(set-face-background 'default "gray10")
(set-face-background 'region "black")
(set-face-foreground 'default "gray80")
(set-face-foreground 'region "gray50")
(set-foreground-color "gray80")

;; Show fill column

(require 'fill-column-indicator)

;; Replace alt for common commands.
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; Backwards killing!
(global-set-key "\C-x\C-k" 'backward-kill-word)
(global-set-key "\C-c\C-k" 'backward-kill-word)

;; Fast move.
(global-set-key "\C-x," 'beginning-of-buffer)
(global-set-key "\C-x." 'end-of-buffer)

;; Slightly different copy pasting. Overrides character insertion.
(global-set-key "\C-q" 'kill-ring-save)

;; Python development tools.
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

;; Turn on line numbering
(require 'linum)
(global-linum-mode 1)

;; Turn off line numbering for certain major modes.
(setq linum-disabled-modes-list '(eshell-mode wl-summary-mode compilation-mode))
(defun linum-on()
  (unless (or (minibufferp) (member major-mode linum-disabled-modes-list))
    (linum-mode 1)))




;; Make buffer names unique.
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

;; Tabs are evil!
(setq-default indent-tabs-mode nil)

;; Make tabs default to 2 spaces.
(setq c-basic-offset 2)

;; Error highlighting
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pyflakes-init)))

;; Python Mode
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(nuke-trailing-whitespace-always-major-modes (quote (ada-mode c++-mode c-mode change-log-mode cperl-mode emacs-lisp-mode fortran-mode latex-mode lisp-interaction-mode lisp-mode makefile-mode nroff-mode perl-mode plain-tex-mode prolog-mode scheme-mode sgml-mode tcl-mode slitex-mode sml-mode texinfo-mode python-mode)))
 '(nuke-trailing-whitespace-in-hooks (quote (write-file-hooks)) nil (nuke-trailing-whitespace))
 '(nuke-trailing-whitespace-p nil)
 '(py-indent-offset 2)
 '(py-smart-indentation nil)
 '(python-indent 2))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:height 100 :family "DejaVu Sans Mono"))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background dark)) (:foreground "royal blue")))))
