sleep 10
xmodmap -e "keysym Menu = F13"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom17/binding "'F14'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom17/binding "'F13'"

