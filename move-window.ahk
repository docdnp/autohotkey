; Erfordert die VirtualDesktop-Funktionen, die du wahrscheinlich schon hast
; Stelle sicher, dass du das VD-Modul für v2 verwendest

#Include "VD.ah2"
^+#Left::
{
    n := VD.getCurrentDesktopNum()
    ; Desktops sind 1-basiert
    if n = 1
    {
        return
    }
    n -= 1

    ; Die Funktionen in v2 werden mit Kommas getrennt aufgerufen.
    ; "A" ist der Standardtitel für das aktive Fenster.
    VD.MoveWindowToDesktopNum("A", n)
    VD.GoToDesktopNum(n)
}

^+#Right::
{
    n := VD.GetCurrentDesktopNum()
    desktopCount := VD.GetCount()

    ; Prüft, ob es der letzte Desktop ist
    if n = desktopCount
    {
        return
    }
    n += 1

    VD.MoveWindowToDesktopNum("A", n)
    VD.GoToDesktopNum(n)
}


^#Left::
{
    n := VD.getCurrentDesktopNum()
    ; Desktops sind 1-basiert
    if n = 1
    {
        return
    }
    n -= 1

    VD.GoToDesktopNum(n)
}

^#Right::
{
    n := VD.GetCurrentDesktopNum()
    desktopCount := VD.GetCount()

    ; Prüft, ob es der letzte Desktop ist
    if n = desktopCount
    {
        return
    }
    n += 1

    VD.GoToDesktopNum(n)
}

; --- HOTKEY ACTIONS ---

; Function 1: Switches to the specified Virtual Desktop (e.g., Ctrl + Win + 1)
GoToDesktop(HotkeyName) {
    ; Extracts the desktop number from the Hotkey name (e.g., "1" from "^#1")
    DesktopNum := SubStr(HotkeyName, -1)

    ; Converts "0" to 10 for desktop number logic
    if (DesktopNum = "0") {
        DesktopNum := 10
    }

    VD.GoToDesktopNum(DesktopNum)
}

; Function 2: Moves the active window and switches to the specified Virtual Desktop (e.g., Ctrl + Shift + Win + 1)
MoveWindowAndGoToDesktop(HotkeyName) {
    ; Extracts the desktop number from the Hotkey name
    DesktopNum := SubStr(HotkeyName, -1)

    ; Converts "0" to 10
    if (DesktopNum = "0") {
        DesktopNum := 10
    }

    ; "A" refers to the active window
    VD.MoveWindowToDesktopNum("A", DesktopNum)
    VD.GoToDesktopNum(DesktopNum)
}


; --- DYNAMIC INITIALIZATION ---

; Loop 10 times to cover keys 1 through 9 and 0
Loop 10 {
    ; Use 0 for the 10th iteration, matching the keyboard layout
    Num := (A_Index = 10 ? "0" : A_Index)

    ; 1. Hotkey Definition: Go To Desktop (^# + Num = Ctrl + Win + Num)
    GoToKey := "^#" . Num
    Hotkey(GoToKey, GoToDesktop, "On")

    ; 2. Hotkey Definition: Move Window and Go To Desktop (^+# + Num = Ctrl + Shift + Win + Num)
    MoveKey := "^+#" . Num
    Hotkey(MoveKey, MoveWindowAndGoToDesktop, "On")
}

