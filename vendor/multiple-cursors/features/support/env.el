(let* ((current-directory (file-name-directory load-file-name))
       (features-directory (expand-file-name ".." current-directory))
       (project-directory (expand-file-name ".." features-directory)))
  (setq multiple-cursors-root-path project-directory)
  (setq multiple-cursors-util-path (expand-file-name "util" project-directory)))

(add-to-list 'load-path multiple-cursors-root-path)
(add-to-list 'load-path (expand-file-name "espuds" multiple-cursors-util-path))
(add-to-list 'load-path (expand-file-name "vendor" multiple-cursors-util-path))

(require 'mark-more-like-this)
(require 'multiple-cursors)
(require 'espuds)
(require 'ert)

(Before
 (mm/clear-all)
 (global-set-key (kbd "C->") 'mark-next-like-this)
 (switch-to-buffer
  (get-buffer-create "*multiple-cursors*"))
 (erase-buffer)
 (transient-mark-mode 1)
 (cua-mode 0)
 (delete-selection-mode 0)
 (setq set-mark-default-inactive nil)
 (deactivate-mark))

(After)
