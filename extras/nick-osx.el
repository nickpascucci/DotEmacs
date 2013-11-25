(setq np/system-binaries-directory "/usr/local/bin/")

(defun np/notify (title message)
  "Send a notification using the system notifier."
  (call-process "/usr/local/opt/ruby/bin/terminal-notifier" 
                nil nil nil "-message" message "-title" title))

(provide 'nick-osx)

