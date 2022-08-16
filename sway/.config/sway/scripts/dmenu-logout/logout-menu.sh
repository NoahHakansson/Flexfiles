#!/usr/bin/env bash

# dmenu theming
lines="-l 5"
font="-fn JetBrainsMonoNerdFont-15"
colors="-nb #1f2227 -nf #9899a0 -sb #61afef -sf #2c323e"
tofi_lines="--num-results 5"
tofi_font="--font JetBrainsMonoNerdFont-15"
tofi_colors="--background-color #1f2227 --border-color #61afef --text-color #9899a0 --selection-background #61afef --selection-color #2c323e"

first_prompt="Logout menu"
opt1="Lock\nSuspend\nReboot\nShutdown\nLogout"
opt2="Yes\nNo"

style="$HOME/.config/sway/scripts/dmenu-logout/style-logout.css"
tofi_conf="$HOME/.config/sway/scripts/dmenu-logout/tofi-theme.cfg"

# wofi
# ask() {
#     answer="$( echo -e $1 | wofi --gtk-dark --insensitive --style $style --prompt="" --dmenu $2 )"
# }

# dmenu
# ask() {
#     answer="$( echo -e $1 | dmenu -i -p "$2" $lines $colors $font )"
# }
# tofi
ask() {
    answer="$( echo -e $1 | tofi --config $tofi_conf --prompt-text "$2: " $tofi_lines $tofi_colors $tofi_font )"
}


# main logic
ask "$opt1" "$first_prompt"

lock_screen=

case $answer in
    "Lock")
        ask "$opt2" "Lock computer?"
        if [[ $answer == "Yes" ]]; then
            swaylock -f -c 000000 --indicator --image $HOME/walls/dball.png --effect-blur 7x5
        fi
        exit 0
        ;;
    "Suspend")
        ask "$opt2" "Suspend computer?"
        if [[ $answer == "Yes" ]]; then
            systemctl suspend
        fi
        exit 0
        ;;
    "Reboot")
        ask "$opt2" "Reboot computer?"
        if [[ $answer == "Yes" ]]; then
            systemctl reboot
        fi
        exit 0
        ;;
    "Shutdown")
        ask "$opt2" "Shutdown computer?"
        if [[ $answer == "Yes" ]]; then
            systemctl poweroff
        fi
        exit 0
        ;;
    "Logout")
        ask "$opt2" "logout from computer?"
        if [[ $answer == "Yes" ]]; then
            loginctl terminate-user $USER
        fi
        exit 0
        ;;
esac

exit 0
