(defun indent-buffer ()
  "Indent the buffer."
  (interactive)
  (save-excursion 
    (mark-whole-buffer)
    (indent-region (region-beginning) (region-end))))
