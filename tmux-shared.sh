#!/bin/bash

# find the directory of this script, follow symlinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

function start() {
    $DIR/tmux-shared-init.sh
}

function stop() {
    $DIR/tmux-shared-stop.sh
}

function window() {
    $DIR/tmux-shared-new-window.sh
}

function create() {
    $DIR/create-users.sh
}

function delete() {
    $DIR/delete-users.sh
}

if [[ -z $1 ]]; then
    window
else
    "$@"
fi
