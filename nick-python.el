(add-to-list 'load-path "~/.emacs.d/vendor/dave-loves-python-mode")
(load-library "python")

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
	    interpreter-mode-alist)
      python-mode-hook
      '(lambda () (progn
		    (set-variable 'py-indent-offset 2)
		    (set-variable 'py-smart-indentation nil)
		    (set-variable 'indent-tabs-mode nil) 
		    ;;(highlight-beyond-fill-column)
                    (define-key python-mode-map "\C-m" 'newline-and-indent)
		    ;(pabbrev-mode)
		    ;(abbrev-mode)
                    )))

;; Autofill inside of comments

(defun python-auto-fill-comments-only ()
  (auto-fill-mode 1)
  (set (make-local-variable 'fill-nobreak-predicate)
       (lambda ()
         (not (python-in-string/comment)))))

(add-hook 'python-mode-hook
          (lambda ()
            (python-auto-fill-comments-only)))

;; Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

;; Autocomplete
(add-to-list 'load-path "~/.emacs.d/vendor/auto-complete-1.3.1")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/auto-complete-1.3.1/dict")
(ac-config-default)
(setq ac-sources '(ac-source-symbols
                   ac-source-words-in-same-mode-buffers ac-source-variables
                   ac-source-semantic ac-source-yasnippet))

(ac-ropemacs-initialize)
(add-hook 'python-mode-hook
          (lambda ()
	    (add-to-list 'ac-sources 'ac-source-ropemacs)))

;; Initialize Yasnippet                                                                                        
;; Don't map TAB to yasnippet                                                                                    
;; In fact, set it to something we'll never use because                                                          
;; we'll only ever trigger it indirectly.                                                                        
(setq yas/trigger-key (kbd "C-c <kp-multiply>"))
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

;; Left shift macro.
(fset 'left-shift-region
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([21 45 52 134217848 105 110 100 101 110 116 45 114 105 103 105 100 108 121 return] 0 "%d")) arg)))

;; Right shift macro.
(fset 'right-shift-region
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([21 52 134217848 105 110 100 101 110 116 45 114 105 103 105 100 108 121 return] 0 "%d")) arg)))
