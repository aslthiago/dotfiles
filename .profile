#
# ~/.profile
#

# Set PATH to include user-local bin directories
export PATH=$PATH$(find $HOME/.local/bin/ -type d -printf ":%p")

# Set custom XAUTHORITY path
export XAUTHORITY=~/.config/X11/.Xauthority

# Set WALLPAPER variable to specify the wallpaper directory
export WALLPAPER=~/.local/wallpaper

# Source ~/.bashrc if it exists
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Auto-start dwm and X server on tty1 if not running
if [[ $(tty) = /dev/tty1 ]]; then
  pgrep dwm || startx ~/.config/X11/xinitrc
fi
