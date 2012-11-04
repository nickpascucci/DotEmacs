;; Customizations, conditionally loaded.
;; See init.el for the details.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-start 1)
 '(ac-use-quick-help t)
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
 '(global-semantic-idle-scheduler-mode t)
 '(global-semantic-idle-summary-mode t)
 '(global-semanticdb-minor-mode t)
 '(haskell-mode-hook (quote (turn-on-haskell-indentation turn-on-haskell-doc-mode turn-on-haskell-decl-scan)))
 '(ido-enable-flex-matching t)
 '(jde-jdk-registry (quote (("1.7.0_03-icedtea" . "/usr/lib/jvm/java-7-openjdk/"))))
 '(mail-host-address nil)
 '(org-log-done (quote time))
 '(ropemacs-enable-autoimport t)
 '(semantic-complete-inline-analyzer-displayor-class (quote semantic-displayor-ghost))
 '(semantic-mode t)
 '(send-mail-function (quote sendmail-send-it))
 '(spell-command "ispell")
 '(spell-filter nil)
 '(use-dialog-box nil)
 '(use-file-dialog nil)
 '(user-mail-address "npascut1@gmail.com")
 '(yas/fallback-behavior (quote call-other-command)))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "#05151E" :foreground "gray70" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
;;  '(ecb-analyse-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
;;  '(ecb-default-highlight-face ((((class color) (background dark)) (:background "seagreen" :foreground "gray"))))
;;  '(ecb-directory-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
;;  '(ecb-history-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
;;  '(ecb-method-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
;;  '(ecb-source-face ((((class color) (background dark)) (:inherit ecb-default-highlight-face))))
;;  '(ecb-tag-header-face ((((class color) (background dark)) (:background "SeaGreen1" :foreground "black"))))
;;  '(error ((t (:foreground "Red" :weight bold))))
;;  '(flymake-errline ((((class color) (background dark)) (:foreground "firebrick" :underline "firebrick"))))
;;  '(font-lock-builtin-face ((((class color) (min-colors 88) (background dark)) (:foreground "#F2B705"))))
;;  '(font-lock-comment-face ((t (:foreground "green3" :slant italic))))
;;  '(font-lock-constant-face ((((class color) (min-colors 88) (background dark)) (:foreground "goldenrod"))))
;;  '(font-lock-function-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "mediumseagreen"))))
;;  '(font-lock-keyword-face ((((class color) (min-colors 88) (background dark)) (:foreground "white" :weight bold))))
;;  '(font-lock-string-face ((t (:foreground "orange"))))
;;  '(font-lock-type-face ((((class color) (min-colors 88) (background dark)) (:foreground "chocolate1"))))
;;  '(font-lock-variable-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "#1F8FFF"))))
;;  '(font-lock-warning-face ((((class color) (min-colors 88) (background dark)) (:foreground "gold" :underline "gold" :weight bold))))
;;  '(highlight ((t (:background "#000040" :foreground "gray80"))))
;;  '(isearch ((((class color) (min-colors 88) (background dark)) (:background "#3F8208" :foreground "#E4F7FF"))))
;;  '(lazy-highlight ((((class color) (min-colors 88) (background dark)) (:background "paleturquoise4" :foreground "gray95"))))
;;  '(mode-line ((((class color) (min-colors 88)) (:background "grey60" :foreground "black" :box (:line-width -1 :style released-button)))))
;;  '(org-agenda-done ((((class color) (min-colors 16) (background dark)) (:foreground "green4"))))
;;  '(org-level-2 ((t (:inherit outline-2 :foreground "gray60"))))
;;  '(org-level-3 ((t (:inherit outline-3 :foreground "steelblue" :weight normal))))
;;  '(org-scheduled ((((class color) (min-colors 88) (background dark)) (:foreground "Orange"))))
;;  '(org-scheduled-previously ((((class color) (min-colors 88) (background dark)) (:foreground "orangered"))))
;;  '(org-scheduled-today ((((class color) (min-colors 88) (background dark)) (:foreground "Orange"))))
;;  '(org-todo ((t (:background "#042028" :foreground "#c60007" :weight bold))))
;;  '(org-upcoming-deadline ((((class color) (min-colors 88) (background dark)) (:foreground "cadetblue"))))
;;  '(py-builtins-face ((t (:foreground "gray90" :weight bold))) t)
;;  '(py-pseudo-keyword-face ((t (:foreground "#2E6EA3"))) t)
;;  '(region ((t (:background "#005050"))))
;;  '(visible-mark-face ((t (:background "lightgreen" :foreground "black")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(visible-mark-face ((t (:background "gray40")))))
