# AutoHotkey Scripts for Windows Virtual Desktops

A collection of AutoHotkey v2 scripts to enhance Windows Virtual Desktop management with keyboard shortcuts for window movement, desktop switching, window raising, and window pinning.

## Requirements

- AutoHotkey v2.0 or later
- Windows 10 or later (with Virtual Desktops support)

## Scripts Overview

### move-window.ahk

Manage Virtual Desktops navigation and move windows between desktops.
Actually this script assumes you have 10 virtual desktops opened already.

**Keyboard Shortcuts:**

- `Ctrl + Win + Left` - Switch to the previous virtual desktop
- `Ctrl + Win + Right` - Switch to the next virtual desktop
- `Ctrl + Shift + Win + Left` - Move active window to the previous desktop and follow it
- `Ctrl + Shift + Win + Right` - Move active window to the next desktop and follow it
- `Ctrl + Win + 1-9, 0` - Switch to virtual desktop 1-10
- `Ctrl + Shift + Win + 1-9, 0` - Move active window to desktop 1-10 and switch to it

### raise-windows.ahk

Capture and quickly raise (activate) windows using custom hotkeys. This allows you to assign specific windows to hotkeys for instant access.

**Keyboard Shortcuts:**

- `Ctrl + Alt + Win + 1-9, 0` - Capture the currently active window for quick access
- `Win + Alt + 1-9, 0` - Raise (activate) the previously captured window
- `Ctrl + Alt + Win + F1-F12` - Capture the currently active window for quick access
- `Win + Alt + F1-F12` - Raise (activate) the previously captured window

**Usage:** First capture a window using the Ctrl + Alt + Win combination, then quickly bring it to the front using the Win + Alt combination.

### toggle-window-pinning.ahk

Pin or unpin windows so they appear on all virtual desktops.

**Keyboard Shortcuts:**

- `Win + Alt + P` - Toggle the pin status of the active window (pinned windows appear on all desktops)

## VD.ah2 Library

The VD.ah2 file provides the Virtual Desktop API functionality required by these scripts. This library is sourced from:

**Source:** https://github.com/FuPeiJiang/VD.ahk/tree/v2_port

Some scripts include this library via `#Include "VD.ah2"`.

## Installation

1. Install [AutoHotkey v2](https://www.autohotkey.com/)
    - Download from here: <https://www.autohotkey.com/download/>
    - Extract and start `install.cmd`, choose location etc.
2. Download all scripts to the same directory
3. Run the desired scripts by double-clicking them
4. Scripts will run in the system tray and respond to the keyboard shortcuts
5. Put lnks into your startup directory if you want to you use them by default: `Win + R`, enter `shell:startup` to open the startup dir

## License

MIT License - See LICENSE file for details.