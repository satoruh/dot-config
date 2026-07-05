# -*- mode: makefile-gmake -*-

ifeq ($(shell uname),Darwin)
EMACS ?= /Applications/Emacs.app/Contents/MacOS/Emacs
endif
EMACS ?= emacs

ROOT_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
SRCS := $(shell find $(ROOT_DIR) -type f -name '*.org' -not -name 'README.org')
TARGETS := $(SRCS:.org=)

.PHONY: all
all: $(TARGETS)

%:: %.org
	@echo Generating $@ from $<
	@"$(EMACS)" -Q --batch --eval "(progn (require 'ob-tangle) (org-babel-tangle-file \"$<\" \"$@\"))"
	@touch $@
	@chmod ugo-w $@

.PHONY: stow
stow:
	@mkdir -p ~/.config
	@stow -d .. -t ~/.config $(notdir $(CURDIR))
	@$(MAKE) fc-cache

.PHONY: fc-cache
fc-cache:
	@command -v fc-cache >/dev/null 2>&1 && fc-cache -f || true

.PHONY: clean
clean:
	@rm -f $(TARGETS)
