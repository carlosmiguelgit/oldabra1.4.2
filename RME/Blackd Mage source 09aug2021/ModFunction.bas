Attribute VB_Name = "ModFunction"
Option Explicit

Public lparamvar As Long 'lparam do post/sendmessage
Public prio1 As Boolean 'controle priority heal
Public prio2 As Boolean 'controle priority heal
Public prio1p As Boolean 'controle priority heal )potion
Public prio2p As Boolean 'controle priority heal )potion
Public reuseX As Long 'click reuse last x
Public reuseY As Long 'click reuse last y
Public macroRec As Boolean 'on/off rec macro
Public macroPlaycmd As Boolean 'on/off macro play hk

'positions var
Public RHand As Boolean
Public LHand As Boolean
Public BPSlot As Boolean
Public PickUp As Boolean
Public ToHand As Boolean
Public EatPos As Boolean
Public Guardclick As Boolean

'timers
Public lngHp As Long
Public lngMp As Long
Public lngHk As Long
Public lngEat As Long 'controle timer eat
Public lngIdle As Long 'controle timer idle
Public exaustL As Long 'mouse click exausted
Public exaustR As Long 'mouse click exausted
Public exaustFlash As Long 'flash screen exaust
Public exaustSound As Long 'sound exaust

'click reuse wait delay
Public lngReuseParam As Long
Public ReuseWait As Boolean

Public Const WM_CHAR = &H102
Public Const WM_KEYUP = &H101
Public Const WM_KEYDOWN = &H100
Public Const VK_CONTROL = &H11
Public Const VK_UP = &H26
Public Const VK_DOWN = &H28
Public Const VK_RIGHT = &H27
Public Const VK_LEFT = &H25
Public Const WM_PASTE = &H302
Public Const VK_ESCAPE = &H1B
Public Const VK_A = &H41
Public Const VK_C = &H43
Public Const VK_V = &H56
Public Const VK_SPACEBAR = &H20
Public Const VK_BACK = &H8
Public Const MEM_COMMIT& = &H1000
Public Const GW_HWNDNEXT = 2
Public Const SW_SHOWNORMAL = 1
Public Const SW_SHOWMINIMIZED = 2
Public Const SW_SHOWMAXIMIZED = 3

Public Type SYSTEM_INFO ' 36 Bytes
    dwOemID As Long
    dwPageSize As Long
    lpMinimumApplicationAddress As Long
    lpMaximumApplicationAddress As Long
    dwActiveProcessorMask As Long
    dwNumberOrfProcessors As Long
    dwProcessorType As Long
    dwAllocationGranularity As Long
    wProcessorLevel As Integer
    wProcessorRevision As Integer
End Type

Public Type MEMORY_BASIC_INFORMATION ' 28 bytes
    baseaddress As Long
    AllocationBase As Long
    AllocationProtect As Long
    RegionSize As Long
    State As Long
    Protect As Long
    lType As Long
End Type

Public Type OSVERSIONINFO
    dwOSVersionInfoSize As Long
    dwMajorVersion As Long
    dwMinorVersion As Long
    dwBuildNumber As Long
    dwPlatformId As Long
    szCSDVersion As String * 128
End Type

Public Declare Function ShowWindow Lib "user32" (ByVal hwnd As Long, ByVal nCmdShow As Long) As Long
Public Declare Function FlashWindow Lib "user32" (ByVal hwnd As Long, ByVal bInvert As Long) As Long
Public Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hwnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long
Public Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Public Declare Function GetWindowTextLength Lib "user32" Alias "GetWindowTextLengthA" (ByVal hwnd As Long) As Long
Public Declare Function GetWindow Lib "user32" (ByVal hwnd As Long, ByVal wCmd As Long) As Long
Public Declare Function GetDesktopWindow Lib "user32" () As Long
Public Declare Function GetVersionEx Lib "kernel32" Alias "GetVersionExA" (LpVersionInformation As OSVERSIONINFO) As Long
Public Declare Function VirtualQueryEx& Lib "kernel32" (ByVal hProcess As Long, lpAddress As Any, lpBuffer As MEMORY_BASIC_INFORMATION, ByVal dwLength As Long)
Public Declare Sub GetSystemInfo Lib "kernel32" (lpSystemInfo As SYSTEM_INFO)
Public Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As Long, ByVal blnheritHandle As Long, ByVal dwAppProcessId As Long) As Long
'Public Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Public Declare Function ReadProcessMemory Lib "kernel32" (ByVal hProcess As Long, ByVal lpBaseAddress As Any, ByRef lpBuffer As Any, ByVal nSize As Long, lpNumberOfBytesWritten As Long) As Long
Public Declare Function WriteProcessMemory Lib "kernel32" (ByVal hProcess As Long, lpBaseAddress As Any, lpBuffer As Any, ByVal nSize As Long, lpNumberOfBytesWritten As Long) As Long
Public Declare Function GetForegroundWindow Lib "user32" () As Long
'Public Declare Function GetAsyncKeyState Lib "user32" (ByVal vKey As Long) As Integer
Public Declare Sub Sleep Lib "kernel32.dll" (ByVal dwMilliseconds As Long)
Public Declare Function PostMessage Lib "user32.dll" Alias "PostMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Public Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Public Declare Function sndPlaySound Lib "winmm.dll" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long

Public Sub ClientChooser()
Dim tibiaclient As Long
Dim lhWndP As Long
Dim i As Long

LoadAddress

'If GetHandleFromPartialClass(lhWndP, frmDebug.txtClassname.Text) = True Then
'    tibiaclient = lhWndP
'Else
'        If GetHandleFromPartialCaption(lhWndP, frmDebug.txtClassname.Text) = True Then
'        tibiaclient = lhWndP
'        End If
'End If

    Do
    tibiaclient = FindWindowEx(0, tibiaclient, tibiaclassname, vbNullString)
    If tibiaclient = 0 Then
      tibiaclient = FindWindow(tibiaclassname, vbNullString)
        If tibiaclient = 0 Then
            If GetHandleFromPartialCaption(lhWndP, partialCap) = True Then
                tibiaclient = lhWndP
            End If
            Exit Do
        End If
      Exit Do
    Else
    ShowCurrentName tibiaclient
    End If
    Loop

'If tibiaclient = 0 Then
'    If GetHandleFromPartialCaption(lhWndP, partialCap) = True Then
'        tibiaclient = lhWndP
'    End If
'End If

TibiaWindow = tibiaclient
  
'    Do
'    tibiaclient = FindWindowEx(0, tibiaclient, tibiaclassname, vbNullString)
'    If tibiaclient = 0 Then
'      tibiaclient = FindWindow(tibiaclassname, vbNullString)
'      Exit Do
'    Else
'    ShowCurrentName tibiaclient
'    End If
'    Loop
    
'If tibiaclient = 0 Then
'        If GetHandleFromPartialClass(lhWndP, tibiaclassname) = True Then
'            tibiaclient = lhWndP
'            ShowCurrentName tibiaclient
'        Else
'            If GetHandleFromPartialCaption(lhWndP, tibiaclassname) = True Then
'            tibiaclient = lhWndP
'            ShowCurrentName tibiaclient
'            End If
'        End If
'End If

'''''''''''''''''''''''''''''''''''' RetroCOres
'    If Menu.cmbVer.Text = "RetroCores 1.12" Then ''' RetroCores
'        If GetHandleFromPartialCaption(lhWndP, "Retro") = True Then
'            tibiaclient = lhWndP
'            'ShowCurrentName tibiaclient
'            'Menu.cmbChar.AddItem tibiaclient & " - " & "debug" 'force show in the list
'        Else
'        '
'        End If
'    End If
'
'''''''''''''''''''''''''''''''''''' SILENT CORES
'    If Menu.cmbVer.Text = "Silent Cores" Then
'        'If GetHandleFromPartialCaption(lhWndP, "Silent") = True Then
'        If GetHandleFromPartialClass(lhWndP, tibiaclassname) = True Then
'            tibiaclient = lhWndP
'            ShowCurrentName tibiaclient
'        Else
'            If GetHandleFromPartialCaption(lhWndP, "Silent") = True Then
'            tibiaclient = lhWndP
'            ShowCurrentName tibiaclient
'            End If
'        End If
'    End If
'
'''''''''''''''''''''''''''''''''''' RADBR
'    If Menu.cmbVer.Text = "RadBR 10.8" Then
'        If GetHandleFromPartialClass(lhWndP, tibiaclassname) = True Then
'            tibiaclient = lhWndP
'            ShowCurrentName tibiaclient
'        Else
'            If GetHandleFromPartialCaption(lhWndP, "Tibia") = True Then
'            tibiaclient = lhWndP
'            ShowCurrentName tibiaclient
'            End If
'        End If
'    End If
'
'''''''''''''''''''''''''''''''''''' DOSENT FIND TIBIA WINDOW
'maybe findwindowEx wont work on win8, 64bits os or some pcs

'If tibiaclient = 0 Then
'
'    If Menu.cmbVer.Text = "Realistic War" Then ''' RW
'            If GetHandleFromPartialCaption(lhWndP, "RW") = True Then
'            tibiaclient = lhWndP
'            ShowCurrentName tibiaclient
'            End If
'    ElseIf Menu.cmbVer.Text = "Classicus 5.20" Then ''' CLASSICUS
'            tibiaclient = FindWindow(tibiaclassname, vbNullString) ' "ÙbiaClient"
'            ShowCurrentName tibiaclient
'            If GetHandleFromPartialCaption(lhWndP, "Tibia") = True Then
'            tibiaclient = lhWndP
'            ShowCurrentName tibiaclient
'            End If
'    ElseIf Menu.cmbVer.Text = "Silent Cores" Then ''' SILENT CORES
'            If GetHandleFromPartialCaption(lhWndP, "Silent") = True Then
'            tibiaclient = lhWndP
'            ShowCurrentName tibiaclient
'            End If
'    ElseIf Menu.cmbVer.Text = "RadBR 10.8" Then ''' radBR
'            If GetHandleFromPartialCaption(lhWndP, "Tibia") = True Then
'            tibiaclient = lhWndP
'            ShowCurrentName tibiaclient
'            End If
'    ElseIf Menu.cmbVer.Text = "RetroCores 1.12" Then ''' RetroCores
'            If GetHandleFromPartialCaption(lhWndP, "Retro") = True Then
'            tibiaclient = lhWndP
'            'ShowCurrentName tibiaclient
'            End If
'    End If
'
'End If

End Sub

Public Sub OTClientHP()
'hwnd janela do tibia
Dim tibiaclient As Long
'Guarda o Handle da Janela = necessário para SendMessage PostMessage
Dim lWindowsHandle      As Long
'Guarda o ID do Processo
Dim lProcessID          As Long
'Guarda o Handle do Processo = necessário para ReadMemory e WriteMemory
Dim lProcessHandle      As Long
'Guarda o Endereço Base do Processo
Dim lProcessBase        As Long

tibiaclient = TibiaWindow

    lWindowsHandle = tibiaclient
    '
    lProcessID = GetProcessID(lWindowsHandle)
    '
    'A função abaixo evita um erro "acess_denied" que tava acontecendo
    DebugPrivilege
    '
    lProcessHandle = OpenProcess(PROCESS_READ_WRITE_QUERY, 0, lProcessID)
    '
    lProcessBase = GetBaseAddress(lProcessID, adrBaseAddress)
    
    MyHP = ReadPointerDouble(lProcessHandle, lProcessBase, mainAddress, tibia_HealthOffSet)
    MyMana = ReadPointerDouble(lProcessHandle, lProcessBase, mainAddress, tibia_ManaOffSet)
    
End Sub

Public Sub OTClientMyStatus()
'hwnd janela do tibia
Dim tibiaclient As Long
'Guarda o Handle da Janela = necessário para SendMessage PostMessage
Dim lWindowsHandle      As Long
'Guarda o ID do Processo
Dim lProcessID          As Long
'Guarda o Handle do Processo = necessário para ReadMemory e WriteMemory
Dim lProcessHandle      As Long
'Guarda o Endereço Base do Processo
Dim lProcessBase        As Long

tibiaclient = TibiaWindow

    lWindowsHandle = tibiaclient
    '
    lProcessID = GetProcessID(lWindowsHandle)
    '
    'A função abaixo evita um erro "acess_denied" que tava acontecendo
    DebugPrivilege
    '
    lProcessHandle = OpenProcess(PROCESS_READ_WRITE_QUERY, 0, lProcessID)
    '
    lProcessBase = GetBaseAddress(lProcessID, adrBaseAddress)
    
    MyX = ReadPointerLong(lProcessHandle, lProcessBase, mainAddress, myPosXOffset)
    MyY = ReadPointerLong(lProcessHandle, lProcessBase, mainAddress, myPosYOffset)
    MyZ = ReadPointerLong(lProcessHandle, lProcessBase, mainAddress, myPosZOffset)
    MySpeed = ReadPointerLong(lProcessHandle, lProcessBase, mainAddress, speedOffset)
    MyLight = ReadPointerByte(lProcessHandle, lProcessBase, mainAddress, lightOffset)
    MyStatus = ReadPointerLong(lProcessHandle, lProcessBase, mainAddress, myStatusOffset)
    
End Sub

Public Function hotkey(x As String) As String
Dim tibiaclient As Long
Dim iE3 As Long

tibiaclient = TibiaWindow

    If x = "F1" Or x = "f1" Then
        iE3 = 112
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "F2" Or x = "f2" Then
        iE3 = 113
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "F3" Or x = "f3" Then
        iE3 = 114
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "F4" Or x = "f4" Then
        iE3 = 115
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "F5" Or x = "f5" Then
        iE3 = 116
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "F6" Or x = "f6" Then
        iE3 = 117
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "F7" Or x = "f7" Then
        iE3 = 118
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "F8" Or x = "f8" Then
        iE3 = 119
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "F9" Or x = "f9" Then
        iE3 = 120
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "F10" Or x = "f10" Then
        iE3 = 121
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "F11" Or x = "f11" Then
        iE3 = 122
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "F12" Or x = "f12" Then
        iE3 = 123
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "S+F1" Then
        iE3 = 112
        PostMessage tibiaclient, WM_KEYDOWN, 16, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 16, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "S+F2" Then
        iE3 = 113
        PostMessage tibiaclient, WM_KEYDOWN, 16, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 16, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "S+F3" Then
        iE3 = 114
        PostMessage tibiaclient, WM_KEYDOWN, 16, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 16, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "S+F4" Then
        iE3 = 115
        PostMessage tibiaclient, WM_KEYDOWN, 16, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 16, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "S+F5" Then
        iE3 = 116
        PostMessage tibiaclient, WM_KEYDOWN, 16, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 16, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "S+F6" Then
        iE3 = 117
        PostMessage tibiaclient, WM_KEYDOWN, 16, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 16, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "S+F7" Then
        iE3 = 118
        PostMessage tibiaclient, WM_KEYDOWN, 16, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 16, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "S+F8" Then
        iE3 = 119
        PostMessage tibiaclient, WM_KEYDOWN, 16, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 16, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "S+F9" Then
        iE3 = 120
        PostMessage tibiaclient, WM_KEYDOWN, 16, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 16, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "S+F10" Then
        iE3 = 121
        PostMessage tibiaclient, WM_KEYDOWN, 16, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 16, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "S+F11" Then
        iE3 = 122
        PostMessage tibiaclient, WM_KEYDOWN, 16, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 16, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "S+F12" Then
        iE3 = 123
        PostMessage tibiaclient, WM_KEYDOWN, 16, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 16, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "C+F1" Then
        iE3 = 112
        PostMessage tibiaclient, WM_KEYDOWN, 17, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 17, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "C+F2" Then
        iE3 = 113
        PostMessage tibiaclient, WM_KEYDOWN, 17, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 17, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "C+F3" Then
        iE3 = 114
        PostMessage tibiaclient, WM_KEYDOWN, 17, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 17, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "C+F4" Then
        iE3 = 115
        PostMessage tibiaclient, WM_KEYDOWN, 17, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 17, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "C+F5" Then
        iE3 = 116
        PostMessage tibiaclient, WM_KEYDOWN, 17, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 17, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "C+F6" Then
        iE3 = 117
        PostMessage tibiaclient, WM_KEYDOWN, 17, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 17, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "C+F7" Then
        iE3 = 118
        PostMessage tibiaclient, WM_KEYDOWN, 17, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 17, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "C+F8" Then
        iE3 = 119
        PostMessage tibiaclient, WM_KEYDOWN, 17, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 17, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "C+F9" Then
        iE3 = 120
        PostMessage tibiaclient, WM_KEYDOWN, 17, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 17, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "C+F10" Then
        iE3 = 121
        PostMessage tibiaclient, WM_KEYDOWN, 17, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 17, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "C+F11" Then
        iE3 = 122
        PostMessage tibiaclient, WM_KEYDOWN, 17, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 17, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
        ElseIf x = "C+F12" Then
        iE3 = 123
        PostMessage tibiaclient, WM_KEYDOWN, 17, lparamvar
        PostMessage tibiaclient, WM_KEYDOWN, iE3, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 17, lparamvar
        PostMessage tibiaclient, WM_KEYUP, iE3, lparamvar
    End If
        
End Function

Public Sub HealingSub()
Dim tibiaclient As Long
Dim letra As String
Dim mp1 As Long
Dim mp2 As Long
Dim hp1 As Long
Dim hp2 As Long
Dim sp1 As String
Dim sp2 As String
Dim i As Long

tibiaclient = TibiaWindow
mp1 = CLng(Menu.txtMPLow.Text)
mp2 = CLng(Menu.txtMPHi.Text)
hp1 = CLng(Menu.txtLow.Text)
hp2 = CLng(Menu.txtHi.Text)
sp1 = Menu.txtSpellLow.Text
sp2 = Menu.txtSpellHi.Text

lngHp = lngHp + 100

If lngHp < CLng(Menu.txtHealtmr.Text) Then
    Exit Sub
Else
    lngHp = 0
End If

'spell cast

'heavy
If Menu.txtSpellHi.Text <> "" And Menu.txtSpellHi.Text <> "?" Then
If MyHP < hp2 And MyMana >= mp2 Then
prio1 = True
prio2 = True

        If Menu.txtSpellHi.Text = "F1" Or Menu.txtSpellHi.Text = "f1" Then
        PostMessage tibiaclient, WM_KEYDOWN, 112, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 112, lparamvar
        ElseIf Menu.txtSpellHi.Text = "F2" Or Menu.txtSpellHi.Text = "f2" Then
        PostMessage tibiaclient, WM_KEYDOWN, 113, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 113, lparamvar
        ElseIf Menu.txtSpellHi.Text = "F3" Or Menu.txtSpellHi.Text = "f3" Then
        PostMessage tibiaclient, WM_KEYDOWN, 114, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 114, lparamvar
        ElseIf Menu.txtSpellHi.Text = "F4" Or Menu.txtSpellHi.Text = "f4" Then
        PostMessage tibiaclient, WM_KEYDOWN, 115, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 115, lparamvar
        ElseIf Menu.txtSpellHi.Text = "F5" Or Menu.txtSpellHi.Text = "f5" Then
        PostMessage tibiaclient, WM_KEYDOWN, 116, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 116, lparamvar
        ElseIf Menu.txtSpellHi.Text = "F6" Or Menu.txtSpellHi.Text = "f6" Then
        PostMessage tibiaclient, WM_KEYDOWN, 117, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 117, lparamvar
        ElseIf Menu.txtSpellHi.Text = "F7" Or Menu.txtSpellHi.Text = "f7" Then
        PostMessage tibiaclient, WM_KEYDOWN, 118, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 118, lparamvar
        ElseIf Menu.txtSpellHi.Text = "F8" Or Menu.txtSpellHi.Text = "f8" Then
        PostMessage tibiaclient, WM_KEYDOWN, 119, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 119, lparamvar
        ElseIf Menu.txtSpellHi.Text = "F9" Or Menu.txtSpellHi.Text = "f9" Then
        PostMessage tibiaclient, WM_KEYDOWN, 120, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 120, lparamvar
        ElseIf Menu.txtSpellHi.Text = "F10" Or Menu.txtSpellHi.Text = "f10" Then
        PostMessage tibiaclient, WM_KEYDOWN, 121, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 121, lparamvar
        ElseIf Menu.txtSpellHi.Text = "F11" Or Menu.txtSpellHi.Text = "f11" Then
        PostMessage tibiaclient, WM_KEYDOWN, 122, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 122, lparamvar
        ElseIf Menu.txtSpellHi.Text = "F12" Or Menu.txtSpellHi.Text = "f12" Then
        PostMessage tibiaclient, WM_KEYDOWN, 123, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 123, lparamvar
        Else
            For i = 1 To Len(sp2)
            letra = Mid(sp2, i)
            PostMessage tibiaclient, WM_CHAR, Asc(letra), lparamvar
            Next i
            'PostMessage tibiaclient, WM_CHAR, 13, lparamvar
            SendSafeEnter
        End If
    
    GoTo priorities
    
End If
End If

'light
If Menu.txtSpellLow.Text <> "" And Menu.txtSpellLow.Text <> "?" Then
If MyHP < hp1 And MyMana >= mp1 And prio1 = False Then
If prio2 = False Then

        If Menu.txtSpellLow.Text = "F1" Or Menu.txtSpellLow.Text = "f1" Then
        PostMessage tibiaclient, WM_KEYDOWN, 112, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 112, lparamvar
        ElseIf Menu.txtSpellLow.Text = "F2" Or Menu.txtSpellLow.Text = "f2" Then
        PostMessage tibiaclient, WM_KEYDOWN, 113, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 113, lparamvar
        ElseIf Menu.txtSpellLow.Text = "F3" Or Menu.txtSpellLow.Text = "f3" Then
        PostMessage tibiaclient, WM_KEYDOWN, 114, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 114, lparamvar
        ElseIf Menu.txtSpellLow.Text = "F4" Or Menu.txtSpellLow.Text = "f4" Then
        PostMessage tibiaclient, WM_KEYDOWN, 115, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 115, lparamvar
        ElseIf Menu.txtSpellLow.Text = "F5" Or Menu.txtSpellLow.Text = "f5" Then
        PostMessage tibiaclient, WM_KEYDOWN, 116, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 116, lparamvar
        ElseIf Menu.txtSpellLow.Text = "F6" Or Menu.txtSpellLow.Text = "f6" Then
        PostMessage tibiaclient, WM_KEYDOWN, 117, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 117, lparamvar
        ElseIf Menu.txtSpellLow.Text = "F7" Or Menu.txtSpellLow.Text = "f7" Then
        PostMessage tibiaclient, WM_KEYDOWN, 118, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 118, lparamvar
        ElseIf Menu.txtSpellLow.Text = "F8" Or Menu.txtSpellLow.Text = "f8" Then
        PostMessage tibiaclient, WM_KEYDOWN, 119, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 119, lparamvar
        ElseIf Menu.txtSpellLow.Text = "F9" Or Menu.txtSpellLow.Text = "f9" Then
        PostMessage tibiaclient, WM_KEYDOWN, 120, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 120, lparamvar
        ElseIf Menu.txtSpellLow.Text = "F10" Or Menu.txtSpellLow.Text = "f10" Then
        PostMessage tibiaclient, WM_KEYDOWN, 121, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 121, lparamvar
        ElseIf Menu.txtSpellLow.Text = "F11" Or Menu.txtSpellLow.Text = "f11" Then
        PostMessage tibiaclient, WM_KEYDOWN, 122, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 122, lparamvar
        ElseIf Menu.txtSpellLow.Text = "F12" Or Menu.txtSpellLow.Text = "f12" Then
        PostMessage tibiaclient, WM_KEYDOWN, 123, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 123, lparamvar
        Else
            For i = 1 To Len(sp1)
            letra = Mid(sp1, i)
            PostMessage tibiaclient, WM_CHAR, Asc(letra), lparamvar
            Next i
            'PostMessage tibiaclient, WM_CHAR, 13, lparamvar
            SendSafeEnter
        End If
        
    GoTo priorities
    
End If
End If
End If

priorities:
prio1 = False
prio2 = False
'Sleep CLng(Menu.txtHealtmr.Text)

End Sub

Public Function GetTibiaVersionLong(ByVal TibiaVersion As String) As Long
    Dim thePoint As Long
    Dim partLeft As String
    Dim partRight As String
    Dim result As String
    Dim lngResult As Long
    thePoint = InStr(1, TibiaVersion, ".", vbTextCompare)
    If thePoint <= 0 Then
        MsgBox "Error at GetTibiaVersionLong(" & TibiaVersion & ")", vbOKOnly + vbCritical, "Critical Error"
        End
    End If
    partLeft = left$(TibiaVersion, thePoint - 1)
    partRight = Right$(TibiaVersion, Len(TibiaVersion) - thePoint)
    If Len(partRight) = 2 Then
        result = partLeft & partRight
    Else
        result = partLeft & partRight & "0"
    End If
    lngResult = CLng(result)
    GetTibiaVersionLong = lngResult
End Function

Public Sub ShowCurrentName(tibiaclient As Long)
  Dim myID As Long
  Dim tmpID As Long
  Dim bPos As Long
  Dim lastPos As Long
  Dim b As Byte
  Dim i As Long
  Dim myName As String
  Dim theBase As Long
  Dim theOffset As Long
  'allowRename = False
  
  'If Menu.cmbVer.Text = "RetroCores 1.12" Then
  '  myName = "UNKOWN"
  '  Menu.cmbChar.AddItem tibiaclient & " - " & (myName)
  '  Exit Sub
  'End If
  
  '      If useDynamicOffset = "yes" Then
  '          theBase = getProcessBase(tibiaclient, tibiaModuleRegionSize, True)
  '          If theBase = 0 Then
  '          'frmMain.Caption = "Address Error"
  '          Exit Sub
  '          End If
  '          theOffset = theBase - &H400000
  '      Else
  '          theOffset = 0
  '      End If
            
            
  '      myID = Memory_ReadLong2(theOffset + adrNum, tibiaclient)
  '      lastPos = -1
  '      For bPos = 0 To 147
  '        tmpID = Memory_ReadLong2(theOffset + adrNChar + (bPos * CharDist), tibiaclient)
  '        If tmpID = myID Then
  '          lastPos = bPos
  '          'Menu.Caption = "Bpos = " & CStr(lastPos)
  '          Exit For
  '        End If
  '      Next bPos
  '      If lastPos = -1 Then
  '       ' frmMain.lblDebug.Caption = "Bpos = -1"
  '      Else
  '        myName = ""
  '        i = 0
  '        Do
  '          b = Memory_ReadByte2((theOffset + adrNChar + (lastPos * CharDist) + NameDist + i), tibiaclient)
  '          If b <> &H0 Then
  '          myName = myName & Chr(b)
  '          i = i + 1
  '          End If
  '        Loop Until (b = &H0) Or (i > MAX_NAME_LENGHT)
  '        If i > 100 Then
  '          myName = "<Could not load any name>"
  '          'allowRename = False
  '          'Form1.txtName.Text = myName
  '        Else
  '          'allowRename = True
  '          'Form1.txtName.Text = myName
  '        End If
  '        'Form2.Text3.Text = myName
  '        'Form1.txtName.Text = myName
  '        'Form1.cmbChar.AddItem (myName) & " - " & tibiaclient
  '        'Form1.cmbChar.AddItem (myName)
  '        If myName = "" Then
  '        myName = "UNKOWN"
  '        End If
  '        Menu.cmbChar.AddItem tibiaclient & " - " & (myName)
  '        charName = myName
  '        'Menu.Caption = "RedMage" & " - " & myName
  '      End If
End Sub

Public Sub ShowCurrentName2(tibiaclient As Long)
  Dim myID As Long
  Dim tmpID As Long
  Dim bPos As Long
  Dim lastPos As Long
  Dim b As Byte
  Dim i As Long
  Dim myName As String
  Dim theBase As Long
  Dim theOffset As Long
  'allowRename = False
  
               If useDynamicOffset = "yes" Then
              theBase = getProcessBase(tibiaclient, tibiaModuleRegionSize, True)
              If theBase = 0 Then
                'frmMain.Caption = "Address Error"
                Exit Sub
              End If
              theOffset = theBase - &H400000
            Else
              theOffset = 0
            End If
            
            
        myID = Memory_ReadLong2(theOffset + adrNum, tibiaclient)
        lastPos = -1
        For bPos = 0 To 147
          tmpID = Memory_ReadLong2(theOffset + adrNChar + (bPos * CharDist), tibiaclient)
          If tmpID = myID Then
            lastPos = bPos
            'Menu.Caption = "Bpos = " & CStr(lastPos)
            Exit For
          End If
        Next bPos
        If lastPos = -1 Then
         ' frmMain.lblDebug.Caption = "Bpos = -1"
        Else
          myName = ""
          i = 0
          Do
            b = Memory_ReadByte2((theOffset + adrNChar + (lastPos * CharDist) + NameDist + i), tibiaclient)
            If b <> &H0 Then
            myName = myName & Chr(b)
            i = i + 1
            End If
          Loop Until (b = &H0) Or (i > MAX_NAME_LENGHT)
          If i > 100 Then
            myName = "<Could not load any name>"
            'allowRename = False
            'Form1.txtName.Text = myName
          Else
            'allowRename = True
            'Form1.txtName.Text = myName
          End If
          'Form2.Text3.Text = myName
          'Form1.txtName.Text = myName
          'Form1.cmbChar.AddItem (myName) & " - " & tibiaclient
          'Form1.cmbChar.AddItem (myName)
          If myName = "" Then
          myName = "UNKOWN"
          End If
          'Menu.cmbChar.AddItem tibiaclient & " - " & (myName)
          charName = myName
        End If
End Sub

Public Function Memory_ReadLong(ByVal address As Long, process_Hwnd As Long) As Long
  
   ' Declare some variables we need
   Dim pid As Long         ' Used to hold the Process Id
   Dim phandle As Long     ' Holds the Process Handle
   Dim valbuffer As Long   ' Long
    
   ' First get a handle to the "game" window
   If (process_Hwnd = 0) Then Exit Function
   
   ' We can now get the pid
   GetWindowThreadProcessId process_Hwnd, pid
   
   ' Use the pid to get a Process Handle
   'phandle = OpenProcess(PROCESS_VM_READ, False, pid)
   phandle = OpenProcess(PROCESS_READ_WRITE_QUERY, False, pid)
   If (phandle = 0) Then Exit Function
   
   If useDynamicOffsetBool = True Then
     If process_Hwnd <> TIBIA_LASTPID Then
        TIBIA_LASTPID = process_Hwnd
        TIBIA_LASTBASE = getProcessBase(phandle, tibiaModuleRegionSize, False)
        If TIBIA_LASTBASE = 0 Then
          Debug.Print "Address Error"
          TIBIA_LASTBASE = &H400000
        End If
        TIBIA_LASTOFFSET = TIBIA_LASTBASE - &H400000
     End If
     address = address + TIBIA_LASTOFFSET
   End If
   
   ' Read Long
   ReadProcessMemory phandle, address, valbuffer, 4, 0&
       
   ' Return
   Memory_ReadLong = valbuffer
   
   ' Close the Process Handle
   CloseHandle phandle
  
End Function

Public Function getProcessBase(ByVal hProcess As Long, ByVal expectedRegionSize As Long, Optional PIDinsteadHp As Boolean = False) As Long
    ' expectedRegionSize is used again
    Dim lpMem As Long, ret As Long, lLenMBI As Long
    Dim lWritten As Long, CalcAddress As Long, lPos As Long
    Dim sBuffer As String
    Dim sSearchString As String, sReplaceString As String
    Dim si As SYSTEM_INFO
    Dim mbi As MEMORY_BASIC_INFORMATION
    Dim realH As Long
    Dim pid As Long
    Dim res As Long
    If PIDinsteadHp = True Then
        res = GetWindowThreadProcessId(hProcess, pid)
        realH = OpenProcess(PROCESS_READ_WRITE_QUERY, False, pid)
        hProcess = realH
    End If
    Call GetSystemInfo(si)
    lpMem = si.lpMinimumApplicationAddress
    lLenMBI = Len(mbi)
    ' Scan memory
    Do While lpMem < si.lpMaximumApplicationAddress
        mbi.RegionSize = 0
        ret = VirtualQueryEx(hProcess, ByVal lpMem, mbi, lLenMBI)
        If ret = lLenMBI Then
           If (mbi.State = MEM_COMMIT) Then
                If mbi.AllocationProtect = &H80 Then
                If mbi.baseaddress - mbi.AllocationBase = &H1000 Then
                If mbi.Protect = &H20 Then
                If (mbi.RegionSize = expectedRegionSize) Then
                    res = mbi.AllocationBase
                    'Debug.Print "The new result is " & CStr(res)
                    If PIDinsteadHp = True Then
                      CloseHandle hProcess
                    End If
                    getProcessBase = res
                    Exit Function
                End If
                End If
                End If
                End If
           End If
           lpMem = mbi.baseaddress + mbi.RegionSize
        Else
           Exit Do
        End If
    Loop
    If PIDinsteadHp = True Then
       CloseHandle hProcess
    End If
End Function

Public Function Memory_ReadLong2(address As Long, process_Hwnd As Long) As Long
  
   ' Declare some variables we need
   Dim pid As Long         ' Used to hold the Process Id
   Dim phandle As Long     ' Holds the Process Handle
   Dim valbuffer As Long   ' Long
    
   ' First get a handle to the "game" window
   If (process_Hwnd = 0) Then Exit Function
   
   ' We can now get the pid
   GetWindowThreadProcessId process_Hwnd, pid
   
   ' Use the pid to get a Process Handle
   phandle = OpenProcess(PROCESS_VM_READ, False, pid)
   If (phandle = 0) Then Exit Function
   
   ' Read Long
   ReadProcessMemory phandle, address, valbuffer, 4, 0&
       
   ' Return
   Memory_ReadLong2 = valbuffer
   
   ' Close the Process Handle
   CloseHandle phandle
  
End Function

Public Function Memory_ReadByte2(address As Long, process_Hwnd As Long) As Byte
  
   ' Declare some variables we need
   Dim pid As Long         ' Used to hold the Process Id
   Dim phandle As Long     ' Holds the Process Handle
   Dim valbuffer As Byte   ' Byte
    
   ' First get a handle to the "game" window
   If (process_Hwnd = 0) Then Exit Function
   
   ' We can now get the pid
   GetWindowThreadProcessId process_Hwnd, pid
   
   ' Use the pid to get a Process Handle
   phandle = OpenProcess(PROCESS_VM_READ, False, pid)
   If (phandle = 0) Then Exit Function
   
   ' Read Long
   ReadProcessMemory phandle, address, valbuffer, 1, 0&
       
   ' Return
   Memory_ReadByte2 = valbuffer
   
   ' Close the Process Handle
   CloseHandle phandle
  
End Function

Public Sub HealingPotSub()
Dim hp As Long
Dim mp As Long
Dim x As String
Dim tibiaclient As Long

hp = CLng(Menu.txtHealPot.Text)
mp = CLng(Menu.txtManaPot.Text)

tibiaclient = TibiaWindow

lngMp = lngMp + 100

If lngMp < CLng(Menu.txtHealtmr.Text) Then
    Exit Sub
Else
    lngMp = 0
End If

'hp restore (prioridade sobre mp)
If MyHP < hp Then
x = Menu.cmbHotkey2.Text
    If Menu.cmbHotkey2.Text <> "--" Then
    prio1p = True
    prio2p = True
    hotkey x
    GoTo priorities
    End If
End If

'mana restore
If MyMana < mp Then
x = Menu.cmbHotkey1.Text
    If Menu.cmbHotkey1.Text <> "--" And prio2p = False Then
    hotkey x
    GoTo priorities
    End If
End If

priorities:
prio1p = False
prio2p = False
'Sleep CLng(Menu.txtManatmr.Text)

End Sub

Public Function GetHandleFromPartialCaption(ByRef lWnd As Long, ByVal sCaption As String) As Boolean
    Dim lhWndP As Long
    Dim sStr As String
    GetHandleFromPartialCaption = False
    lhWndP = FindWindow(vbNullString, vbNullString) 'PARENT WINDOW
    Do While lhWndP <> 0
        sStr = String(GetWindowTextLength(lhWndP) + 1, Chr$(0))
        GetWindowText lhWndP, sStr, Len(sStr)
        sStr = left$(sStr, Len(sStr) - 1)
        If InStr(1, sStr, sCaption) > 0 Then
            GetHandleFromPartialCaption = True
            lWnd = lhWndP
            Exit Do
        End If
        lhWndP = GetWindow(lhWndP, GW_HWNDNEXT)
    Loop
End Function

Public Function GetHandleFromPartialClass(ByRef lWnd As Long, ByVal sCaption As String) As Boolean
    Dim lhWndP As Long
    Dim sStr As String
    GetHandleFromPartialClass = False
    lhWndP = FindWindow(vbNullString, vbNullString) 'PARENT WINDOW
    Do While lhWndP <> 0
        sStr = String(GetWindowTextLength(lhWndP) + 1, Chr$(0))
        GetClassName lhWndP, sStr, Len(sStr)
        sStr = left$(sStr, Len(sStr) - 1)
        If InStr(1, sStr, sCaption) > 0 Then
            GetHandleFromPartialClass = True
            lWnd = lhWndP
            Exit Do
        End If
        lhWndP = GetWindow(lhWndP, GW_HWNDNEXT)
    Loop
End Function

Sub Wait(ByVal nSecond As Single)
   Dim t0 As Single
   t0 = Timer
   Do While Timer - t0 < nSecond
      Dim dummy As Integer
      dummy = DoEvents()
      ' if we cross midnight, back up one day
      If Timer < t0 Then
         t0 = t0 - CLng(24) * CLng(60) * CLng(60)
      End If
   Loop
End Sub

Public Function ApplPath() As String
  Dim Temp As String
  Temp = App.Path
  If Right(Temp, 1) <> "\" Then Temp = Temp & "\"
  ApplPath = Temp
End Function

Public Sub SendSafeEnter()
' if press alt while sending enter, will make tibia full screen, this functions avoid this issue
Dim tibiaclient As Long
Dim tibiaclient2 As Long

tibiaclient2 = GetForegroundWindow()
tibiaclient = TibiaWindow

' Prevents sending enter while pressing ALT
'If tibiaclient2 = tibiaclient Then '''''' focused tibia
'    If GetAsyncKeyState(VK_ALT) Then
'        Exit Sub
'    Else
'        If GetAsyncKeyState(VK_ALT) Then ''''' reinforcement
'            Exit Sub
'        Else
'            PostMessage tibiaclient, WM_CHAR, 13, lparamvar
'        End If
'    End If
'End If

PostMessage tibiaclient, WM_CHAR, 13, lparamvar
PostMessage tibiaclient, WM_KEYDOWN, 13, lparamvar
PostMessage tibiaclient, WM_KEYUP, 13, lparamvar

End Sub

Public Sub SilentHP()
'hwnd janela do tibia
Dim tibiaclient As Long
'Guarda o Handle da Janela = necessário para SendMessage PostMessage
Dim lWindowsHandle      As Long
'Guarda o ID do Processo
Dim lProcessID          As Long
'Guarda o Handle do Processo = necessário para ReadMemory e WriteMemory
Dim lProcessHandle      As Long
'Guarda o Endereço Base do Processo
Dim lProcessBase        As Long
'Guarda o Endereço Base da DLL
Dim lDLLBase            As Long
' Xor
Dim valueXOR            As Long

tibiaclient = TibiaWindow

    lWindowsHandle = tibiaclient
    '
    lProcessID = GetProcessID(lWindowsHandle)
    '
    'A função abaixo evita um erro "acess_denied" que tava acontecendo
    DebugPrivilege
    '
    lProcessHandle = OpenProcess(PROCESS_READ_WRITE_QUERY, 0, lProcessID)
    '
    lProcessBase = GetBaseAddress(lProcessID, "sc.exe")
    lDLLBase = GetBaseAddress(lProcessID, "silent.dll")
    
    MyHP = ReadPointerLong(lProcessHandle, lDLLBase, &H1AA420, tibia_HealthOffSet)
    MyMana = ReadPointerLong(lProcessHandle, lDLLBase, &H1AA13C, tibia_ManaOffSet)
    
    valueXOR = Memory_ReadLong(adrXOR, tibiaclient)
    
    MyHP = MyHP Xor valueXOR
    MyMana = MyMana Xor valueXOR

End Sub

Public Sub LoadAddress()

tibiaclassname = frmDebug.txtClassname.Text
partialCap = frmDebug.txtPartialcap.Text
tibia_HealthOffSet = CLng(frmDebug.txttibia_HealthOffSet.Text)
tibia_ManaOffSet = CLng(frmDebug.txttibia_ManaOffSet.Text)
mainAddress = CLng(frmDebug.txtMainAddress.Text)
adrBaseAddress = frmDebug.txtBaseAddress.Text
lightOffset = CLng(frmDebug.txtLightOffset.Text)
speedOffset = CLng(frmDebug.txtSpeedOffset.Text)
spyOffset = CLng(frmDebug.txtSpyOffset.Text)
myStatusOffset = CLng(frmDebug.txtStatusOffset.Text)
myPosXOffset = CLng(frmDebug.txtmyPosXOffset.Text)
myPosYOffset = CLng(frmDebug.txtmyPosYOffset.Text)
myPosZOffset = CLng(frmDebug.txtmyPosZOffset.Text)

End Sub

Public Function CheackFlag(ByVal Flag As Flag) As Boolean

    If Flag <> (MyStatus And Flag) Then
        CheackFlag = True
    Else
        CheackFlag = False
    End If
    
End Function

Public Sub OTClientAutoUtamo()
Dim tibiaclient As Long
Dim i As Long
Dim letra As String

tibiaclient = TibiaWindow

    If CheackFlag(ManaShield) = False Then
        'do nothing
    Else
      If MyMana >= CLng(frmDebug.txtUtamoMana.Text) And frmDebug.txtUtamo.Text <> "?" Then
        If frmDebug.txtUtamo.Text = "F1" Or frmDebug.txtUtamo.Text = "f1" Then
        PostMessage tibiaclient, WM_KEYDOWN, 112, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 112, lparamvar
        ElseIf frmDebug.txtUtamo.Text = "F2" Or frmDebug.txtUtamo.Text = "f2" Then
        PostMessage tibiaclient, WM_KEYDOWN, 113, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 113, lparamvar
        ElseIf frmDebug.txtUtamo.Text = "F3" Or frmDebug.txtUtamo.Text = "f3" Then
        PostMessage tibiaclient, WM_KEYDOWN, 114, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 114, lparamvar
        ElseIf frmDebug.txtUtamo.Text = "F4" Or frmDebug.txtUtamo.Text = "f4" Then
        PostMessage tibiaclient, WM_KEYDOWN, 115, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 115, lparamvar
        ElseIf frmDebug.txtUtamo.Text = "F5" Or frmDebug.txtUtamo.Text = "f5" Then
        PostMessage tibiaclient, WM_KEYDOWN, 116, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 116, lparamvar
        ElseIf frmDebug.txtUtamo.Text = "F6" Or frmDebug.txtUtamo.Text = "f6" Then
        PostMessage tibiaclient, WM_KEYDOWN, 117, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 117, lparamvar
        ElseIf frmDebug.txtUtamo.Text = "F7" Or frmDebug.txtUtamo.Text = "f7" Then
        PostMessage tibiaclient, WM_KEYDOWN, 118, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 118, lparamvar
        ElseIf frmDebug.txtUtamo.Text = "F8" Or frmDebug.txtUtamo.Text = "f8" Then
        PostMessage tibiaclient, WM_KEYDOWN, 119, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 119, lparamvar
        ElseIf frmDebug.txtUtamo.Text = "F9" Or frmDebug.txtUtamo.Text = "f9" Then
        PostMessage tibiaclient, WM_KEYDOWN, 120, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 120, lparamvar
        ElseIf frmDebug.txtUtamo.Text = "F10" Or frmDebug.txtUtamo.Text = "f10" Then
        PostMessage tibiaclient, WM_KEYDOWN, 121, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 121, lparamvar
        ElseIf frmDebug.txtUtamo.Text = "F11" Or frmDebug.txtUtamo.Text = "f11" Then
        PostMessage tibiaclient, WM_KEYDOWN, 122, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 122, lparamvar
        ElseIf frmDebug.txtUtamo.Text = "F12" Or frmDebug.txtUtamo.Text = "f12" Then
        PostMessage tibiaclient, WM_KEYDOWN, 123, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 123, lparamvar
        Else
            For i = 1 To Len(frmDebug.txtUtamo.Text)
                letra = Mid(frmDebug.txtUtamo.Text, i)
                PostMessage tibiaclient, WM_CHAR, Asc(letra), lparamvar
            Next i
            SendSafeEnter
        End If
      End If
    End If
    
End Sub

Public Sub OTClientAutoHur()
Dim tibiaclient As Long
Dim i As Long
Dim letra As String

tibiaclient = TibiaWindow

    If CheackFlag(Hasted) = False Then
        'do nothing
    Else
      If MyMana >= CLng(frmDebug.txtHurMana.Text) And frmDebug.txtHur.Text <> "?" Then
        If frmDebug.txtHur.Text = "F1" Or frmDebug.txtHur.Text = "f1" Then
        PostMessage tibiaclient, WM_KEYDOWN, 112, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 112, lparamvar
        ElseIf frmDebug.txtHur.Text = "F2" Or frmDebug.txtHur.Text = "f2" Then
        PostMessage tibiaclient, WM_KEYDOWN, 113, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 113, lparamvar
        ElseIf frmDebug.txtHur.Text = "F3" Or frmDebug.txtHur.Text = "f3" Then
        PostMessage tibiaclient, WM_KEYDOWN, 114, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 114, lparamvar
        ElseIf frmDebug.txtHur.Text = "F4" Or frmDebug.txtHur.Text = "f4" Then
        PostMessage tibiaclient, WM_KEYDOWN, 115, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 115, lparamvar
        ElseIf frmDebug.txtHur.Text = "F5" Or frmDebug.txtHur.Text = "f5" Then
        PostMessage tibiaclient, WM_KEYDOWN, 116, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 116, lparamvar
        ElseIf frmDebug.txtHur.Text = "F6" Or frmDebug.txtHur.Text = "f6" Then
        PostMessage tibiaclient, WM_KEYDOWN, 117, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 117, lparamvar
        ElseIf frmDebug.txtHur.Text = "F7" Or frmDebug.txtHur.Text = "f7" Then
        PostMessage tibiaclient, WM_KEYDOWN, 118, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 118, lparamvar
        ElseIf frmDebug.txtHur.Text = "F8" Or frmDebug.txtHur.Text = "f8" Then
        PostMessage tibiaclient, WM_KEYDOWN, 119, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 119, lparamvar
        ElseIf frmDebug.txtHur.Text = "F9" Or frmDebug.txtHur.Text = "f9" Then
        PostMessage tibiaclient, WM_KEYDOWN, 120, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 120, lparamvar
        ElseIf frmDebug.txtHur.Text = "F10" Or frmDebug.txtHur.Text = "f10" Then
        PostMessage tibiaclient, WM_KEYDOWN, 121, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 121, lparamvar
        ElseIf frmDebug.txtHur.Text = "F11" Or frmDebug.txtHur.Text = "f11" Then
        PostMessage tibiaclient, WM_KEYDOWN, 122, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 122, lparamvar
        ElseIf frmDebug.txtHur.Text = "F12" Or frmDebug.txtHur.Text = "f12" Then
        PostMessage tibiaclient, WM_KEYDOWN, 123, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 123, lparamvar
        Else
            For i = 1 To Len(frmDebug.txtHur.Text)
                letra = Mid(frmDebug.txtHur.Text, i)
                PostMessage tibiaclient, WM_CHAR, Asc(letra), lparamvar
            Next i
            SendSafeEnter
        End If
      End If
    End If
    
End Sub

Public Sub OTClientManaTrainer()
Dim tibiaclient As Long
Dim i As Long
Dim letra As String

tibiaclient = TibiaWindow

    If MyMana >= CLng(Menu.txtManaTrain.Text) And Menu.txtTrainSpell.Text <> "?" Then
        If Menu.txtTrainSpell.Text = "F1" Or Menu.txtTrainSpell.Text = "f1" Then
        PostMessage tibiaclient, WM_KEYDOWN, 112, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 112, lparamvar
        ElseIf Menu.txtTrainSpell.Text = "F2" Or Menu.txtTrainSpell.Text = "f2" Then
        PostMessage tibiaclient, WM_KEYDOWN, 113, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 113, lparamvar
        ElseIf Menu.txtTrainSpell.Text = "F3" Or Menu.txtTrainSpell.Text = "f3" Then
        PostMessage tibiaclient, WM_KEYDOWN, 114, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 114, lparamvar
        ElseIf Menu.txtTrainSpell.Text = "F4" Or Menu.txtTrainSpell.Text = "f4" Then
        PostMessage tibiaclient, WM_KEYDOWN, 115, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 115, lparamvar
        ElseIf Menu.txtTrainSpell.Text = "F5" Or Menu.txtTrainSpell.Text = "f5" Then
        PostMessage tibiaclient, WM_KEYDOWN, 116, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 116, lparamvar
        ElseIf Menu.txtTrainSpell.Text = "F6" Or Menu.txtTrainSpell.Text = "f6" Then
        PostMessage tibiaclient, WM_KEYDOWN, 117, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 117, lparamvar
        ElseIf Menu.txtTrainSpell.Text = "F7" Or Menu.txtTrainSpell.Text = "f7" Then
        PostMessage tibiaclient, WM_KEYDOWN, 118, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 118, lparamvar
        ElseIf Menu.txtTrainSpell.Text = "F8" Or Menu.txtTrainSpell.Text = "f8" Then
        PostMessage tibiaclient, WM_KEYDOWN, 119, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 119, lparamvar
        ElseIf Menu.txtTrainSpell.Text = "F9" Or Menu.txtTrainSpell.Text = "f9" Then
        PostMessage tibiaclient, WM_KEYDOWN, 120, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 120, lparamvar
        ElseIf Menu.txtTrainSpell.Text = "F10" Or Menu.txtTrainSpell.Text = "f10" Then
        PostMessage tibiaclient, WM_KEYDOWN, 121, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 121, lparamvar
        ElseIf Menu.txtTrainSpell.Text = "F11" Or Menu.txtTrainSpell.Text = "f11" Then
        PostMessage tibiaclient, WM_KEYDOWN, 122, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 122, lparamvar
        ElseIf Menu.txtTrainSpell.Text = "F12" Or Menu.txtTrainSpell.Text = "f12" Then
        PostMessage tibiaclient, WM_KEYDOWN, 123, lparamvar
        PostMessage tibiaclient, WM_KEYUP, 123, lparamvar
        Else
            For i = 1 To Len(Menu.txtTrainSpell.Text)
                letra = Mid(Menu.txtTrainSpell.Text, i)
                PostMessage tibiaclient, WM_CHAR, Asc(letra), lparamvar
            Next i
            'PostMessage tibiaclient, WM_CHAR, 13, lparamvar
            SendSafeEnter
        End If
    End If

End Sub
