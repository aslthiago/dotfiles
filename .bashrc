#
# ~/.bashrc
#

[[ $- != *i* ]] && return
shopt -s autocd
set -o vi

PS1='[\u \[\033[;33m\]\W\[\033[0m\]]\$ '
HISTSIZE= HISTFILESIZE=
HISTFILE=~/.cache/bash_history

export LESSHISTFILE=~
export VISUAL=nvim
export EDITOR=nvim

alias \
  ...='cd ../..' \
  ..='cd ..' \
  cp='cp -iv' \
  mv='mv -iv' \
  rm='rm -vI' \
  mkd='mkdir -pv' \
  ls='ls -hN --color=auto --group-directories-first' \
  l='ls -l' \
  la='l -a' \
  grep='grep --color=auto' \
  diff='diff --color=auto'

alias \
  p='sudo pacman' \
  pp='p -S' \
  s='sudo systemctl' \
  sdn='sudo shutdown -h now' \
  mirror='sudo reflector -c Brazil -c Worldwide -a 12 -p https -p http --sort rate --save /etc/pacman.d/mirrorlist'

alias \
  g='git' \
  ga='g add' \
  gap='g add -p' \
  gs='g status' \
  gas='g commit' \
  gg='gas -S' \
  gl='g log' \
  gll='gl --oneline --graph --all' \
  gp='g push' \
  gpp='g pull' \
  gb='g branch' \
  gk='g checkout' \
  gkb='gk -b' \
  gc='g clone' \
  gcp='g cherry-pick' \
  gw='g switch' \
  gr='g restore' \
  grp='g restore -p' \
  grs='gr --staged' \
  grsp='gr --staged -p' \
  ge='g diff' \
  ges='ge --staged' \
  gm='g merge'

alias \
  ffmpeg='ffmpeg -hide_banner' \
  yt='yt-dlp --add-metadata -i' \
  yta='yt -x -f bestaudio/best' \
  yv='yt -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' \
  mpv='mpv --no-audio-display' \
  z='zathura' \
  bc='bc -ql' \
  tgc='tar -czvf' \
  tgx='tar -xzvf' \
  v='$EDITOR' \
  ipp='curl ifconfig.me'
