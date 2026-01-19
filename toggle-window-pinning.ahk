#Requires AutoHotkey v2.0
#Include "VD.ah2"

; --- HOTKEY FOR PINNING/UNPINNING ---

; Hotkey: Win + Alt + P
#!p:: {
    ; "A" refers to the title of the currently active window.
    ; VD.TogglePinWindow will check the status and call PinView or UnPinView accordingly.

    result := VD.TogglePinWindow("A")

    ; --- Feedback and Error Handling ---

    if (result = -1) {
        ; Error: Window could not be found or processed by the VD function
        Msg := "Error: Could not toggle pin status. Is a valid window active?"
    }
    ; We assume 0 or 1 is returned for success, or the function returns nothing (void) on success.
    else {
        ; Generic confirmation, as TogglePinWindow usually doesn't return the new state directly.
        Msg := "Window Pin Status Toggled."
    }

    ; Display the status using a ToolTip
    ToolTip(Msg, 50, 50)
    SetTimer(() => ToolTip(), -2000) ; Hide ToolTip after 2 seconds
}