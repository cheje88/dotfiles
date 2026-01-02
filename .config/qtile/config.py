# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess

from libqtile import bar, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

import colors

MOD = "mod4"  # Sets mod key to SUPER/WINDOWS
MYTERM = "kitty"  # My terminal of choice
MYBROWSER = "brave"  # My browser of choice


# Allows you to input a name when adding treetab section.
# @lazy.layout.function
# def add_treetab_section(layout):
#     prompt = qtile.widgets_map["prompt"]
#     prompt.start_input("Section name: ", layout.cmd_add_section)


# A function for hide/show all the windows in a group
@lazy.function
def minimize_all(qtile):
    for win in qtile.current_group.windows:
        if hasattr(win, "toggle_minimize"):
            win.toggle_minimize()


# A function for toggling between MAX and MONADTALL layouts
@lazy.function
def maximize_by_switching_layout(qtile):
    current_layout_name = qtile.current_group.layout.name
    if current_layout_name == "monadtall":
        qtile.current_group.layout = "max"
    elif current_layout_name == "max":
        qtile.current_group.layout = "monadtall"


keys = [
    # The essentials
    Key([MOD], "Return", lazy.spawn(MYTERM), desc="Terminal"),
    Key(
        [MOD, "shift"],
        "Return",
        lazy.spawn("dmenu_run"),
        desc="Run Launcher",
    ),
    Key(
        [MOD],
        "d",
        lazy.spawn("rofi -show drun -show-icons"),
        desc="Run Launcher",
    ),
    Key([MOD], "w", lazy.spawn(MYBROWSER), desc="Web browser"),
    Key(
        [MOD],
        "b",
        lazy.hide_show_bar(position="all"),
        desc="Toggles the bar to show/hide",
    ),
    Key([MOD], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([MOD, "shift"], "Tab", lazy.prev_layout(), desc="Toggle between layouts"),
    Key([MOD, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([MOD, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([MOD, "shift"], "q", lazy.spawn("dm-logout -r"), desc="Logout menu"),
    Key([MOD], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # Key([mod, "shift"], "T", lazy.spawn("conky-toggle"), desc="Conky toggle on/off"),
    # Switch between windows
    # Some layouts like 'monadtall' only need to use j/k to move
    # through the stack, but other layouts like 'columns' will
    # require all four directions h/j/k/l to move around.
    Key([MOD], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([MOD], "left", lazy.layout.left(), desc="Move focus to left"),
    Key([MOD], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([MOD], "right", lazy.layout.right(), desc="Move focus to right"),
    Key([MOD], "j", lazy.layout.down(), desc="Move focus down"),
    Key([MOD], "down", lazy.layout.down(), desc="Move focus down"),
    Key([MOD], "k", lazy.layout.up(), desc="Move focus up"),
    Key([MOD], "up", lazy.layout.up(), desc="Move focus up"),
    Key([MOD], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [MOD, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        # lazy.layout.move_left().when(layout=["treetab"]),
        desc="Move window to the left/move tab left in treetab",
    ),
    Key(
        [MOD, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        # lazy.layout.move_right().when(layout=["treetab"]),
        desc="Move window to the right/move tab right in treetab",
    ),
    Key(
        [MOD, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        # lazy.layout.section_down().when(layout=["treetab"]),
        desc="Move window down/move down a section in treetab",
    ),
    Key(
        [MOD, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        # lazy.layout.section_up().when(layout=["treetab"]),
        desc="Move window downup/move up a section in treetab",
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [MOD, "shift"],
        "space",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    # Grow/shrink windows left/right.
    # This is mainly for the 'monadtall' and 'monadwide' layouts
    # although it does also work in the 'bsp' and 'columns' layouts.
    Key(
        [MOD],
        "equal",
        lazy.layout.grow_left().when(layout=["bsp", "columns"]),
        lazy.layout.grow().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the left",
    ),
    Key(
        [MOD],
        "minus",
        lazy.layout.grow_right().when(layout=["bsp", "columns"]),
        lazy.layout.shrink().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the left",
    ),
    # Grow windows up, down, left, right.  Only works in certain layouts.
    # Works in 'bsp' and 'columns' layout.
    Key(
        [MOD, "control"],
        "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        desc="Grow window to the left",
    ),
    Key(
        [MOD, "control"],
        "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        desc="Grow window to the right",
    ),
    Key(
        [MOD, "control"],
        "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        desc="Grow window down",
    ),
    Key(
        [MOD, "control"],
        "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        desc="Grow window up",
    ),
    Key([MOD, "control"], "Return", lazy.layout.toggle_split()),
    Key([MOD], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([MOD], "m", lazy.layout.maximize(), desc="Toggle between min and max sizes"),
    Key([MOD], "t", lazy.window.toggle_floating(), desc="toggle floating"),
    Key(
        [MOD],
        "f",
        maximize_by_switching_layout(),
        lazy.window.toggle_fullscreen(),
        desc="toggle fullscreen",
    ),
    Key(
        [MOD, "shift"],
        "m",
        minimize_all(),
        desc="Toggle hide/show all windows on current group",
    ),
    # Switch focus of monitors
    Key([MOD], "period", lazy.next_screen(), desc="Move focus to next monitor"),
    Key([MOD], "comma", lazy.prev_screen(), desc="Move focus to prev monitor"),
]

groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

# Uncomment only one of the following lines
# group_labels = ["", "", "👁", "", "", "", "✀", "꩜", "", "⎙"]
group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
# group_labels = ["DEV", "WWW", "SYS", "DOC", "VBOX", "CHAT", "MUS", "VID", "GFX", "MISC"]

# The default layout for each of the 10 workspaces
group_layouts = [
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        )
    )

for i in groups:
    keys.extend(
        [
            # MOD1 + letter of group = switch to group
            Key(
                [MOD],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # MOD1 + shift + letter of group = move focused window to group
            Key(
                [MOD, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc="Move focused window to group {}".format(i.name),
            ),
        ]
    )

colors = colors.Tokyo

layout_theme = {
    "border_width": 4,
    "margin": 12,
    # "border_focus": colors[9],
    "border_focus": "#50fa7b",
    "border_normal": colors[0],
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    # layout.Tile(**layout_theme),
    layout.Max(**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Floating(**layout_theme)
    # layout.RatioTile(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.Stack(**layout_theme, num_stacks=2),
    layout.Columns(**layout_theme),
    # layout.TreeTab(
    #     font = "Ubuntu Bold",
    #     fontsize = 11,
    #     border_width = 0,
    #     bg_color = colors[0],
    #     active_bg = colors[8],
    #     active_fg = colors[2],
    #     inactive_bg = colors[1],
    #     inactive_fg = colors[0],
    #     padding_left = 8,
    #     padding_x = 8,
    #     padding_y = 6,
    #     sections = ["ONE", "TWO", "THREE"],
    #     section_fontsize = 10,
    #     section_fg = colors[7],
    #     section_top = 15,
    #     section_bottom = 15,
    #     level_shift = 8,
    #     vspace = 3,
    #     panel_width = 240
    #     ),
    # layout.Zoomy(**layout_theme),
]

widget_defaults = dict(font="Ubuntu Bold", fontsize=14, padding=0, background=colors[0])

extension_defaults = widget_defaults.copy()


def init_widgets_list():
    widgets_list = [
        widget.Spacer(length=8),
        widget.Image(
            filename="~/.config/qtile/icons/python.png",
            scale="False",
            mouse_callbacks={"Button1": lambda: qtile.spawn("dmenu_run")},
        ),
        widget.Prompt(font="Ubuntu Mono", fontsize=14, foreground=colors[1]),
        widget.GroupBox(
            fontsize=14,
            margin_y=5,
            margin_x=5,
            padding_y=0,
            padding_x=2,
            borderwidth=3,
            active=colors[8],
            inactive=colors[9],
            rounded=False,
            highlight_color=colors[0],
            highlight_method="line",
            this_current_screen_border=colors[6],
            this_screen_border=colors[6],
            other_current_screen_border=colors[7],
            other_screen_border=colors[4],
        ),
        widget.TextBox(
            text="|", font="Ubuntu Mono", foreground=colors[9], padding=2, fontsize=14
        ),
        widget.CurrentLayout(foreground=colors[2], padding=5),
        widget.TextBox(
            text="|", font="Ubuntu Mono", foreground=colors[9], padding=2, fontsize=14
        ),
        widget.WindowName(foreground=colors[6], padding=8, max_chars=40),
        widget.CPU(
            foreground=colors[4],
            padding=8,
            mouse_callbacks={"Button1": lambda: qtile.spawn(myTerm + " -e htop")},
            format=" {load_percent}%",
        ),
        widget.ThermalSensor(
            foreground=colors[10],
            # background=colors[4],
            tag_sensor="Core 0",
            fmt="  {}",
            threshold=90,
            padding=5,
        ),
        widget.Memory(
            foreground=colors[8],
            padding=8,
            mouse_callbacks={"Button1": lambda: qtile.spawn(myTerm + " -e htop")},
            format="{MemUsed: .0f}{mm}",
            fmt="🖥{}",
        ),
        widget.NvidiaSensors(
            foreground=colors[10],
            # background=colors[4],
            format=" GPU {temp}ºC",
            # tag_sensor='Core 0',
            gpu_bus_id="01:00.0",
            threshold=70,
            # padding=5
        ),
        widget.Sep(linewidth=0, padding=5, foreground=colors[0], background=colors[0]),
        widget.Net(
            format="  {down}    {up}",
            foreground=colors[9],
            # background=colors[9],
            padding=5,
        ),
        widget.Sep(linewidth=0, padding=5, foreground=colors[0], background=colors[0]),
        widget.Volume(
            # widget.PulseVolume(
            foreground=colors[2],
            background=colors[0],
            # emoji=True,
            fmt="🔊 {}",
            padding=5,
        ),
        # widget.Sep(linewidth=0, padding=10, foreground=colors[0], background=colors[0]),
        # widget.CurrentLayoutIcon(
        #     custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
        #     foreground=colors[0],
        #     background=colors[0],
        #     padding=0,
        #     scale=0.7,
        # ),
        widget.Sep(linewidth=0, padding=10, foreground=colors[8], background=colors[0]),
        widget.Wttr(
            user_agent="Qtile",
            format="3",
            location={"Culiacan": "Culiacan", "Surutato": "Surutato"},
            lang="es",
            units="{m}",
            # background=colors[5],
            foreground=colors[5],
        ),
        widget.Sep(linewidth=0, padding=10, foreground=colors[0], background=colors[0]),
        widget.Clock(
            foreground=colors[7],
            # background=colors[5],
            format="📅  %A, %d/%m/%y ⏰ %H:%M ",
        ),
        widget.Sep(linewidth=0, padding=10, foreground=colors[0], background=colors[0]),
        # widget.Systray(background=colors[0], padding=5),
        # widget.DF(
        # update_interval=60,
        # foreground=colors[9],
        # padding=8,
        # mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("notify-disk")},
        # partition="/",
        # # format = '[{p}] {uf}{m} ({r:.0f}%)',
        # format="{uf}{m} free",
        # fmt="🖴  Disk: {}",
        # visible_on_warn=False,
        # ),
        widget.Systray(padding=6),
        widget.Spacer(length=8),
    ]
    return widgets_list


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1


# All other monitors' bars will display everything but widgets 22 (systray) and 23 (spacer).
def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    del widgets_screen2[20:22]
    return widgets_screen2


def init_widgets_screen3():
    widgets_screen3 = init_widgets_list()
    del widgets_screen3[8:21]
    return widgets_screen3


# For adding transparency to your bar, add (background="#00000000") to the "Screen" line(s)
# For ex: Screen(top=bar.Bar(widgets=init_widgets_screen2(), background="#00000000", size=24)),


def init_screens():
    return [
        Screen(
            top=bar.Bar(widgets=init_widgets_screen1(), margin=[8, 12, 0, 12], size=30)
        ),
        Screen(
            top=bar.Bar(widgets=init_widgets_screen2(), margin=[8, 12, 0, 12], size=30)
        ),
        Screen(
            top=bar.Bar(widgets=init_widgets_screen3(), margin=[8, 12, 0, 12], size=30)
        ),
    ]


if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()


def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)


mouse = [
    Drag(
        [MOD],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [MOD], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([MOD], "Button2", lazy.window.bring_to_front()),
    # Drag(["MOD1"], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    # Drag(["MOD1"], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    # Click(["MOD1"], "Button2", lazy.window.bring_to_front()),
]

DGROUPS_KEY_BINDER = None
dgroups_app_rules = []  # type: list
FOLLOW_MOUSE_FOCUS = True
BRING_FRONT_CLICK = False
CURSOR_WARP = False
floating_layout = layout.Floating(
    border_focus=colors[8],
    border_width=2,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="dialog"),  # dialog boxes
        Match(wm_class="download"),  # downloads
        Match(wm_class="error"),  # error msgs
        Match(wm_class="file_progress"),  # file progress boxes
        Match(wm_class="kdenlive"),  # kdenlive
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="lxappearance"),  # lxappearance
        Match(wm_class="gmic_qt"),  # gmic
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="notification"),  # notifications
        Match(wm_class="pinentry-gtk-2"),  # GPG key password entry
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="toolbar"),  # toolbars
        Match(wm_class="manjaro-settings-manager"),  #
        Match(wm_class="galculator"),  #
        Match(wm_class="Yad"),  # yad boxes
        Match(title="branchdialog"),  # gitk
        Match(title="Confirmation"),  # tastyworks exit box
        Match(title="galculator!"),  # qalculate-gtk
        Match(title="Qalculate!"),  # qalculate-gtk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="tastycharts"),  # tastytrade pop-out charts
        Match(title="tastytrade"),  # tastytrade pop-out side gutter
        Match(title="tastytrade - Portfolio Report"),  # tastytrade pop-out allocation
        Match(wm_class="tasty.javafx.launcher.LauncherFxApp"),  # tastytrade settings
    ],
)
AUTO_FULLSCREEN = True
FOCUS_ON_WINDOW_ACTIVATION = "smart"
RECONFIGURE_SCREENS = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
AUTO_MINIMIZE = True

# When using the Wayland backend, this can be used to configure input devices.
WL_INPUT_RULES = None


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
