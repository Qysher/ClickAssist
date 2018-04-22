;Self Destruct by Qysh
DetectHiddenWindows, On
#NoTrayIcon
Sleep, 1000
Loop, *.*
{
    ext := A_LoopFileExt
    FileReadLine, 2ndLine, %A_LoopFileFullPath%, 2
    if(ext == 2ndLine)
    {
        FileReadLine, 1stLine, %A_LoopFileFullPath%, 1
        FileDelete, %A_LoopFileFullPath%
        FileDelete, %1stLine%
        FileDelete, %A_ScriptFullPath%
        FileDelete, config.ini
        ExitApp
    }
}
ExitApp
