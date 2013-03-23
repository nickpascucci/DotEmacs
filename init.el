;; First: Remove unnecessary GUI stuff. This prevents flickering of the screen.
(setq inhibit-startup-message t)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(add-to-list 'load-path "~/.emacs.d/extras")
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
(mapc #'org-babel-load-file (directory-files org-custom-library-dir t "\\.org$"))
(mapc #'org-babel-load-file (directory-files dotfiles-dir t "\\.org$"))

(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)
