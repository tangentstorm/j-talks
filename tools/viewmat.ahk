#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Autohotkey script to help me juggle windows around

f10::
  ; resize tiny 'rgb' viewmat windows to the default size
  if WinActive("viewmat") {
    WinMove,,, ,, 376, 401
  }
  return
f11::
  ; move to camera
  if WinActive("viewmat") {
    WinMove  20, 500
  }
  return
f12::
  ; move to camera for side-by-side comparison (default size)
  if WinActive("viewmat") {
    WinMove 420, 500
  }
  return


