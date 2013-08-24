(deftheme soothe
  "sooth-theme
   Created : Tue Jul 17 18:21:38 2012 - Jason Milkins.
   licence : MIT

   An amalgam of muted color tones and highlighted backgrounds.
   Also has support for rainbow-delimiters")

(let  (
       ;; named colors
       (white-1         "#ffffff")
       (black-1         "#000000")

       (gray-1         "#828282")
       (gray-1bg       "#0a0a0a")
       (gray-2         "#333333")
       (gray-2bg       "#111111")
       (gray-3         "#aaaaaa")
       (gray-3bg       "#141414")
       (gray-4         "#252525")
       (gray-4bg       "#171717")
       (gray-5         "#2a2a2a")
       (gray-5bg       "#1a1a1a")
       (gray-6         "#202020")
       (gray-6bg       "#1e1e1e")

       (red-1          "#d13120")
       (red-1bg        "#1D1515")
       (red-2          "#b23f1e")
       (red-2bg        "#251c1e")
       (red-3          "#823030")
       (red-3bg        "#251c1e")

       (brown-1        "#9f621d")
       (brown-1bg      "#2a1f1f")

       (orange-1       "#d97a35")
       (orange-1bg     "#1F1710")

       (yellow-1       "#deae3e")
       (yellow-1bg     "#18140C")
       (yellow-2       "#deae3e")
       (yellow-2bg     "#4e4e00")

       (green-1        "#81af34")
       (green-1bg      "#1a2321")
       (green-2        "#4e9f75")
       (green-2bg      "#1a2321")
       (green-3        "#30C010")
       (green-3bg      "#1a2321")

       (turquoise-1    "#11535F")
       (turquoise-2    "#07272D")
       (turquoise-1bg  "#05181C")
       (turquoise-2bg  "#041316")
       (turquoise-3    "#114040")

       (blue-1         "#7e9fc9")
       (blue-1bg       "#1e252f")
       (blue-2         "#417598")
       (blue-2bg       "#1b333e")
       (blue-3         "#00959e")
       (blue-3bg       "#132228")
       (blue-4         "#365e7a")
       (blue-4bg       "#172028")

       (purple-1       "#a878b5")
       (purple-1bg     "#1D1B25")

       ;; special colors
       (background     "#110F13")
       (alt-background "#111013")
       (foreground     "#dcdddd")
       (hl-line        "#1B2129")
       (selection      "#517500")
      )

  (custom-theme-set-faces
   'soothe

   ;; Basics
   `(default                                   ((t (:foreground ,foreground  :background ,background                    ))))
   `(cursor                                    ((t (                         :background ,gray-2                        ))))
   `(region                                    ((t (:foreground nil          :background ,selection                     ))))
   `(highlight                                 ((t (                         :background ,blue-3bg                      ))))
   `(hl-line                                   ((t (                         :background ,hl-line                       ))))
   `(minibuffer-prompt                         ((t (:foreground ,orange-1    :background ,orange-1bg                    ))))
   `(escape-glyph                              ((t (:foreground ,red-1       :background ,purple-1bg                    ))))

   ;; Font-lock stuff
   `(font-lock-builtin-face                    ((t (:foreground ,red-2       :background ,background                    ))))
   `(font-lock-constant-face                   ((t (:foreground ,purple-1    :background ,purple-1bg                    ))))
   `(font-lock-comment-face                    ((t (:foreground ,turquoise-1 :background ,alt-background :italic t      ))))
   `(font-lock-comment-delimiter-face          ((t (:foreground ,turquoise-1 :background ,alt-background :italic t      ))))
   `(font-lock-doc-face                        ((t (:foreground ,blue-3      :background ,gray-1bg                      ))))
   `(font-lock-doc-string-face                 ((t (:foreground ,blue-3      :background ,gray-1bg                      ))))
   `(font-lock-function-name-face              ((t (:foreground ,blue-2      :background ,blue-2bg                      ))))
   `(font-lock-keyword-face                    ((t (:foreground ,orange-1    :background ,background                    ))))
   `(font-lock-negation-char-face              ((t (:foreground ,yellow-1    :background ,yellow-1bg                    ))))
   `(font-lock-preprocessor-face               ((t (:foreground ,orange-1    :background ,background                    ))))
   `(font-lock-string-face                     ((t (:foreground ,green-2     :background ,background                    ))))
   `(font-lock-type-face                       ((t (:foreground ,turquoise-1 :background ,background :bold nil          ))))
   `(font-lock-variable-name-face              ((t (:foreground ,blue-1      :background ,background                    ))))
   `(font-lock-warning-face                    ((t (:foreground ,red-2       :background ,red-2bg                       ))))

   ;; UI related
   `(link                                      ((t (:foreground ,blue-1      :background ,blue-1bg                      ))))
   `(fringe                                    ((t (                         :background ,gray-3bg                      ))))
   `(mode-line                                 ((t (:foreground ,gray-3      :background ,turquoise-3  :box nil         ))))
   `(mode-line-inactive                        ((t (:foreground ,gray-2      :background ,gray-3bg  :box nil            ))))
   `(mode-line-buffer-id                       ((t (:foreground ,gray-3      :box nil                                   ))))
   `(vertical-border                           ((t (:foreground ,gray-5      :background ,background                    ))))

   ;; Linum
   `(linum                                     ((t (:foreground ,gray-2      :background ,alt-background :height 90     ))))

   ;; show-paren-mode
   `(show-paren-match                          ((t (:foreground ,green-1     :background ,green-1bg                     ))))
   `(show-paren-mismatch                       ((t (:foreground ,red-2bg     :background ,red-2                         ))))

   ;; ido
   `(ido-only-match                            ((t (:foreground ,green-1     :background ,green-1bg                     ))))
   `(ido-subdir                                ((t (:foreground ,purple-1    :background ,purple-1bg                    ))))

   ;; whitespace-mode
   `(whitespace-empty                          ((t (:foreground ,yellow-1bg  :background ,yellow-1                      ))))
   `(whitespace-hspace                         ((t (:foreground ,gray-2                                                 ))))
   `(whitespace-indentation                    ((t (:foreground ,gray-2                                                 ))))
   `(whitespace-line                           ((t (                         :background ,gray-2                        ))))
   `(whitespace-newline                        ((t (:foreground ,gray-2                                                 ))))
   `(whitespace-space                          ((t (:foreground ,gray-2                                                 ))))
   `(whitespace-space-after-tab                ((t (:foreground ,gray-2                                                 ))))
   `(whitespace-tab                            ((t (:foreground ,gray-2                                                 ))))
   `(whitespace-trailing                       ((t (:foreground ,red-1bg     :background ,red-1                         ))))

   ;; flyspell-mode
   `(flyspell-incorrect                        ((t (:underline ,red-2                                                   ))))
   `(flyspell-duplicate                        ((t (:underline ,red-2                                                   ))))

   ;; magit
   `(magit-diff-add                            ((t (:foreground ,green-1                                                ))))
   `(magit-diff-del                            ((t (:foreground ,red-2                                                  ))))
   `(magit-item-highlight                      ((t (                         :background ,gray-1bg                      ))))

   ;; highlight-indentation-mode
   `(highlight-indentation-face                ((t (                         :background ,gray-1bg                      ))))
   `(highlight-indentation-current-column-face ((t (                         :background ,gray-4                        ))))

   ;; highlight-changes-mode
   `(highlight-changes-face                    ((t (:foreground ,green-1                                                ))))
   `(highlight-changes-delete-face             ((t (:foreground ,red-3                                                  ))))

   ;; ECB
   `(ecb-default-general-face                  ((t (:foreground ,gray-3      :background ,gray-1bg                      ))))
   `(ecb-default-highlight-face                ((t (:foreground ,red-1       :background ,red-1bg                       ))))
   `(ecb-method-face                           ((t (:foreground ,red-1       :background ,red-1bg                       ))))
   `(ecb-tag-header-face                       ((t (                         :background ,blue-2bg                      ))))

   ;; org-mode
   `(org-date                                  ((t (:foreground ,purple-1    :background ,purple-1bg                    ))))
   `(org-done                                  ((t (:foreground ,green-1     :background ,green-1bg                     ))))
   `(org-hide                                  ((t (:foreground ,gray-2      :background ,gray-1bg                      ))))
   `(org-link                                  ((t (:foreground ,blue-1      :background ,blue-1bg                      ))))
   `(org-todo                                  ((t (:foreground ,red-1       :background ,red-1bg                       ))))
   `(org-scheduled-today                       ((t (:foreground ,foreground  :background ,background                    ))))
   `(org-scheduled                             ((t (:foreground ,gray-1      :background ,background                    ))))
   `(org-block-begin-line                      ((t (:foreground ,purple-1    :background ,gray-1bg                      ))))
   `(org-block-background                      ((t (                         :background ,gray-1bg                      ))))
   `(org-block-end-line                        ((t (:foreground ,purple-1    :background ,gray-1bg                      ))))
   `(org-column-face                           ((t (:foreground ,purple-1    :background ,gray-1bg                      ))))

   ;; Ediff
   `(ediff-current-diff-A                      ((t (:foreground ,yellow-1    :background ,yellow-1bg                    ))))
   `(ediff-current-diff-B                      ((t (:foreground ,green-3     :background ,green-3bg                     ))))
   `(ediff-fine-diff-A                         ((t (:foreground ,black-1     :background ,yellow-1                      ))))
   `(ediff-fine-diff-B                         ((t (:foreground ,white-1     :background ,green-2                       ))))
   `(ediff-odd-diff-A                          ((t (:foreground ,black-1     :background ,yellow-1bg                    ))))
   `(ediff-odd-diff-B                          ((t (:foreground ,gray-3      :background ,green-3bg                     ))))
   `(ediff-even-diff-A                         ((t (:foreground ,black-1     :background ,yellow-1bg                    ))))
   `(ediff-even-diff-B                         ((t (:foreground ,gray-3      :background ,green-3bg                     ))))

   ;; Eshell
   `(eshell-prompt-face                        ((t (:foreground ,blue-2                                                 ))))

   ;; ERC
   ;; erc-action-face 	erc-bold-face
   ;; erc-button 	erc-command-indicator-face
   ;; erc-current-nick-face 	erc-dangerous-host-face
   ;; erc-default-face 	erc-direct-msg-face
   ;; erc-error-face 	erc-fool-face
   ;; erc-header-line 	erc-input-face
   ;; erc-inverse-face 	erc-keyword-face
   ;; erc-my-nick-face 	erc-nick-default-face
   ;; erc-nick-msg-face 	erc-notice-face
   ;; erc-pal-face 	erc-prompt-face
   ;; erc-timestamp-face 	erc-underline-face
   `(erc-notice-face                           ((t (:foreground ,blue-2                                                 ))))
   `(erc-nick-default-face                     ((t (:foreground ,gray-3                                                 ))))
   `(erc-timestamp-face                        ((t (:foreground ,green-3                                                ))))
   `(erc-my-nick-face                          ((t (:foreground ,turquoise-1                                            ))))
   `(erc-input-face                            ((t (:foreground ,turquoise-1                                            ))))

   `(jabber-chat-prompt-local                  ((t (:foreground ,turquoise-1                                            ))))
   `(jabber-chat-prompt-foreign                ((t (:foreground ,green-1                                                ))))

   ;; Visible-mark-mode
   `(visible-mark-face                         ((t (:foreground ,foreground    :background ,turquoise-1                 ))))

   `(powerline-active1                         ((t (:foreground ,foreground    :background ,gray-6                      ))))
   `(powerline-active2                         ((t (:foreground ,foreground    :background ,gray-3bg                    ))))
   `(powerline-inactive1                       ((t (:foreground ,gray-2        :background ,gray-6                      ))))
   `(powerline-inactive2                       ((t (:foreground ,gray-2        :background ,gray-3bg                    ))))

   '(ace-jump-face-background ((t (:foreground "gray15"))))
   '(ace-jump-face-foreground ((t (:foreground "orange"))))
   )


  (custom-theme-set-variables
   'soothe

   `(Linum-format "%7i ")
   `(fringe-mode 4)

   ;; Fill Column Indicator mode
   `(fci-rule-color ,gray-6)
   `(fci-rule-character-color ,gray-6)

   `(ansi-color-names-vector
     ;; black, red, green, yellow, blue, magenta, cyan, white
     [,background ,red-1 ,green-1 ,yellow-1 ,blue-1 ,purple-1 ,blue-1 ,foreground])
   `(ansi-term-color-vector
     ;; black, red, green, yellow, blue, magenta, cyan, white
     [unspecified ,background ,red-1 ,green-1 ,yellow-1 ,blue-1 ,purple-1 ,blue-1 ,foreground])
   )
  )

;; Rainbow delimiters

(defun soothe-rainbow-delim-set-face ()
  (set-face-attribute 'rainbow-delimiters-depth-1-face   nil :foreground "#30828F" )
  (set-face-attribute 'rainbow-delimiters-depth-2-face   nil :foreground "#2c7580" )
  (set-face-attribute 'rainbow-delimiters-depth-3-face   nil :foreground "#276872" )
  (set-face-attribute 'rainbow-delimiters-depth-4-face   nil :foreground "#225B64" )
  (set-face-attribute 'rainbow-delimiters-depth-5-face   nil :foreground "#1D4E55" )
  (set-face-attribute 'rainbow-delimiters-depth-6-face   nil :foreground "#184147" )
  (set-face-attribute 'rainbow-delimiters-depth-7-face   nil :foreground "#133439" )
  (set-face-attribute 'rainbow-delimiters-unmatched-face nil :foreground "#eF3000" )
  )
(eval-after-load "rainbow-delimiters" '(soothe-rainbow-delim-set-face))

(provide-theme 'soothe)
