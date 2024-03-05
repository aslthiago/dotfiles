#!/bin/sh

LAPTOP="eDP1"
HDMI="HDMI1"

disconnect() {
  echo "--output $LAPTOP --auto --output $HDMI --off"
}

hdmi() {
  echo "--output $LAPTOP --off --output $HDMI --auto"
}

hdmi_left() {
  echo "--output $LAPTOP --auto --output $HDMI --auto --left-of $LAPTOP"
}

hdmi_right() {
  echo "--output $LAPTOP --auto --output $HDMI --auto --right-of $LAPTOP"
}

duplicate() {
  echo "--output $LAPTOP --auto --output $HDMI --auto --same-as $LAPTOP"
}

setup_monitor() {
  case "$1" in
    "disconnect")
      options="$(disconnect)"
      ;;
    "hdmi")
      options="$(hdmi)"
      ;;
    "hdmi-left")
      options="$(hdmi_left)"
      ;;
    "hdmi-right")
      options="$(hdmi_right)"
      ;;
    "duplicate")
      options="$(duplicate)"
      ;;
    *)
      notify-send "Multi Monitor" "Unknown Operation"
      return 1
      ;;
  esac


  # Set the background image using xwallpaper
  xwallpaper --zoom $WALLPAPER/default
  # Execute the generated xrandr command to apply the display configuration
  eval "xrandr $options"
}
