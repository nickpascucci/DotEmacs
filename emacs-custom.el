;; Customizations, conditionally loaded.
;; See init.el for the details.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-start 1)
 '(ac-use-quick-help t)
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "google-chrome")
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
 '(ediff-merge-split-window-function (quote split-window-vertically))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(eol-mnemonic-mac "(Mac)")
 '(flymake-gui-warnings-enabled nil)
 '(global-semantic-idle-scheduler-mode t nil (semantic/idle))
 '(global-semantic-idle-summary-mode t)
 '(global-semanticdb-minor-mode t)
 '(grok-activation-strategy (quote manual))
 '(grok-use-standard-faces t)
 '(haskell-mode-hook (quote (turn-on-haskell-indentation turn-on-haskell-doc-mode turn-on-haskell-decl-scan)))
 '(ido-enable-flex-matching t)
 '(jde-jdk-registry (quote (("1.7.0_03-icedtea" . "/usr/lib/jvm/java-7-openjdk/"))))
 '(mail-host-address nil)
 '(org-agenda-files (quote ("~/todo.org")))
 '(org-log-done (quote time))
 '(powerline-arrow-shape (quote slant))
 '(ropemacs-enable-autoimport t)
 '(semantic-complete-inline-analyzer-displayor-class (quote semantic-displayor-ghost))
 '(semantic-imenu-adopt-external-members nil)
 '(semantic-mode t)
 '(send-mail-function (quote sendmail-send-it))
 '(spell-command "ispell")
 '(spell-filter nil)
 '(use-dialog-box nil)
 '(use-file-dialog nil)
 '(user-mail-address "npascut1@gmail.com")
 '(yas/fallback-behavior (quote call-other-command)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#110F13" :foreground "#dcdddd" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "ProggySquareTTSZ"))))
 '(ediff-current-diff-C ((t (:background "#ffffaa" :foreground "black"))))
 '(minimap-font-face ((t (:height 40 :family "ProggySquareTTSZ"))))
 '(visible-mark-face ((t (:background "lightgreen" :foreground "black"))))
 '(visible-mark-non-trailing-face0 ((t nil)) t))
