#!/bin/bash
USER=$(whoami)
mkdir -p /tmp/tmux-shared 1>/dev/null 2>&1
chmod 777 /tmp/tmux-shared 1>/dev/null 2>&1
tmux -S /tmp/tmux-shared/$USER new -s $USER -d
tmux -S /tmp/tmux-shared/$USER new -s shared -d
