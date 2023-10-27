#!/bin/bash
# If app is already running, focus it. Otherwise, launch it and focus it.

app_name="bruno";
app="$HOME/.local/bin/bruno";

# If the app is already running, focus it.
if [ "$(swaymsg -t get_tree | grep -c ": \"$app_name\"")" -gt 0 ]; then
    swaymsg "[class=\"$app_name\"] scratchpad show";
    # Otherwise, launch it and focus it.
else
    notify-send $'App not started\n'"Launching $app_name...";
    eval "${app}" &>/dev/null & disown;
    sleep 2.5;
    swaymsg "[class=\"$app_name\"] scratchpad show";
fi
