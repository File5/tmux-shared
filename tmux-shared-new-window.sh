#!/bin/bash
USER=$(whoami)

tmux -S /tmp/tmux-shared/$USER new-window -t shared -n $USER

i=0
user_i=0
for u in $(ls /tmp/tmux-shared/); do

if [[ $u == $USER ]]; then
user_i=$i
fi;

if [[ $i -ne 0 ]]; then
tmux -S /tmp/tmux-shared/$USER split-window -v -t shared
fi;

tmux -S /tmp/tmux-shared/$USER send-keys -t shared 'TMUX=' Enter
tmux -S /tmp/tmux-shared/$USER send-keys -t shared "tmux -S /tmp/tmux-shared/$u attach -t $u" Enter

i=$((i+1))

done;

last_window=$(tmux -S /tmp/tmux-shared/$USER list-windows -t shared | tail -1 | cut -d':' -f1)
tmux -S /tmp/tmux-shared/$USER select-pane -t shared:$last_window.$user_i

if [[ $i -gt 2 ]]; then
layout="tiled"
else
layout="even-horizontal"
fi;
tmux -S /tmp/tmux-shared/$USER select-layout -t shared $layout

tmux -S /tmp/tmux-shared/$USER attach -t shared

