from libqtile import bar, layout, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration
import colors
import subprocess
import os

mod="mod4"
# terminal=guess_terminal()
terminal="alacritty"
browser="brave"
launcher='rofi -show combi -display-combi "Run:"'

keys=[
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Tab", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split=all windows displayed
    # Unsplit=1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Key([mod, "shift"], "space", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack",),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window",),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.spawn("dm-logout"), desc="Logout menu"),
    Key([mod, "shift"], "Return", lazy.spawn(launcher), desc="Run launcher"),
    Key([mod], "b", lazy.spawn(browser), desc="Launch web browser"),
]

groups=[]

group_names=["1", "2", "3", "4", "5", "6",]
group_labels=["web", "dev", "term", "chat", "music", "etc",]
group_layouts=["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall",]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))


for i in groups:
    keys.extend(
        [
            # mod1 + letter of group=switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group=switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group=move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

colors=colors.Palenight

layout_defaults=dict(
    border_width=2,
    margin=8,
    border_focus=colors[8],
    border_normal=colors[0],
)

layouts=[
    # layout.Max(),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(**layout_defaults),
    # layout.Columns(**layout_defaults),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

font="Iosevka Nerd Font"

widget_defaults=dict(
    font=font,
    fontsize=10,
    padding=0,
    background=colors[0]
)
extension_defaults=widget_defaults.copy()

widgets_list=[
    widget.Prompt(
        foreground=colors[1]
    ),
    widget.GroupBox(
        margin_y=3,
        margin_x=4,
        padding_y=2,
        padding_x=3,
        borderwidth=3,
        active=colors[8],
        inactive=colors[1],
        rounded=False,
        highlight_color=colors[2],
        highlight_method="line",
        this_current_screen_border=colors[7],
        this_screen_border=colors [4],
        other_current_screen_border=colors[7],
        other_screen_border=colors[4],
    ),
    widget.TextBox(
        text='|',
        foreground=colors[1],
        padding=2,
    ),
    widget.CurrentLayoutIcon(
        # custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
        foreground=colors[1],
        padding=0,
        scale=0.7
    ),
    widget.CurrentLayout(
        foreground=colors[1],
        padding=5
    ),
    widget.TextBox(
        text='|',
        foreground=colors[1],
        padding=2,
    ),
    widget.WindowName(
        foreground=colors[6],
        max_chars=40
    ),
    widget.GenPollText(
        update_interval=300,
        func=lambda: subprocess.check_output("printf $(uname -r)", shell=True, text=True),
        foreground=colors[3],
        fmt='❤  {}',
        decorations=[
            BorderDecoration(
                colour=colors[3],
                border_width=[0, 0, 2, 0],
            )
        ],
    ),
    widget.Spacer(length=8),
    widget.CPU(
        format='▓ CPU: {load_percent}%',
        foreground=colors[4],
        decorations=[
            BorderDecoration(
                colour=colors[4],
                border_width=[0, 0, 2, 0],
            )
        ],
    ),
    widget.Spacer(length=8),
    widget.Memory(
        foreground=colors[8],
        mouse_callbacks={'Button1': lazy.spawn(terminal + ' -e htop')},
        format='{MemUsed: .0f}{mm}',
        fmt='🖥 Mem: {} used',
        decorations=[
            BorderDecoration(
                colour=colors[8],
                border_width=[0, 0, 2, 0],
            )
        ],
    ),
    widget.Spacer(length=8),
    widget.DF(
        update_interval=60,
        foreground=colors[5],
        mouse_callbacks={'Button1': lazy.spawn(terminal + ' -e df')},
        partition='/',
        #format='[{p}] {uf}{m} ({r:.0f}%)',
        format='{uf}{m} free',
        fmt='🖴  Disk: {}',
        visible_on_warn=False,
        decorations=[
            BorderDecoration(
                colour=colors[5],
                border_width=[0, 0, 2, 0],
            )
        ],
    ),
    widget.Spacer(length=8),
    widget.Battery(
        update_interval=60,
        foreground=colors[3],
        charge_char='Charging ',
        discharge_char='',
        empty_char='',
        format='{char}{percent:2.0%}',
        fmt='󰁹 Battery: {}',
        decorations=[
            BorderDecoration(
                colour=colors[3],
                border_width=[0, 0, 2, 0],
            )
        ],
    ),
    widget.Spacer(length=8),
    widget.Volume(
        foreground=colors[7],
        fmt='🕫  Vol: {}',
        decorations=[
            BorderDecoration(
                colour=colors[7],
                border_width=[0, 0, 2, 0],
            )
        ],
    ),
    widget.Spacer(length=8),
    widget.KeyboardLayout(
        foreground=colors[4],
        fmt='⌨  Kbd: {}',
        decorations=[
            BorderDecoration(
                colour=colors[4],
                border_width=[0, 0, 2, 0],
            )
        ],
    ),
    widget.Spacer(length=8),
    widget.Clock(
        foreground=colors[8],
        format="⏱  %a, %b %d - %H:%M",
        decorations=[
            BorderDecoration(
                colour=colors[8],
                border_width=[0, 0, 2, 0],
            )
        ],
    ),
    widget.Spacer(length=8),
    widget.Systray(padding=3),
    widget.Spacer(length=8),

#    widget.CurrentLayout(),
#    widget.GroupBox(),
#    widget.Prompt(),
#    widget.WindowName(),
#    widget.Chord(
#        chords_colors={
#            "launch": ("#ff0000", "#ffffff"),
#        },
#        name_transform=lambda name: name.upper(),
#    ),
#    # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
#    # widget.StatusNotifier(),
#    widget.Systray(),
#    widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
#    widget.QuickExit(),
]



screens=[
    Screen(
        top=bar.Bar(widgets_list, 26),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate=60,
    ),
]

# Drag floating layouts.
mouse=[
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder=None
dgroups_app_rules=[]  # type: list
follow_mouse_focus=True
bring_front_click=False
floats_kept_above=True
cursor_warp=False
floating_layout=layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen=True
focus_on_window_activation="smart"
reconfigure_screens=True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize=True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules=None

@hook.subscribe.startup_once
def start_once():
    home=os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname="LG3D"
