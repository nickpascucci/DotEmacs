;; Customizations, conditionally loaded.
;; See init.el for the details.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum-format "%7i ")
 '(ansi-color-names-vector ["#110F13" "#d13120" "#81af34" "#deae3e" "#7e9fc9" "#a878b5" "#7e9fc9" "#dcdddd"])
 '(ansi-term-color-vector [unspecified "#110F13" "#d13120" "#81af34" "#deae3e" "#7e9fc9" "#a878b5" "#7e9fc9" "#dcdddd"] t)
 '(blink-cursor-mode nil)
 '(comment-auto-fill-only-comments t)
 '(cursor-in-non-selected-windows nil)
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes (quote ("431a117d238045c3af7ba2fa2069cbfee058398b0e006af34f8a9abd023b5a25" "459adf51785592b0ccc46f281ba5fbf139fea82fec272f7688445a203903cb9a" "73cc86da5db70816f2c449eb6d4e1d8bae76727933299b70df626d4bbf97d803" "8cb57414b7ec5ec9ae45f7b6d1345bee91050cff25d85ca6455e6d0f7513b1bf" "613ad46a19030cf61154c016e95c149f3b1f889c1e8cc5c21ec787e9c7f002dd" "2240df341fbc218c9574b1eb9d4992507e15774d06f09f4bda139f070af2a4e2" "bc68e395a12f3d7063ab9a011e59f78312c401b5b06231ddd8cea20144ae6705" "bd2423ffd8a28aac53dbb69b68c8c9c9960ca2e0eabca7c2b590ab54c74f360c" "556081d41a740eb5794eec6406b8ced6116ab22071ce13fe1df9a4a91e13cb09" "43f8e9eb01cb76503c5764ff082d07683b00f0de496d8d48e918e0487cd23f13" "eedabc069027049a787dfa04ac1bb0e312a7a30182baf95ad6be58a80f78c44e" "ef6fbc2d1569fa85c3736be98455a1c9873c10d8ab877a1bb062b55c7f49e0f2" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "612be29b45ee2310c4249206fb5b23c42f408462aa5dbd8212b94969788e0c48" "c0f067dc4274efbb6e72c85eb4df0ea0c66d69488fb46398a8d46077526752b5" "85e923dbd7849e5dfc1b8d253290bac964ccab29f0b72ac7d30a58ca504d5dde" "ed822370bd913439fdd970cc9a09d58077abecaf216aeea066fb9ba4c6e4dea1" "9f58cfcdfb86cef3bbe7c25789f2368078d5f3c582cdfb78d9bb629157a16086" "8dc7b15829bd769bdc720bc36b2715de9ccb5fded92e39724f2a019302059c3b" "7942341d580ac16356b2fe9f99e0592f6c9fc23cb04806a2e4307a7592018696" "46bd6afe5b17f94eda4bd245cab0ebb818c607e09ee3709bbf378dcfb99cb6a8" "d14c3b3f4715fbb5b11b2efcad5967008b92a3faf3799af49acc9806c59ef84e" "9a34aa6ab1f9031e5d4703c3b87b1aa07dba454f1f95f5f2106ef3981f4bb79a" "825b775e2a6a7cc144a9cdc3610e7a6300690a84867d0221c3ae86837f782127" "4f4b7d1d407bbd941e2f0fc4ff7740a07237cb9bd22ad16977274bd10ff98934" "9e05f1ba1094b8a076d4f58e18faeca25521ac9bb67eca23fb5c620991094842" "138bf8ed48cf546e60f6340e44665d39a339808364ce2c7225cd753991ceefd5" "f368ef9b4a87b9314693fa0fbcebaeb2e48c73c74924581b0759c06ac7bb20ce" "2baa8661e282377936e37c54f5765236c4d955544565ee2ee961ae97fa779985" "1d9295c6806bfb6c7826443e0eb1239a83859393ec9c5a8ae7999b07bafa0dc5" "2412d35e20264b23263c4ee8697d7b5c78435751379383beb6017b0159018464" "41c5d4234dc61c66f0f2428992c2e1aa4a0d65f6ad4ec2b8378950209a726723" "990374b9c31b71fe85290066e1fa117eb8816dc824caecdc87973715aa84508b" "de4e66c87f162308463e55e59eda5abf7d717e3f8b125038714b02d8a856ec84" "35d0ddbdd67e6dbced698508a149ecf5be631059dfed67c28e3129da5e06e976" "dfa047912c531e5614be0963c9c80c8c5fad5ada51092b54a6eb35dabe5f43b8" "09dabba20370f8ce732f74ff673bb27ec6451d2ae62ff30f74f24c2e3accfcbf" "65fa7995ed16f548e4bfffea96e1921f3dc172afcb6fb9f46a54a1570ebb44ee" "6afe9abc3d5ab54ab5aea62c8cdb253de43621a923ae0898034349d35e5baf78" "c40275ca137e09d6a021d5a87ad6f96193f191bf7dbaec490e0a96d517e147ed" "fc34df2dde748484cae242d52c9c97ff0e66175ee9a4eb299f1a64ae61282833" "e9403403eed896a2a69735cd454fa45c2d2386a2810f99a9bbedce445cc85279" "057a5d48f7fb642ecd89fd74da6c35e0311d64c6214b3ffeb254a3982f5923fb" default)))
 '(epg-gpg-program "/usr/local/bin/gpg")
 '(fci-rule-character-color "#202020")
 '(fci-rule-color "#202020")
 '(fringe-mode 4 nil (fringe))
 '(gnus-default-nntp-server "news.gmane.org")
 '(gnus-use-full-window nil)
 '(helm-for-files-preferred-list (quote (helm-source-buffers-list helm-source-files-in-current-dir helm-source-recentf helm-source-file-cache helm-source-bookmarks helm-source-locate)))
 '(jabber-alert-info-message-hooks (quote (jabber-info-echo)))
 '(jabber-alert-presence-hooks nil)
 '(jabber-chat-buffer-show-avatar nil)
 '(jabber-roster-line-format " %c %-25n %u %-8s  %S")
 '(jabber-vcard-avatars-retrieve nil)
 '(org-agenda-files (quote ("~/Dropbox/gtd/mobile-inbox.org" "~/Dropbox/gtd/meta.org" "~/Dropbox/gtd/life.org" "~/Dropbox/gtd/dev.org")))
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mhe org-rmail org-w3m org-drill)))
 '(org-src-tab-acts-natively t)
 '(org-src-window-setup (quote current-window))
 '(send-mail-function (quote mailclient-send-it))
 '(w3m-command "/usr/local/bin/w3m")
 '(custom-safe-themes (quote ("fc34df2dde748484cae242d52c9c97ff0e66175ee9a4eb299f1a64ae61282833" "e9403403eed896a2a69735cd454fa45c2d2386a2810f99a9bbedce445cc85279" "057a5d48f7fb642ecd89fd74da6c35e0311d64c6214b3ffeb254a3982f5923fb" default)))
 '(org-agenda-files (quote ("~/todo.org"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#110F13" :foreground "#dcdddd" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "ProggySquareTTSZ"))))
 '(hl-line ((t (:background "#1B2129"))))
 '(jabber-roster-user-away ((t (:foreground "dark orange" :slant italic :weight normal))))
 '(jabber-roster-user-chatty ((t (:foreground "green" :slant normal :weight bold))))
 '(jabber-roster-user-online ((t (:foreground "dark green" :slant normal :weight bold))))
 '(magit-item-highlight ((t (:background "#0a0a0a"))))
 '(org-agenda-dimmed-todo-face ((t (:foreground "dark slate gray"))))
 '(org-column ((t (:background "grey20" :strike-through nil :underline nil :slant normal :weight normal))))
 '(ps-overlay-face ((t (:background "#07272D"))) t))

