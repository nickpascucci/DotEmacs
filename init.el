;; First: Remove unnecessary GUI stuff. This prevents flickering of the screen.
(setq inhibit-startup-message t)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/extras")

(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'nick-custom)

;; Load directories and custom elisp files.
(add-to-list 'load-path "~/.emacs.d/")
(np/prepend-subdirs "~/.emacs.d")
(np/prepend-subdirs "~/.emacs.d/cedet-1.1/")
(np/prepend-subdirs "~/.emacs.d/vendor/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/vendor")

;; Load custom elisp as a dependency for various other customizations.

(require 'org)

;; Automatically tangle (extract source) and load up all literate org-mode files in this directory.
(setq dotfiles-dir "~/.emacs.d/")
(setq org-custom-library-dir (expand-file-name "extras" dotfiles-dir))
(setq org-literate-files (mapcar (lambda (filename) (concat org-custom-library-dir "/" filename))
                                 '("nick-ui.org" "nick-dev.org" "nick-org.org" "nick-comms.org")))
(mapc #'org-babel-load-file org-literate-files)
(mapc #'org-babel-load-file (directory-files dotfiles-dir t "\\.org$"))

(require 'nick-platform)

(add-hook 'after-init-hook '(lambda () (org-tags-view t "#today") (delete-other-windows)))
(let ((google-init "~/.emacs.d/nick-google.el"))
  (when (file-exists-p google-init) (load-file google-init)))
