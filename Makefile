# -*- mode: makefile-gmake -*-

EMACS ?= ~/Applications/Emacs.app/Contents/MacOS/Emacs

ROOT_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
SRCS := $(shell find $(ROOT_DIR) -type f -name '*.org')
TARGETS := $(SRCS:.org=)

.PHONY: all
all: $(TARGETS)

%:: %.org
	@echo Generating $@ from $<
	@$(EMACS) -Q --batch --eval "(progn (require 'ob-tangle) (org-babel-tangle-file \"$<\" \"$@\"))"
	@touch $@
	@chmod ugo-w $@

.PHONY: clean
clean:
	@rm -f $(TARGETS)
