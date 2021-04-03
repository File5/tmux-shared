#!/bin/bash
USER=$(whoami)
tmux -S /tmp/tmux-shared/$USER kill-session -t $USER 2>/dev/null
tmux -S /tmp/tmux-shared/$USER kill-session -t shared 2>/dev/null
