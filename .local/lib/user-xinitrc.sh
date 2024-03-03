#!/bin/bash

# Function to configure displays using xrandr
set_display() {
  # Fetch current display configuration using xrandr
  xrandr_output=$(xrandr)
  # Extract names of connected displays using grep and awk
  display_names=$(echo "$xrandr_output" | grep -oE '^\s*\S+\s+connected' | awk '{print $1}')
  # Count the number of connected displays
  num_displays=$(echo "$display_names" | wc -w)
  # Initialize the xrandr command with base command
  xrandr_command="xrandr"

  # Check if there are more than one connected displays
  if [ "$num_displays" -gt 1 ]; then
    # Iterate through each display name
    for name in $display_names; do
      # Check if the display name contains "HDMI"
      if [[ "$name" =~ HDMI ]]; then
        # Append command to enable and auto-configure HDMI output
        xrandr_command="$xrandr_command --output $name --auto"
      else
        # Append command to turn off non-HDMI outputs
        xrandr_command="$xrandr_command --output $name --off"
      fi
    done
    # Set keyboard layout to US
    setxkbmap us
  else
    # Only one display, set it to auto
    xrandr_command="$xrandr_command --output $display_names --auto"
    # Set keyboard layout to BR
    setxkbmap br
  fi

  # Execute the generated xrandr command to apply the display configuration
  eval "$xrandr_command"
}

# Function to configure touchpad settings
set_touchpad() {
  # Get id of touchpad
  id=$(xinput list | grep "Touchpad" | cut -d'=' -f2 | cut -d'[' -f1)

  enable() {
    # Get id of the corresponding field
    field_id=$(xinput list-props $id | grep "${1} Enabled (" | \
      cut -d'(' -f2 | cut -d')' -f1)

    # Set the property to true
    xinput --set-prop $id $field_id 1
  }

  # Enable tapping functionality for the touchpad
  enable "Tapping"
  # Enable natural scrolling for the touchpad
  enable "Natural Scrolling"
}

main() {
  # Configure display outputs: enable HDMI, turn off others if needed
  set_display

  # Enable the compositor for window transparency and effects
  picom -f &

  # Adjust the screen's color temperature based on the location
  redshift -l -22.37:-43.16 &

  # Automatically hide the mouse cursor after 5 seconds of inactivity
  unclutter --timeout 5 &

  cofre="$HOME/files/Cofre"
  keepassxc --keyfile "$cofre/Chaves" "$cofre/Senhas.kdbx" &

  # Set the background image using xwallpaper
  xwallpaper --zoom $WALLPAPER/default

  # Set keyboard layout to US or BR
  # setxkbmap us
  # setxkbmap br

  # Enable numlock on startup
  numlockx

  # Configure touchpad tap-to-click and natural scrolling
  set_touchpad

  # Launch dwmblocks to display status information on the bar
  dwmblocks &

  # Execute the window manager
  exec dwm
}

main
