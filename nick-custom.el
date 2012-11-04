(defun indent-buffer ()
  "Indent the buffer."
  (interactive)
  (save-excursion 
    (mark-whole-buffer)
    (indent-region (region-beginning) (region-end))))

(defun in-terminal-p () 
  "Detect if Emacs is running in a terminal."
  (not window-system))
