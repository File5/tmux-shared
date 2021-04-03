#!/bin/bash
USER=$(whoami)
tmux -S /tmp/tmux-shared/$USER kill-session -t $USER
tmux -S /tmp/tmux-shared/$USER kill-session -t shared
