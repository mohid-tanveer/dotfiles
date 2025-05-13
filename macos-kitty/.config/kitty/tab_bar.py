import subprocess
import re
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.rgb import to_color
from kitty.tab_bar import (
    DrawData,
    TabBarData,
    ExtraData,
    Formatter,
    draw_attributed_string,
    as_rgb,
)
import platform

# colors
ACTIVE_BG = "#000000"
INACTIVE_BG = "#0f0f0f"
FOREGROUND_COL = "#00ff00"

LEFT_ROUND = ""
RIGHT_ROUND = ""

# nerd-font icons
TERMINAL_ICON = " "
REFRESH_SECS = 1

timer_id = None


def _get_active_process_cell() -> dict:
    boss = get_boss()
    cell = {"icon": TERMINAL_ICON, "icon_bg_color": FOREGROUND_COL, "text": ""}
    if not boss or not boss.active_window or not boss.active_window.child:
        cell["text"] = "n/a"
        return cell
    procs = boss.active_window.child.foreground_processes
    if not procs or not procs[0].get("cmdline"):
        cell["text"] = "n/a"
    else:
        cell["text"] = procs[0]["cmdline"][0].rsplit("/", 1)[-1]
    return cell


def _create_cells() -> list[dict]:
    return [_get_active_process_cell()]


def _draw_right_status(screen: Screen, draw_data: DrawData) -> None:
    draw_attributed_string(Formatter.reset, screen)
    cells = _create_cells()
    total = sum(
        len(LEFT_ROUND) + len(c["icon"]) + len(c["text"]) + len(RIGHT_ROUND) + 1
        for c in cells
    )
    screen.cursor.x = screen.columns - total
    default_bg = as_rgb(int(draw_data.default_bg))

    for c in cells:
        icon_bg = as_rgb(int(to_color(c["icon_bg_color"])))
        # left-round cut-in
        screen.cursor.bg = default_bg
        screen.cursor.fg = icon_bg
        screen.draw(LEFT_ROUND)
        # icon: bg=icon_bg, fg=default_bg
        screen.cursor.bg = icon_bg
        screen.cursor.fg = default_bg
        screen.draw(c["icon"])
        # text: bg=icon_bg, fg=default_bg
        screen.cursor.bg = icon_bg
        screen.cursor.fg = default_bg
        screen.draw(c["text"])
        # right-round cut-out
        screen.cursor.bg = default_bg
        screen.cursor.fg = icon_bg
        screen.draw(RIGHT_ROUND)
        # space separator
        screen.draw(" ")


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global timer_id
    if timer_id is None:
        timer_id = add_timer(
            lambda _: get_boss().active_tab_manager.mark_tab_bar_dirty(),
            REFRESH_SECS,
            True,
        )

    # pick colors
    bg_hex = ACTIVE_BG if tab.is_active else INACTIVE_BG
    bg_rgb = as_rgb(int(to_color(bg_hex)))
    fg_rgb = as_rgb(int(to_color(FOREGROUND_COL)))
    default_bg = as_rgb(int(draw_data.default_bg))

    screen.cursor.x = before
    draw_attributed_string(Formatter.reset, screen)

    if not tab.is_active:
        # left-round for inactive
        screen.cursor.bg = default_bg
        screen.cursor.fg = bg_rgb
        screen.draw(LEFT_ROUND)
    else:
        screen.draw(" ")

    # title
    title = tab.title[:max_title_length]
    screen.cursor.bg = bg_rgb
    screen.cursor.fg = fg_rgb
    screen.draw(f" {title} ")

    if not tab.is_active:
        # right-round for inactive
        screen.cursor.bg = default_bg
        screen.cursor.fg = bg_rgb
        screen.draw(RIGHT_ROUND)
    else:
        screen.draw(" ")

    if is_last:
        _draw_right_status(screen, draw_data)

    return screen.cursor.x
