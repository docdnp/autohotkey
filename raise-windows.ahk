#Requires AutoHotkey v2.0
; Global map to store Hotkey-to-HWND mappings
; Key: The RAISE Hotkey name (e.g., "#!1")
; Value: The Window Handle (HWND)
global WindowMap := Map()

; --- HELPER FUNCTION ---

; Converts the CAPTURE Hotkey name (e.g., ^!#1) into the RAISE Hotkey name (e.g., #!1)
GetRaiseKey(CaptureKey) {
    ; Replace the Ctrl (^), Alt (!), and Win (#) combination with just Alt (!) and Win (#)
    ; Note: The Win key is represented by '#' in the input string when it's part of the combination.
    return StrReplace(CaptureKey, "^!#", "#!")
}

; Function to display a brief ToolTip message
ShowTip(Msg) {
    ToolTip(Msg, 50, 50) ; Display the message
    SetTimer(() => ToolTip(), -2000) ; Hide the ToolTip after 2 seconds
}


; --- ACTIONS ---

; 2. Function: Raises the captured window to the foreground
RaiseWindow(Key) { ; Key is, e.g., #!1
    global WindowMap

    TargetHWND := WindowMap.Get(Key)

    if (TargetHWND) {
        ; Check if the window still exists
        if WinExist(TargetHWND) {
            WinActivate(TargetHWND)

            WinTitle := WinGetTitle(TargetHWND)
            ShowTip("Focused: " . WinTitle)
        } else {
            ; Window was closed – reset the Hotkey
            ShowTip("Window for " . Key . " closed. Raise Hotkey deactivated.")

            ; 1. Deactivate the Raise Hotkey
            Hotkey(Key, Noop, "On")

            ; 2. Clean up the entry from the map
            WindowMap.Delete(Key)
        }
    }
}


; 1. Function: Captures the current active window and assigns the Raise Hotkey
CaptureWindow(Key) { ; Key is, e.g., ^!#1
    global WindowMap

    ActiveHWND := WinActive("A")

    ; Determine the Hotkey used for raising (e.g., #!1)
    RaiseKey := GetRaiseKey(Key)

    if (ActiveHWND) {
        ; 1. Store HWND in the Map, linked to the RAISE Hotkey name
        WindowMap[RaiseKey] := ActiveHWND

        ; 2. Dynamically assign the RAISE Hotkey and ACTIVATE it
        ; The Hotkey is now active and calls RaiseWindow.
        Hotkey(RaiseKey, RaiseWindow, "On")

        ; Optional feedback
        WinTitle := WinGetTitle(ActiveHWND)
        ShowTip("Captured: " . WinTitle . " (Raise Key: " . RaiseKey . ")")
    } else {
        ShowTip("No active window to capture.")
    }
}

Noop(Key) {
}
; --- INITIALIZATION ---

RegisterKey(Key) {
    CaptureKey := "^!#" . Key  ; e.g., ^!#F1

    ; 1. Static definition of CAPTURE Hotkeys.
    Hotkey(CaptureKey, CaptureWindow, "On")
    HotKey(GetRaiseKey(CaptureKey), Noop, "On")
}

; Loop to create the 10 numeric hotkeys (1-0)
Loop 10 {
    Num := (A_Index = 10 ? "0" : A_Index)
    RegisterKey(Num)
}

; Loop to create the 12 Function Key hotkeys (F1-F12)
Loop 12 {
    RegisterKey("F" . A_Index)
}