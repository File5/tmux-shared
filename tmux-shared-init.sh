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

for u in ${TMUX_SHARED_USERS[@]}; do
echo $u
su -c $DIR/tmux-shared-stop-user.sh $u
su -c $DIR/tmux-shared-run-user.sh $u
done;
