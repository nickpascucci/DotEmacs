;; First: Remove unnecessary GUI stuff. This prevents flickering of the screen.
(setq inhibit-startup-message t)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Load directories and custom elisp files.
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/cedet-1.1/")
(let ((default-directory "~/.emacs.d"))
  (normal-top-level-add-subdirs-to-load-path))
(let ((default-directory "~/.emacs.d/vendor/"))
  (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'custom-theme-load-path "~/.emacs.d/vendor")

;; Load custom elisp as a dependency for various other customizations.
(require 'nick-custom)

;; Automatically tangle (extract source) and load up all literate org-mode files in this directory.
(setq dotfiles-dir "/home/nick/.emacs.d/")
(setq org-custom-library-dir (expand-file-name "extras" dotfiles-dir))
(mapc #'org-babel-load-file (directory-files org-custom-library-dir t "\\.org$"))
(mapc #'org-babel-load-file (directory-files dotfiles-dir t "\\.org$"))
