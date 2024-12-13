#!/bin/sh

bspwm_workspaces() {
    focused_desktops=$(bspc query -D -d focused --names | jq -Mc --slurp 'map(tostring)')
    occupied_desktops=$(bspc query -D -d .occupied --names | jq -Mc --slurp 'map(tostring)')
    urgent_desktops=$(bspc query -D -d .urgent --names | jq -Mc --slurp 'map(tostring)')

    bspc query -D --names | jq --argjson focused "$focused_desktops" --argjson occupied "$occupied_desktops" --argjson urgent "$urgent_desktops" --slurp -Mc 'map(tostring) | map({ id: (. | tonumber), name: ., state: (if any($urgent[] == .; .) then "urgent" elif any($focused[] == .; .) then "focused" elif any($occupied[] == .; .) then "occupied" else "empty" end) })'
}

if pgrep -x bspwm >/dev/null; then
    bspwm_workspaces
    bspc subscribe desktop node_transfer | while read -r _; do
        bspwm_workspaces
    done
fi

hyprland_workspaces() {
    workspaces_json=$(hyprctl workspaces -j | jq 'map({ (.id|tostring): { id, name, windows } }) | add' -Mc)
    active_workspace_id=$(hyprctl activeworkspace -j | jq -r '.id')

    seq 1 6 | jq --argjson workspaces "$workspaces_json" --arg active_id "$active_workspace_id" --slurp -Mc 'map(tostring) | map({ id: (. | tonumber), name: ($workspaces[.].name//.), state: (if . == $active_id then "focused" elif ($workspaces[.].windows//0) > 0 then "occupied" else "empty" end)})'
}

if pgrep -x Hyprland >/dev/null; then
    hyprland_workspaces
    socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
        hyprland_workspaces
    done
fi
