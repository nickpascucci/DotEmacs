;; Jarvis - a personal assistant IRC bot

(require 'nick-custom)
(load-library "erc-robot")
(add-hook 'erc-server-PRIVMSG-functions 'erc-robot-remote t)
(add-hook 'erc-send-completed-hook 'erc-robot-local t)

(defun tasks ()
  (save-excursion
    (org-todo-list nil)
    (trim-string
     (buffer-substring-no-properties (point-min) (point-max)))
    ))

(setq erc-robot-commands
      '(
	("cmds" t (lambda (args)
		  (concat "Commands available: "
			  (mapconcat (lambda (e) (car e))
			   erc-robot-commands " "))))
	("hello" t (lambda (args) "hello to you too!"))
	("echo" t (lambda (args) args))
	("version" t (lambda (args) (erc-version)))
        ("uptime" "nick" (lambda (args) (concat "Sir, the uptime is: " (uptime))))
        ("tasks" "nick" (lambda (args) (concat "Sir, your current task list is: " (tasks))))
      ))

(defun start-jarvis ()
  (erc :server "dogma.nickpascucci.com" :nick (concat (hostname) "-jarvis") :password "asdf")
  (erc-join-channel "#chat"))

(start-jarvis)
