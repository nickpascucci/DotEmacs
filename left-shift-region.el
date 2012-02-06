(fset 'left-shift-region-safe
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([21 45 52 134217848 105 110 100 101 110 116 45 114 105 103 105 100 108 121 return] 0 "%d")) arg)))
