;; Jarvis - a personal assistant IRC bot

(load-library "erc-robot")
(add-hook 'erc-server-PRIVMSG-functions 'erc-robot-remote t)
(add-hook 'erc-send-completed-hook 'erc-robot-local t)

(setq erc-robot-commands
      '(
	("cmds" t (lambda (args)
		  (concat "commands available: "
			  (mapconcat
			   (lambda (e)
			     (car e))
			   erc-robot-commands " "))))
	("hello" t (lambda (args) "hello to you too !"))
	("zippy" t (lambda (args) (erc-replace-regexp-in-string "\n" " " (yow))))
	("echo" t (lambda (args) args))
	; only i'm allowed to talk to my doctor !
	("version" t (lambda (args) (erc-version)))
        ("bow" "nick" (lambda (args) "Yes sir."))
      ))
