(require 'syntax)

(defun np/empty-to-nil (string)
  (when (not (s-blank? string))
      string))

(defun prog/in-comment-p ()
  (not (null (nth 8 (syntax-ppss)))))

(provide 'nick-prog-utils)
