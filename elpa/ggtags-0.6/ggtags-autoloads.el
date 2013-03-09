;;; ggtags-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (ggtags-build-imenu-index ggtags-mode ggtags-find-tag
;;;;;;  ggtags-tag-names ggtags-root-directory) "ggtags" "ggtags.el"
;;;;;;  (20789 25724))
;;; Generated autoloads from ggtags.el

(autoload 'ggtags-root-directory "ggtags" "\


\(fn)" nil nil)

(autoload 'ggtags-tag-names "ggtags" "\
Get a list of tag names starting with PREFIX.

\(fn &optional PREFIX)" nil nil)

(autoload 'ggtags-find-tag "ggtags" "\
Find definitions or references to tag NAME by context.
If point is at a definition tag, find references, and vice versa.
When called with prefix, ask the name and kind of tag.

\(fn NAME &optional VERBOSE)" t nil)

(autoload 'ggtags-mode "ggtags" "\
Toggle Ggtags mode on or off.
With a prefix argument ARG, enable Ggtags mode if ARG is
positive, and disable it otherwise.  If called from Lisp, enable
the mode if ARG is omitted or nil, and toggle it if ARG is `toggle'.
\\{ggtags-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'ggtags-build-imenu-index "ggtags" "\
A function suitable for `imenu-create-index-function'.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("ggtags-pkg.el") (20789 25724 783330))

;;;***

(provide 'ggtags-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ggtags-autoloads.el ends here
