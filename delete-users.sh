#!/bin/bash

if [[ -e /usr/local/etc/tmux-shared.conf ]]; then
    source /usr/local/etc/tmux-shared.conf
else
    # find the directory of this script, follow symlinks
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
        DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

    source $DIR/tmux-shared.conf
fi;

for u in ${TMUX_SHARED_USERS[@]}; do
    echo "Deleting user $u"
    su -c "killall --user $u"
    su -c "deluser $TMUX_SHARED_DELUSER_FLAGS $u"
done;

if [[ $TMUX_SHARED_RM_SHARED_DIR -eq 1 ]]; then
    su -c "rm -r $TMUX_SHARED_DIR"
fi;

su -c "groupdel $TMUX_SHARED_GROUP"

SSHD_CONFIG=/etc/ssh/sshd_config
TMP_FILE=/tmp/edit_sshd_config
awk '/^# BEGIN SECTION of tmux-shared/ {delflag=1} !(delflag) {print;} /^# END SECTION of tmux-shared/ {delflag=0}' "$SSHD_CONFIG" > "$TMP_FILE" && mv "$TMP_FILE" "$SSHD_CONFIG" && rm -f "$TMP_FILE"
