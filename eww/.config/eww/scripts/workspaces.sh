#!/bin/sh

print_workspaces() {
    buf=""
    desktops=$(bspc query -D --names)
    focused_desktop=$(bspc query -D -d focused --names)
    occupied_desktops=$(bspc query -D -d .occupied --names)
    urgent_desktops=$(bspc query -D -d .urgent --names)

# if [[ $string == *"My long"* ]]; then

    for d in $desktops; do
        if [[ $focused_desktop == *"$d"* ]]; then
            ws=$d
            class="focused"
        elif [[ $occupied_desktops == *"$d"* ]]; then
            ws=$d
            class="occupied"
        elif [[ $urgent_desktops == *"$d"* ]]; then
            ws=$d
            class="urgent"
        else
            ws=$d
            class="empty"
        fi

        buf="$buf (eventbox :cursor \"hand\" (button :class \"$class\" :onclick \"bspc desktop -f $ws\" \"$ws\"))"
    done

    echo "(box :class \"workspaces\" :halign \"center\" :valign \"center\" :vexpand true :hexpand true $buf)"
}

print_workspaces
bspc subscribe desktop node_transfer | while read -r _ ; do
    print_workspaces
done
