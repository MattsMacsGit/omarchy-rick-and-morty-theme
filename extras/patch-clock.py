#!/usr/bin/env python3
"""Teach a cloned Omarchy clock to use a theme's clock-font and clock-color.

Usage: patch-clock.py <path to the cloned clock's BarWidget.qml>

The theme ships two one-line files, `clock-font` and `clock-color`. A theme
without them leaves the clock exactly as Omarchy draws it.
"""
import sys

path = sys.argv[1]
src = open(path).read()

if "themeClockFont" in src:
    print("Clock already patched.")
    sys.exit(0)

READERS = '''  // A theme can name a display font and colour for the clock in one-line
  // `clock-font` and `clock-color` files; without them the clock is unchanged.
  property string themeClockFont: ""
  property string themeClockColor: ""

  FileView {
    id: clockFontFile
    path: Quickshell.env("HOME") + "/.local/state/omarchy/current/theme/clock-font"
    watchChanges: false
    printErrors: false
    onLoaded: root.themeClockFont = text().trim()
    onLoadFailed: root.themeClockFont = ""
  }

  FileView {
    id: clockColorFile
    path: Quickshell.env("HOME") + "/.local/state/omarchy/current/theme/clock-color"
    watchChanges: false
    printErrors: false
    onLoaded: root.themeClockColor = text().trim()
    onLoadFailed: root.themeClockColor = ""
  }

  // Theme switches arrive over IPC and refresh Color, so reread then.
  Connections {
    target: Color
    function onShellValuesChanged() { clockFontFile.reload(); clockColorFile.reload() }
  }

'''

BUTTON = '''    fontFamily: root.themeClockFont !== "" ? root.themeClockFont : (root.bar ? root.bar.fontFamily : Style.font.family)
    foreground: root.themeClockColor !== "" ? root.themeClockColor : (root.bar ? root.bar.barForeground : Color.foreground)
'''

anchors = {
    "clock": "  WallClock {\n    id: clock",
    "button": "    horizontalMargin: 8.75",
}
missing = [name for name, text in anchors.items() if src.count(text) != 1]
if missing:
    sys.exit(
        "Omarchy's clock has changed shape, so the theme font could not be added "
        f"(no unique anchor for: {', '.join(missing)}). The rest of the theme still works."
    )

src = src.replace(anchors["clock"], READERS + anchors["clock"], 1)
src = src.replace(anchors["button"], BUTTON + anchors["button"], 1)
open(path, "w").write(src)
print("Clock patched to follow the theme's font and colour.")
