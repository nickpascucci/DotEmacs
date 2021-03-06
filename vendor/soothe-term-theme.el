(deftheme soothe-term
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

       (yellow-1       "#eede4e")
       (yellow-1bg     "#eaea9e")

       (green-1        "#81af34")
       (green-1bg      "#1a2321")
       (green-2        "#4e9f75")
       (green-2bg      "#1a2321")
       (green-3        "#305010")
       (green-3bg      "#507351")

       (turquoise-1    "#11535F")
       (turquoise-2    "#07272D")
       (turquoise-1bg  "#05181C")
       (turquoise-2bg  "#041316")

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
       (background     "#050505")
       (alt-background "#101010")
       (foreground     "#dcdddd")
       (hl-line        "#11151a")
       (selection      "#311500")
      )

  (custom-theme-set-faces
   'soothe-term

   ;; Basics
   `(default                                   ((t (:foreground ,foreground  :background ,background :family "ProggySquareTTSZ" ))))
   `(cursor                                    ((t (                         :background ,gray-2                        ))))
   `(region                                    ((t (:foreground nil          :background ,blue-2                        ))))
   `(highlight                                 ((t (:foreground ,blue-3      :background ,blue-3bg                      ))))
   `(hl-line                                   ((t (                         :background ,hl-line                       ))))
   `(minibuffer-prompt                         ((t (:foreground ,orange-1    :background ,orange-1bg                    ))))
   `(escape-glyph                              ((t (:foreground ,red-1       :background ,purple-1bg                    ))))

   ;; Font-lock stuff
   `(font-lock-builtin-face                    ((t (:foreground ,red-2       :background ,background                    ))))
   `(font-lock-constant-face                   ((t (:foreground ,purple-1    :background ,purple-1bg                    ))))
   `(font-lock-comment-face                    ((t (:foreground ,turquoise-2 :background ,background :italic t          ))))
   `(font-lock-comment-delimiter-face          ((t (:foreground ,turquoise-2 :background ,background :italic t          ))))
   `(font-lock-doc-face                        ((t (:foreground ,blue-3      :background ,background                    ))))
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
   `(mode-line                                 ((t (:foreground ,gray-3      :background ,gray-3bg  :box nil            ))))
   `(mode-line-inactive                        ((t (:foreground ,gray-6      :background ,gray-3bg  :box nil            ))))
   `(vertical-border                           ((t (:foreground ,gray-5      :background ,background                    ))))

   ;; Linum
   `(linum                                     ((t (:foreground ,gray-4    :background ,alt-background :height 90       ))))

   ;; show-paren-mode
   `(show-paren-match                          ((t (:foreground ,green-1    :background ,green-1bg                      ))))
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

   `(hi-yellow                                 ((t (:foreground ,yellow-1    :background ,gray-1bg                      ))))

   ;; EDiff
   `(ediff-current-diff-A                      ((t (:foreground ,black-1     :background ,yellow-1                      ))))
   `(ediff-current-diff-B                      ((t (:foreground ,white-1     :background ,green-1bg                     ))))
   `(ediff-fine-diff-A                         ((t (:foreground ,black-1     :background ,yellow-1                      ))))
   `(ediff-fine-diff-B                         ((t (:foreground ,white-1     :background ,green-2                       ))))
   `(ediff-odd-diff-A                          ((t (:foreground ,black-1     :background ,yellow-1bg                    ))))
   `(ediff-odd-diff-B                          ((t (:foreground ,white-1     :background ,green-3bg                     ))))
   `(ediff-even-diff-A                         ((t (:foreground ,black-1     :background ,yellow-1bg                    ))))
   `(ediff-even-diff-B                         ((t (:foreground ,white-1     :background ,green-3bg                     ))))
   )


  (custom-theme-set-variables
   'soothe-term

   `(powerline-color1 ,gray-6)
   `(powerline-color2 ,gray-3bg)
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

(provide-theme 'soothe-term)
