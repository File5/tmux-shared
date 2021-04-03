# tmux-shared

Utility to start a tmux window shared between multiple users.

![image](https://user-images.githubusercontent.com/14141957/113481872-4ea24b00-949c-11eb-9a45-7f67d26d7d7a.png)

# Problem

`tmux` is great for managing multiple panes, windows and sessions in terminal. It can be used for pair programming through SSH
as suggest some guides on the Internet, and there is even [wemux](https://github.com/zolrath/wemux) for sharing sessions between
users. However, wemux only allows to work separately in different windows, it's impossible to work side-by-side in one window.

# Features

This set of scripts allows:
1. Create Linux users, so teammates can connect with SSH.
2. Create shared folder where each teammate has `rwx` permissions.
3. Create tmux sessions, so each teammate ends up in it right after SSH login (no additional commands needed). Now users can work
simultaneously in the same window or switch to a different window.
4. Stop all tmux-shared sessions.
5. Delete all Linux users.

# Installation

1. Clone the repository
```
git clone https://github.com/File5/tmux-shared.git
```
2. Run `make` inside the folder
```
cd tmux-shared
sudo make
```
This will copy files into `/usr/local/share/tmux-shared` and create `/usr/local/etc/tmux-shared.conf` config file
and `/usr/local/bin/tmux-shared` executable.

# Usage

1. Edit configuration file `/usr/local/etc/tmux-shared.conf`
```
sudo vim /usr/local/etc/tmux-shared.conf
```
2. Create Linux users for all teammates. This will call `useradd` utility, so you will need to provide password for each user.
```
sudo tmux-shared create
```
3. Start tmux sessions. (This will start sessions for all users)
```
sudo tmux-shared start
```
4. **Done!** Now, you can work together. Each teammate can connect with SSH and ends up in own tmux pane.
```
ssh USER@HOST # or
ssh -p PORT USER@HOST
```
Here, if there is no public IP, or it is VM on someone's machine, [ngrok](https://ngrok.com/) can be useful:
```
# Run on host
./ngrok tcp -region=eu 22
```
5. Stop tmux sessions
```
sudo tmux-shared stop
```
6. Delete Linux users (if necessary). This will keep user's home directories and shared directory, but this can be configured.
```
sudo tmux-shared delete
```
