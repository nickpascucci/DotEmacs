;; Platform-specific configurations.

;; Set up exec path on unix.
(mapc (lambda (s) (add-to-list 'exec-path s))
      (split-string (shell-command-to-string "source $HOME/.bashrc && printf $PATH") ":" t))

(setq np/system-binaries-directory "/usr/bin/")
(defun np/system-path (program) (concat np/system-binaries-directory program))

;; TODO Collect all platform-specific functions here and give them a default behavior of erroring.
(cond ((eq system-type 'darwin) (message "Loading OSX customizations.") (require 'nick-osx))
      ((eq system-type 'gnu/linux) (message "Loading Linux customizations.") (require 'nick-linux))
      (t (message "Unrecognized system type. Not loading system-specific customizations.")))

(setq epg-gpg-program (np/system-path "gpg"))
(setq mu4e-mu-binary (np/system-path "mu"))
(setq w3m-command (np/system-path "w3m"))

(provide 'nick-platform)
