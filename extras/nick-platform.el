;; Platform-specific configurations.

(cond ((eq system-type 'darwin) (message "Loading OSX customizations.") (require 'nick-osx))
      ((eq system-type 'gnu/linux) (message "Loading Linux customizations.") (require 'nick-linux))
      (t (message "Unrecognized system type. Not loading system-specific customizations.")))

(provide 'nick-platform)
