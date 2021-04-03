SHELL=/bin/bash

INSTALL_DIR := /usr/local/share/tmux-shared
INSTALL_BIN_DIR := /usr/local/bin
TMUX_SHARED_BIN := $(INSTALL_BIN_DIR)/tmux-shared

CONF_DIR := /usr/local/etc
TMUX_SHARED_CONF := $(CONF_DIR)/tmux-shared.conf

EDITOR ?= vi

install:
	cp -r . $(INSTALL_DIR)
	ln -s $(INSTALL_DIR)/tmux-shared.sh $(TMUX_SHARED_BIN)
	cp $(INSTALL_DIR)/tmux-shared.conf.example $(TMUX_SHARED_CONF)

config:
	$(EDITOR) $(TMUX_SHARED_CONF)

uninstall:
	rm -f $(TMUX_SHARED_BIN)
	rm -rf $(INSTALL_DIR)
	rm -f $(TMUX_SHARED_CONF)
