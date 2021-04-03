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

su -c "addgroup $TMUX_SHARED_GROUP"
for u in ${TMUX_SHARED_USERS[@]}; do
echo "Creating user $u"
su -c "adduser $u --gecos '' --ingroup $TMUX_SHARED_GROUP"
# Enter password twice
su -c "cp $DIR/bash_profile /home/$u/.bash_profile"
su -c "chown $u.$TMUX_SHARED_GROUP /home/$u/.bash_profile"
done;

mkdir -p $TMUX_SHARED_DIR
su -c "chgrp $TMUX_SHARED_GROUP $TMUX_SHARED_DIR"
su -c "chmod g+s $TMUX_SHARED_DIR"
su -c "chmod 775 $TMUX_SHARED_DIR"

su -c "cat <<EOF >> /etc/ssh/sshd_config
Match Group $TMUX_SHARED_GROUP
	ForceCommand tmux-shared; exit
EOF"
su -c "systemctl restart sshd"

