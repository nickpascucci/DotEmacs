;; Customizations relevant to linux systems.

(setq np/system-binaries-directory "/usr/bin/")

(defvar np/notify-program (np/system-path "notify-send"))
(defun np/notify (title &optional message)
  "Send a notification using the system notifier."
  (start-process "notify-send" "*notify-send*" np/notify-program title (or message "")))

(provide 'nick-linux)
