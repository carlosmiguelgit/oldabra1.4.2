Attribute VB_Name = "ModSettings"
Option Explicit

Public hHook As Long
Public FileDialog As OPENFILENAME

Public Declare Sub CoTaskMemFree Lib "ole32" (ByVal pvoid As Long)
Public Declare Function UnhookWindowsHookEx Lib "user32" (ByVal hHook As Long) As Long
Public Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Public Declare Function GetCurrentThreadId Lib "kernel32" () As Long
Public Declare Function SetWindowsHookEx Lib "user32" Alias "SetWindowsHookExA" (ByVal idHook As Long, ByVal lpfn As Long, ByVal hmod As Long, ByVal dwThreadId As Long) As Long

Public Type SelectedFile
    nFilesSelected As Integer
    sFiles() As String
    sLastDirectory As String
    bCanceled As Boolean
End Type

Public Type SelectedColor
    oSelectedColor As OLE_COLOR
    bCanceled As Boolean
End Type

Public Type SelectedFont
    sSelectedFont As String
    bCanceled As Boolean
    bBold As Boolean
    bItalic As Boolean
    nSize As Integer
    bUnderline As Boolean
    bStrikeOut As Boolean
    lColor As Long
    sFaceName As String
End Type

      Public Const SWP_NOMOVE = 2
      Public Const SWP_NOSIZE = 1
      Public Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
      Public Const HWND_TOPMOST = -1
      Public Const HWND_NOTOPMOST = -2
      
      Declare Function SetWindowPos Lib "user32" _
            (ByVal hwnd As Long, _
            ByVal hWndInsertAfter As Long, _
            ByVal x As Long, _
            ByVal y As Long, _
            ByVal cx As Long, _
            ByVal cy As Long, _
            ByVal wFlags As Long) As Long

Public Const MAX_PATH = 260
Public Const GWL_HINSTANCE = (-6)
Public Const SWP_NOZORDER = &H4
Public Const SWP_NOACTIVATE = &H10
Public Const HCBT_ACTIVATE = 5
Public Const WH_CBT = 5
Public Const OFN_ALLOWMULTISELECT = &H200
Public Const OFN_CREATEPROMPT = &H2000
Public Const OFN_ENABLEHOOK = &H20
Public Const OFN_ENABLETEMPLATE = &H40
Public Const OFN_ENABLETEMPLATEHANDLE = &H80
Public Const OFN_EXPLORER = &H80000
Public Const OFN_EXTENSIONDIFFERENT = &H400
Public Const OFN_FILEMUSTEXIST = &H1000
Public Const OFN_HIDEREADONLY = &H4
Public Const OFN_LONGNAMES = &H200000
Public Const OFN_NOCHANGEDIR = &H8
Public Const OFN_NODEREFERENCELINKS = &H100000
Public Const OFN_NOLONGNAMES = &H40000
Public Const OFN_NONETWORKBUTTON = &H20000
Public Const OFN_NOREADONLYRETURN = &H8000
Public Const OFN_NOTESTFILECREATE = &H10000
Public Const OFN_NOVALIDATE = &H100
Public Const OFN_OVERWRITEPROMPT = &H2
Public Const OFN_PATHMUSTEXIST = &H800
Public Const OFN_READONLY = &H1
Public Const OFN_SHAREAWARE = &H4000
Public Const OFN_SHAREFALLTHROUGH = 2
Public Const OFN_SHAREWARN = 0
Public Const OFN_SHARENOWARN = 1
Public Const OFN_SHOWHELP = &H10
Public Const OFS_MAXPATHNAME = 256
Public Const CSIDL_ADMINTOOLS As Long = &H30
Public Const CSIDL_ALTSTARTUP As Long = &H1D
Public Const CSIDL_APPDATA As Long = &H1A
Public Const CSIDL_BITBUCKET As Long = &HA
Public Const CSIDL_COMMON_ADMINTOOLS As Long = &H2F
Public Const CSIDL_COMMON_ALTSTARTUP As Long = &H1E
Public Const CSIDL_COMMON_APPDATA As Long = &H23
Public Const CSIDL_COMMON_DESKTOPDIRECTORY As Long = &H19
Public Const CSIDL_COMMON_DOCUMENTS As Long = &H2E
Public Const CSIDL_COMMON_FAVORITES As Long = &H1F
Public Const CSIDL_COMMON_PROGRAMS As Long = &H17
Public Const CSIDL_COMMON_STARTMENU As Long = &H16
Public Const CSIDL_COMMON_STARTUP As Long = &H18
Public Const CSIDL_COMMON_TEMPLATES As Long = &H2D
Public Const CSIDL_CONNECTIONS As Long = &H31
Public Const CSIDL_CONTROLS As Long = &H3
Public Const CSIDL_COOKIES As Long = &H21
Public Const CSIDL_DESKTOP As Long = &H0
Public Const CSIDL_DESKTOPDIRECTORY As Long = &H10
Public Const CSIDL_DRIVES As Long = &H11
Public Const CSIDL_FAVORITES As Long = &H6
Public Const CSIDL_FLAG_DONT_VERIFY As Long = &H4000
Public Const CSIDL_FLAG_MASK As Long = &HFF00&
Public Const CSIDL_FLAG_PFTI_TRACKTARGET As Long = CSIDL_FLAG_DONT_VERIFY
Public Const CSIDL_FONTS As Long = &H14
Public Const CSIDL_INTERNET As Long = &H1
Public Const CSIDL_HISTORY As Long = &H22
Public Const CSIDL_INTERNET_CACHE As Long = &H20
Public Const CSIDL_LOCAL_APPDATA As Long = &H1C
Public Const CSIDL_MYPICTURES As Long = &H27
Public Const CSIDL_NETHOOD As Long = &H13
Public Const CSIDL_NETWORK As Long = &H12
Public Const CSIDL_PERSONAL As Long = &H5
Public Const CSIDL_PRINTERS As Long = &H4
Public Const CSIDL_PRINTHOOD As Long = &H1B
Public Const CSIDL_PROFILE As Long = &H28
Public Const CSIDL_PROGRAM_FILES As Long = &H26
Public Const CSIDL_PROGRAM_FILES_COMMON As Long = &H2B
Public Const CSIDL_PROGRAM_FILES_COMMONX86 As Long = &H2C
Public Const CSIDL_PROGRAM_FILESX86 As Long = &H2A
Public Const CSIDL_PROGRAMS As Long = &H2
Public Const CSIDL_RECENT As Long = &H8
Public Const CSIDL_SENDTO As Long = &H9
Public Const CSIDL_STARTMENU As Long = &HB
Public Const CSIDL_STARTUP As Long = &H7
Public Const CSIDL_SYSTEM As Long = &H25
Public Const CSIDL_SYSTEMX86 As Long = &H29
Public Const CSIDL_TEMPLATES As Long = &H15
Public Const CSIDL_WINDOWS As Long = &H24
Public Const NOERROR = 0

Public Type RECT
    left As Long
    top As Long
    Right As Long
    Bottom As Long
End Type

Public Type OPENFILENAME
    nStructSize As Long
    hwndOwner As Long
    hInstance As Long
    sFilter As String
    sCustomFilter As String
    nCustFilterSize As Long
    nFilterIndex As Long
    sFile As String
    nFileSize As Long
    sFileTitle As String
    nTitleSize As Long
    sInitDir As String
    sDlgTitle As String
    FLAGS As Long
    nFileOffset As Integer
    nFileExt As Integer
    sDefFileExt As String
    nCustDataSize As Long
    fnHook As Long
    sTemplateName As String
End Type

Public Type CHOOSECOLORS
    lStructSize As Long
    hwndOwner As Long
    hInstance As Long
    rgbResult As Long
    lpCustColors As String
    FLAGS As Long
    lCustData As Long
    lpfnHook As Long
    lpTemplateName As String
End Type

Public Type CHOOSEFONTS
    lStructSize As Long
    hwndOwner As Long          '  caller's window handle
    hDC As Long                '  printer DC/IC or NULL
    lpLogFont As Long          '  ptr. to a LOGFONT struct
    iPointSize As Long         '  10 * size in points of selected font
    FLAGS As Long              '  enum. type flags
    rgbColors As Long          '  returned text color
    lCustData As Long          '  data passed to hook fn.
    lpfnHook As Long           '  ptr. to hook function
    lpTemplateName As String     '  custom template name
    hInstance As Long          '  instance handle of.EXE that
    lpszStyle As String          '  return the style field here
    nFontType As Integer          '  same value reported to the EnumFonts
    MISSING_ALIGNMENT As Integer
    nSizeMin As Long           '  minimum pt size allowed &
    nSizeMax As Long           '  max pt size allowed if
End Type

Public Type PRINTDLGS
        lStructSize As Long
        hwndOwner As Long
        hDevMode As Long
        hDevNames As Long
        hDC As Long
        FLAGS As Long
        nFromPage As Integer
        nToPage As Integer
        nMinPage As Integer
        nMaxPage As Integer
        nCopies As Integer
        hInstance As Long
        lCustData As Long
        lpfnPrintHook As Long
        lpfnSetupHook As Long
        lpPrintTemplateName As String
        lpSetupTemplateName As String
        hPrintTemplate As Long
        hSetupTemplate As Long
End Type

Public Declare Function SHGetPathFromIDList _
    Lib "shell32" Alias "SHGetPathFromIDListA" _
    (ByVal Pidl As Long, ByVal pszPath As String) As Long

Public Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As RECT) As Long

Public Const OFS_FILE_OPEN_FLAGS = OFN_EXPLORER Or OFN_LONGNAMES Or OFN_CREATEPROMPT Or OFN_NODEREFERENCELINKS Or OFN_HIDEREADONLY Or OFN_ALLOWMULTISELECT
Public Const OFS_FILE_SAVE_FLAGS = OFN_EXPLORER Or OFN_LONGNAMES Or OFN_OVERWRITEPROMPT Or OFN_HIDEREADONLY

Public Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" _
(ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As _
String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFilename As String) As Long

Public Declare Function SHGetSpecialFolderLocation _
    Lib "shell32" (ByVal hwnd As Long, _
    ByVal nFolder As Long, ppidl As Long) As Long
Public Declare Function WritePrivateProfileString Lib "kernel32" Alias _
"WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As _
Any, ByVal lpString As Any, ByVal lpFilename As String) As Long
Public Declare Function GetOpenFileName Lib "comdlg32.dll" Alias "GetOpenFileNameA" (pOpenfilename As OPENFILENAME) As Long
Public Declare Function GetSaveFileName Lib "comdlg32.dll" Alias "GetSaveFileNameA" (pOpenfilename As OPENFILENAME) As Long
Public Declare Function ChooseColor Lib "comdlg32.dll" Alias "ChooseColorA" (pChoosecolor As CHOOSECOLORS) As Long
Public Declare Function CommDlgExtendedError Lib "comdlg32.dll" () As Long
Public Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal lpszLongPath As String, ByVal lpszShortPath As String, ByVal cchBuffer As Long) As Long
Public Declare Function ChooseFont Lib "comdlg32.dll" Alias "ChooseFontA" (pChoosefont As CHOOSEFONTS) As Long
Public Declare Function PrintDlg Lib "comdlg32.dll" Alias "PrintDlgA" (pPrintdlg As PRINTDLGS) As Long
Dim ParenthWnd As Long

Public Sub PreloadChar()
Dim strPath As String
Dim strRes As String
Dim strFPath As String

    LoadSettings strPath
    
    strPath = App.Path & "\Save"
    If Right$(strPath, 1) <> "\" Then
        strPath = strPath & "\"
    End If

    'strFPath = strPath & charName & ".ini"
    strFPath = strPath & "default" & ".ini"
    strRes = LoadSettings(strFPath)
    If strRes <> "" Then
    'nothing
    End If

End Sub

Public Sub PreloadDefault()
Dim strPath As String
Dim strRes As String
Dim strFPath As String

    LoadSettings strPath
    
    strPath = App.Path & "\Save"
    If Right$(strPath, 1) <> "\" Then
        strPath = strPath & "\"
    End If

    'strFPath = strPath & charName & ".ini"
    strFPath = strPath & "default" & ".ini"
    strRes = LoadSettings(strFPath)
    If strRes <> "" Then
    'nothing
    End If

End Sub

Public Function LoadSettings(strPath As String) As String
  #If FinalMode = 1 Then
  On Error GoTo goterr
  #End If
    Dim strInfo As String
    Dim i As Long
    Dim lonInfo As Long
    Dim strThing As String
    Dim here As String
    Dim y As Integer
    Dim Hk1 As String
    here = strPath
    

    'LOAD ADDRESS SETTINGS''''''''''''''''''''''''''''
    strInfo = String$(50, 0)
    strThing = "txtClassname"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtClassname.Text = strInfo
    End If
    
    strInfo = String$(50, 0)
    strThing = "txtPartialcap"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtPartialcap.Text = strInfo
    End If
    
    strInfo = String$(50, 0)
    strThing = "txttibia_HealthOffSet"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txttibia_HealthOffSet.Text = strInfo
    End If
    
    strInfo = String$(50, 0)
    strThing = "txttibia_ManaOffSet"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txttibia_ManaOffSet.Text = strInfo
    End If
    
    strInfo = String$(50, 0)
    strThing = "txtMainAddress"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtMainAddress.Text = strInfo
    End If
    
    strInfo = String$(50, 0)
    strThing = "txtBaseAddress"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtBaseAddress.Text = strInfo
    End If
    
    strInfo = String$(50, 0)
    strThing = "txtLightOffset"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtLightOffset.Text = strInfo
    End If
    
    strInfo = String$(50, 0)
    strThing = "txtUtamo"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtUtamo.Text = strInfo
    End If
    
    strInfo = String$(50, 0)
    strThing = "txtHur"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtHur.Text = strInfo
    End If
    
    strInfo = String$(50, 0)
    strThing = "txtHurMana"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtHurMana.Text = strInfo
    End If
    
    strInfo = String$(50, 0)
    strThing = "scrollLight"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.scrollLight.Value = strInfo
    End If

    strInfo = String$(50, 0)
    strThing = "txtUtamoMana"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtUtamoMana.Text = strInfo
    End If
    
    strInfo = String$(50, 0)
    strThing = "txtSpeedOffset"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtSpeedOffset.Text = strInfo
    End If
    
    strInfo = String$(50, 0)
    strThing = "txtSpyOffset"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtSpyOffset.Text = strInfo
    End If

    strInfo = String$(50, 0)
    strThing = "txtStatusOffset"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtStatusOffset.Text = strInfo
    End If
    
    strInfo = String$(50, 0)
    strThing = "txtmyPosZOffset"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtmyPosZOffset.Text = strInfo
    End If

    strInfo = String$(50, 0)
    strThing = "txtmyPosXOffset"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtmyPosXOffset.Text = strInfo
    End If

    strInfo = String$(50, 0)
    strThing = "txtmyPosYOffset"
    i = getfromINI("Address", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        frmDebug.txtmyPosYOffset.Text = strInfo
    End If
    
    '''''''''''''''''''''''''''''''''''''''''''''''''''
    
    'spell hi text
    strInfo = String$(50, 0)
    strThing = "SpellHi"
    i = getfromINI("Healing", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        'lonInfo = CLng(strInfo)
        Menu.txtSpellLow.Text = strInfo 'lonInfo
    End If
    
    'spell low text
    strInfo = String$(50, 0)
    strThing = "SpellLo"
    i = getfromINI("Healing", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        'lonInfo = CLng(strInfo)
        Menu.txtSpellHi.Text = strInfo 'lonInfo
    End If
    
    'life healhi
    strInfo = String$(50, 0)
    strThing = "Heal1"
    i = getfromINI("Healing", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        Menu.txtLow.Text = lonInfo
    End If
    
    'life heallow
    strInfo = String$(50, 0)
    strThing = "Heal3"
    i = getfromINI("Healing", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        Menu.txtHi.Text = lonInfo
    End If
    
    'mana hi
    strInfo = String$(50, 0)
    strThing = "Mana1"
    i = getfromINI("Healing", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        Menu.txtMPLow.Text = lonInfo
    End If
    
    'mana lo
    strInfo = String$(50, 0)
    strThing = "Mana3"
    i = getfromINI("Healing", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        Menu.txtMPHi.Text = lonInfo
    End If
    
    'cmb heal mp
    strInfo = String$(50, 0)
    strThing = "CmbHeal1"
    i = getfromINI("Healing", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        'lonInfo = CLng(strInfo)
        Menu.cmbHotkey1.Text = strInfo 'lonInfo
    End If
    
    'cmb heal hp
    strInfo = String$(50, 0)
    strThing = "CmbHeal3"
    i = getfromINI("Healing", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        'lonInfo = CLng(strInfo)
        Menu.cmbHotkey2.Text = strInfo 'lonInfo
    End If
    
    'healing potion mana
    strInfo = String$(50, 0)
    strThing = "txtManaPot"
    i = getfromINI("Healing", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        Menu.txtManaPot.Text = lonInfo
    End If
    
    'healing potion heal
    strInfo = String$(50, 0)
    strThing = "txtHealPot"
    i = getfromINI("Healing", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        Menu.txtHealPot.Text = lonInfo
    End If
    
    'chk AutoEat
    strInfo = String$(10, 0)
    strThing = "AutoEat"
    i = getfromINI("Extras", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        If lonInfo = 1 Then
            Menu.chkEat.Value = 1
        Else
            Menu.chkEat.Value = 0
        End If
    Else
        Menu.chkEat.Value = 0
    End If
    
    'chk AutoLight
    strInfo = String$(10, 0)
    strThing = "AutoLight"
    i = getfromINI("Extras", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        If lonInfo = 1 Then
            Menu.chkLight.Value = 1
        Else
            Menu.chkLight.Value = 0
        End If
    Else
        Menu.chkLight.Value = 0
    End If

    'chk AutoFlash
    strInfo = String$(10, 0)
    strThing = "AutoFlash"
    i = getfromINI("Extras", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        If lonInfo = 1 Then
            Menu.chkFlash.Value = 1
        Else
            Menu.chkFlash.Value = 0
        End If
    Else
        Menu.chkFlash.Value = 0
    End If
    
    'chk AutoIdle
    strInfo = String$(10, 0)
    strThing = "AntiIdle"
    i = getfromINI("Extras", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        If lonInfo = 1 Then
            Menu.chkIdle.Value = 1
        Else
            Menu.chkIdle.Value = 0
        End If
    Else
        Menu.chkIdle.Value = 0
    End If
    
    'chk train
    strInfo = String$(10, 0)
    strThing = "AutoTrain"
    i = getfromINI("Extras", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        If lonInfo = 1 Then
            Menu.chkTrain.Value = 1
        Else
            Menu.chkTrain.Value = 0
        End If
    Else
        Menu.chkTrain.Value = 0
    End If
    
    'chk speed
    strInfo = String$(10, 0)
    strThing = "Speed"
    i = getfromINI("Extras", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        If lonInfo = 1 Then
            Menu.chkSpeed.Value = 1
        Else
            Menu.chkSpeed.Value = 0
        End If
    Else
        Menu.chkSpeed.Value = 0
    End If
    
    'chk utamo
    strInfo = String$(10, 0)
    strThing = "chkUtamo"
    i = getfromINI("Extras", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        If lonInfo = 1 Then
            Menu.chkUtamo.Value = 1
        Else
            Menu.chkUtamo.Value = 0
        End If
    Else
        Menu.chkUtamo.Value = 0
    End If
    
    'chk hur
    strInfo = String$(10, 0)
    strThing = "chkHur"
    i = getfromINI("Extras", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        If lonInfo = 1 Then
            Menu.chkHur.Value = 1
        Else
            Menu.chkHur.Value = 0
        End If
    Else
        Menu.chkHur.Value = 0
    End If

    'SpellTrain
    strInfo = String$(50, 0)
    strThing = "SpellTrain1"
    i = getfromINI("Extras", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        'lonInfo = CLng(strInfo)
        Menu.txtTrainSpell.Text = strInfo 'lonInfo
    Else
        Menu.txtTrainSpell.Text = "utevo lux"
    End If

   ' 'Spell Mana
    strInfo = String$(50, 0)
    strThing = "SpellTrain2"
    i = getfromINI("Extras", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        Menu.txtManaTrain.Text = lonInfo
        Else
        Menu.txtManaTrain.Text = "0"
    End If
    
    'config hp delay
    strInfo = String$(50, 0)
    strThing = "hpdelay"
    i = getfromINI("Extras", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        lonInfo = CLng(strInfo)
        Menu.txtHealtmr.Text = lonInfo
    End If
    
   '
    'cmb eat extras
    strInfo = String$(50, 0)
    strThing = "CmbEat"
    i = getfromINI("Extras", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        'lonInfo = CLng(strInfo)
        Menu.cmbEat.Text = strInfo 'lonInfo
    Else
        'LoadSettings = "Could not read the value of " & strThing
        'Exit Function
    End If
    
    'txtFlash
    strInfo = String$(50, 0)
    strThing = "txtFlash"
    i = getfromINI("Extras", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        'lonInfo = CLng(strInfo)
        Menu.txtFlash.Text = strInfo
    End If
    
    'outros
    strInfo = String$(255, 0)
    strThing = "TibiaExePath"
    i = getfromINI("Misc", strThing, "", strInfo, Len(strInfo), strPath)
    If i > 0 Then
        strInfo = left(strInfo, i)
        TibiaExePath = strInfo
    Else
        TibiaExePath = ""

    End If
    If Not (OverwriteTibiaExePath = "") Then
        TibiaExePath = OverwriteTibiaExePath
    ElseIf TibiaExePath = "" Then
        TibiaExePath = autoGetTibiaFolder()
    End If
    If (Not (TibiaExePath = "")) Then
        If (Not (Right$(TibiaExePath, 1) = "\")) Then
            TibiaExePath = TibiaExePath & "\"
        End If
    End If
    
        'Debug.Print DatTiles(1294).blocking
    
    LoadSettings = ""
    Exit Function
goterr:
    LoadSettings = "LoadSettings: Got error code " & Err.Number & ": " & Err.Description
End Function

Public Function SaveSettings(ByVal strPath As String) As String
    On Error GoTo goterr
    Dim strInfo As String
    Dim i As Long
    Dim y As Integer
    Dim Hk1 As String
    
    'spell cast heal
    strInfo = CStr(Menu.txtSpellLow.Text)
    i = setToINI("Healing", "SpellHi", strInfo, strPath)
    strInfo = CStr(Menu.txtSpellHi.Text)
    i = setToINI("Healing", "SpellLo", strInfo, strPath)
    
    'healing life
    strInfo = CStr(Menu.txtLow.Text)
    i = setToINI("Healing", "Heal1", strInfo, strPath)
    strInfo = CStr(Menu.txtHi.Text)
    i = setToINI("Healing", "Heal3", strInfo, strPath)
    
    'healing potions
    strInfo = CStr(Menu.txtManaPot.Text)
    i = setToINI("Healing", "txtManaPot", strInfo, strPath)
    strInfo = CStr(Menu.txtHealPot.Text)
    i = setToINI("Healing", "txtHealPot", strInfo, strPath)
    
    'save mana
    strInfo = CStr(Menu.txtMPLow.Text)
    i = setToINI("Healing", "Mana1", strInfo, strPath)
    strInfo = CStr(Menu.txtMPHi.Text)
    i = setToINI("Healing", "Mana3", strInfo, strPath)
    
    'save cmb heal
    strInfo = CStr(Menu.cmbHotkey1.Text)
    i = setToINI("Healing", "CmbHeal1", strInfo, strPath)
    strInfo = CStr(Menu.cmbHotkey2.Text)
    i = setToINI("Healing", "CmbHeal3", strInfo, strPath)
    
    'SAVE DEBUG ADDRESS
    strInfo = CStr(frmDebug.txtClassname.Text)
    i = setToINI("Address", "txtClassname", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txtPartialcap.Text)
    i = setToINI("Address", "txtPartialcap", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txttibia_HealthOffSet.Text)
    i = setToINI("Address", "txttibia_HealthOffSet", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txttibia_ManaOffSet.Text)
    i = setToINI("Address", "txttibia_ManaOffSet", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txtMainAddress.Text)
    i = setToINI("Address", "txtMainAddress", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txtBaseAddress.Text)
    i = setToINI("Address", "txtBaseAddress", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txtLightOffset.Text)
    i = setToINI("Address", "txtLightOffset", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txtUtamo.Text)
    i = setToINI("Address", "txtUtamo", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txtHur.Text)
    i = setToINI("Address", "txtHur", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txtHurMana.Text)
    i = setToINI("Address", "txtHurMana", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.scrollLight.Value)
    i = setToINI("Address", "scrollLight", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txtUtamoMana.Text)
    i = setToINI("Address", "txtUtamoMana", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txtSpeedOffset.Text)
    i = setToINI("Address", "txtSpeedOffset", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txtSpyOffset.Text)
    i = setToINI("Address", "txtSpyOffset", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txtStatusOffset.Text)
    i = setToINI("Address", "txtStatusOffset", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txtmyPosZOffset.Text)
    i = setToINI("Address", "txtmyPosZOffset", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txtmyPosXOffset.Text)
    i = setToINI("Address", "txtmyPosXOffset", strInfo, strPath)
    '
    strInfo = CStr(frmDebug.txtmyPosYOffset.Text)
    i = setToINI("Address", "txtmyPosYOffset", strInfo, strPath)
    
    
    
    'save enable eat
    If Menu.chkEat.Value = 1 Then
        strInfo = "1"
    Else
        strInfo = "0"
    End If
    i = setToINI("Extras", "AutoEat", strInfo, strPath)

    'save light ahck
    If Menu.chkLight.Value = 1 Then
        strInfo = "1"
    Else
        strInfo = "0"
    End If
    i = setToINI("Extras", "AutoLight", strInfo, strPath)
    
    'save enable idle
    If Menu.chkIdle.Value = 1 Then
        strInfo = "1"
    Else
        strInfo = "0"
    End If
    i = setToINI("Extras", "AntiIdle", strInfo, strPath)
    
    'save enable mana train
    If Menu.chkTrain.Value = 1 Then
        strInfo = "1"
    Else
        strInfo = "0"
    End If
    i = setToINI("Extras", "AutoTrain", strInfo, strPath)

    'save speed
    If Menu.chkSpeed.Value = 1 Then
        strInfo = "1"
    Else
        strInfo = "0"
    End If
    i = setToINI("Extras", "Speed", strInfo, strPath)

    'save utamo
    If Menu.chkUtamo.Value = 1 Then
        strInfo = "1"
    Else
        strInfo = "0"
    End If
    i = setToINI("Extras", "chkUtamo", strInfo, strPath)
    
    'save hur
    If Menu.chkHur.Value = 1 Then
        strInfo = "1"
    Else
        strInfo = "0"
    End If
    i = setToINI("Extras", "chkHur", strInfo, strPath)
    
    'save flash
    If Menu.chkFlash.Value = 1 Then
        strInfo = "1"
    Else
        strInfo = "0"
    End If
    i = setToINI("Extras", "AutoFlash", strInfo, strPath)
    
    'save strings
    strInfo = CStr(Menu.txtFlash.Text)
    i = setToINI("Extras", "txtFlash", strInfo, strPath)
    
    'save config timers
    strInfo = CStr(Menu.txtHealtmr.Text)
    i = setToINI("Extras", "hpdelay", strInfo, strPath)
    
    'mana train
    strInfo = CStr(Menu.txtTrainSpell.Text)
    i = setToINI("Extras", "SpellTrain1", strInfo, strPath)
    strInfo = CStr(Menu.txtManaTrain.Text)
    i = setToINI("Extras", "SpellTrain2", strInfo, strPath)
    
    'save cmb extra eat
    strInfo = CStr(Menu.cmbEat.Text)
    i = setToINI("Extras", "CmbEat", strInfo, strPath)
    
    
    strInfo = CStr(TibiaExePath)
    i = setToINI("Misc", "TibiaExePath", strInfo, strPath)
    
    SaveSettings = ""
    Exit Function
goterr:
    SaveSettings = "Got error code " & Err.Number & ": " & Err.Description
End Function

Public Function ShowSave(ByVal hwnd As Long, Optional ByVal centerForm As Boolean = True) As SelectedFile
Dim ret As Long
Dim hInst As Long
Dim Thread As Long
    
    ParenthWnd = hwnd
    FileDialog.nStructSize = Len(FileDialog)
    FileDialog.hwndOwner = hwnd
    FileDialog.sFileTitle = Space$(2048)
    FileDialog.nTitleSize = Len(FileDialog.sFileTitle)
    FileDialog.sFile = Space$(2047) & Chr$(0)
    FileDialog.nFileSize = Len(FileDialog.sFile)
    
    If FileDialog.FLAGS = 0 Then
        FileDialog.FLAGS = OFS_FILE_SAVE_FLAGS
    End If
    
    'Set up the CBT hook
    hInst = GetWindowLong(hwnd, GWL_HINSTANCE)
    Thread = GetCurrentThreadId()
    If centerForm = True Then
        hHook = SetWindowsHookEx(WH_CBT, AddressOf WinProcCenterForm, hInst, Thread)
    Else
        hHook = SetWindowsHookEx(WH_CBT, AddressOf WinProcCenterScreen, hInst, Thread)
    End If
    
    ret = GetSaveFileName(FileDialog)
    ReDim ShowSave.sFiles(1)

    If ret Then
        ShowSave.sLastDirectory = left$(FileDialog.sFile, FileDialog.nFileOffset)
        ShowSave.nFilesSelected = 1
        ShowSave.sFiles(1) = Mid(FileDialog.sFile, FileDialog.nFileOffset + 1, InStr(1, FileDialog.sFile, Chr$(0), vbTextCompare) - FileDialog.nFileOffset - 1)
        ShowSave.bCanceled = False
        Exit Function
    Else
        ShowSave.sLastDirectory = ""
        ShowSave.nFilesSelected = 0
        ShowSave.bCanceled = True
        Erase ShowSave.sFiles
        Exit Function
    End If
End Function

Public Function setToINI(ByRef par1 As String, ByRef par2 As String, _
 ByRef par3 As String, ByRef par4 As String)
    setToINI = WritePrivateProfileString(par1, par2, par3, par4)
End Function

Public Function ShowOpen(ByVal hwnd As Long, Optional ByVal centerForm As Boolean = True) As SelectedFile
Dim ret As Long
Dim count As Integer
Dim fileNameHolder As String
Dim LastCharacter As Integer
Dim NewCharacter As Integer
Dim tempFiles(1 To 200) As String
Dim hInst As Long
Dim Thread As Long
    
    ParenthWnd = hwnd
    FileDialog.nStructSize = Len(FileDialog)
    FileDialog.hwndOwner = hwnd
    FileDialog.sFileTitle = Space$(2048)
    FileDialog.nTitleSize = Len(FileDialog.sFileTitle)
    FileDialog.sFile = FileDialog.sFile & Space$(2047) & Chr$(0)
    FileDialog.nFileSize = Len(FileDialog.sFile)
    
    'If FileDialog.flags = 0 Then
        FileDialog.FLAGS = OFS_FILE_OPEN_FLAGS
    'End If
    
    'Set up the CBT hook
    hInst = GetWindowLong(hwnd, GWL_HINSTANCE)
    Thread = GetCurrentThreadId()
    If centerForm = True Then
        hHook = SetWindowsHookEx(WH_CBT, AddressOf WinProcCenterForm, hInst, Thread)
    Else
        hHook = SetWindowsHookEx(WH_CBT, AddressOf WinProcCenterScreen, hInst, Thread)
    End If
    
    ret = GetOpenFileName(FileDialog)

    If ret Then
        If Trim$(FileDialog.sFileTitle) = "" Then
            LastCharacter = 0
            count = 0
            While ShowOpen.nFilesSelected = 0
                NewCharacter = InStr(LastCharacter + 1, FileDialog.sFile, Chr$(0), vbTextCompare)
                If count > 0 Then
                    tempFiles(count) = Mid(FileDialog.sFile, LastCharacter + 1, NewCharacter - LastCharacter - 1)
                Else
                    ShowOpen.sLastDirectory = Mid(FileDialog.sFile, LastCharacter + 1, NewCharacter - LastCharacter - 1)
                End If
                count = count + 1
                If InStr(NewCharacter + 1, FileDialog.sFile, Chr$(0), vbTextCompare) = InStr(NewCharacter + 1, FileDialog.sFile, Chr$(0) & Chr$(0), vbTextCompare) Then
                    tempFiles(count) = Mid(FileDialog.sFile, NewCharacter + 1, InStr(NewCharacter + 1, FileDialog.sFile, Chr$(0) & Chr$(0), vbTextCompare) - NewCharacter - 1)
                    ShowOpen.nFilesSelected = count
                End If
                LastCharacter = NewCharacter
            Wend
            ReDim ShowOpen.sFiles(1 To ShowOpen.nFilesSelected)
            For count = 1 To ShowOpen.nFilesSelected
                ShowOpen.sFiles(count) = tempFiles(count)
            Next
        Else
            ReDim ShowOpen.sFiles(1 To 1)
            ShowOpen.sLastDirectory = left$(FileDialog.sFile, FileDialog.nFileOffset)
            ShowOpen.nFilesSelected = 1
            ShowOpen.sFiles(1) = Mid(FileDialog.sFile, FileDialog.nFileOffset + 1, InStr(1, FileDialog.sFile, Chr$(0), vbTextCompare) - FileDialog.nFileOffset - 1)
        End If
        ShowOpen.bCanceled = False
        Exit Function
    Else
        ShowOpen.sLastDirectory = ""
        ShowOpen.nFilesSelected = 0
        ShowOpen.bCanceled = True
        Erase ShowOpen.sFiles
        Exit Function
    End If
End Function

Public Function SpecFolder(ByVal lngFolder As Long) As String
Dim lngPidlFound As Long
Dim lngFolderFound As Long
Dim lngPidl As Long
Dim strPath As String

strPath = Space(MAX_PATH)
lngPidlFound = SHGetSpecialFolderLocation(0, lngFolder, lngPidl)
If lngPidlFound = NOERROR Then
    lngFolderFound = SHGetPathFromIDList(lngPidl, strPath)
    If lngFolderFound Then
        SpecFolder = left$(strPath, _
            InStr(1, strPath, vbNullChar) - 1)
    End If
End If
CoTaskMemFree lngPidl
End Function

Public Function GetProgFolder() As String
    GetProgFolder = SpecFolder(CSIDL_PROGRAM_FILES)
End Function

Public Function MyFileExists(FileName As String) As Boolean
    On Error GoTo ErrorHandler
    ' get the attributes and ensure that it isn't a directory
    MyFileExists = (GetAttr(FileName) And vbDirectory) = 0
ErrorHandler:
    ' if an error occurs, this function returns False
End Function

Public Function autoGetTibiaFolder() As String
    On Error GoTo goterr
    Dim tpath As String
    tpath = GetProgFolder()
    If Right$(tpath, 1) <> "\" Then
        tpath = tpath & "\"
    End If
    tpath = tpath & DefaultTibiaFolder & "\"
    If MyFileExists(tpath & "Tibia.exe") = True Then
        autoGetTibiaFolder = tpath
    Else
        autoGetTibiaFolder = ""
    End If
    Exit Function
goterr:
    autoGetTibiaFolder = ""
End Function

Public Function WinProcCenterForm(ByVal lMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
    Dim rectForm As RECT, rectMsg As RECT
    Dim x As Long, y As Long
    'On HCBT_ACTIVATE, show the MsgBox centered over Form1
    If lMsg = HCBT_ACTIVATE Then
        'Get the coordinates of the form and the message box so that
        'you can determine where the center of the form is located
        GetWindowRect ParenthWnd, rectForm
        GetWindowRect wParam, rectMsg
        x = (rectForm.left + (rectForm.Right - rectForm.left) / 2) - ((rectMsg.Right - rectMsg.left) / 2)
        y = (rectForm.top + (rectForm.Bottom - rectForm.top) / 2) - ((rectMsg.Bottom - rectMsg.top) / 2)
        'Position the msgbox
        SetWindowPos wParam, 0, x, y, 0, 0, SWP_NOSIZE Or SWP_NOZORDER Or SWP_NOACTIVATE
        'Release the CBT hook
        UnhookWindowsHookEx hHook
     End If
     WinProcCenterForm = False
End Function

Public Function WinProcCenterScreen(ByVal lMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
    Dim rectForm As RECT, rectMsg As RECT
    Dim x As Long, y As Long
    If lMsg = HCBT_ACTIVATE Then
        'Show the MsgBox at a fixed location (0,0)
        GetWindowRect wParam, rectMsg
        x = Screen.Width / Screen.TwipsPerPixelX / 2 - (rectMsg.Right - rectMsg.left) / 2
        y = Screen.Height / Screen.TwipsPerPixelY / 2 - (rectMsg.Bottom - rectMsg.top) / 2
        Debug.Print "Screen " & Screen.Height / 2
        Debug.Print "MsgBox " & (rectMsg.Right - rectMsg.left) / 2
        SetWindowPos wParam, 0, x, y, 0, 0, SWP_NOSIZE Or SWP_NOZORDER Or SWP_NOACTIVATE
        'Release the CBT hook
        UnhookWindowsHookEx hHook
    End If
    WinProcCenterScreen = False
End Function

Public Function getfromINI(ByRef par1 As String, ByRef par2 As String, _
 ByRef par3 As String, ByRef par4 As String, ByRef par5 As Long, ByRef par6 As String) As Long
    getfromINI = GetPrivateProfileString(par1, par2, par3, par4, par5, par6)
End Function
