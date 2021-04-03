#!/bin/bash

# find the directory of this script, follow symlinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

if [[ -e /usr/local/etc/tmux-shared.conf ]]; then
source /usr/local/etc/tmux-shared.conf
else
source $DIR/tmux-shared.conf
fi;

USER=$(whoami)
TMUX_SHARED_START_DIR="${TMUX_SHARED_START_DIR:-/home/$USER}"
mkdir -p /tmp/tmux-shared 1>/dev/null 2>&1
chmod 777 /tmp/tmux-shared 1>/dev/null 2>&1
(cd "$TMUX_SHARED_START_DIR"; tmux -S /tmp/tmux-shared/$USER new -s $USER -d)
(cd "$TMUX_SHARED_START_DIR"; tmux -S /tmp/tmux-shared/$USER new -s shared -d)
