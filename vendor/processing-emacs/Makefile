# Makefile for processing-emacs.el
#

# Processing.org language based on Java mode. Adds keyword
# highlighting for all recognized Processing language functions.
# Allows compilation of buffers and "sketches" from within Emacs but
# only for more recent versions of Processing.

# Copyright (C) 2008-2011 Rudolf Olah <omouse@gmail.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

EMACS    := emacs
PREFIX   := /usr
ELISPDIR := $(PREFIX)/share/emacs/site-lisp
INSTALL  := install

.PHONY: all install uninstall clean
all: processing-mode.elc

processing-mode.elc: processing-mode.el
	$(EMACS) -batch -q -f batch-byte-compile processing-mode.el

install: processing-mode.elc
	$(INSTALL) processing-mode.elc processing-mode.el $(ELISPDIR)

uninstall:
	rm -f $(ELISPDIR)/processing-mode.elc $(ELISPDIR)/processing-mode.el

clean:
	rm -f processing-mode.elc
