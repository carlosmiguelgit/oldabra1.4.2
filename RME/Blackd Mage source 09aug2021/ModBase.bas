Attribute VB_Name = "ModBase"
Option Explicit

' credits to Ash Katchup (dat ash from tpforums)

Public Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long
Public Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hwnd As Long, lpdwProcessId As Long) As Long
'
Public Declare Function EnumProcessModules Lib "PSAPI.DLL" (ByVal hProcess As Long, lphModule As Long, ByVal cb As Long, lpcbNeeded As Long) As Long
Public Declare Function GetModuleInformation Lib "PSAPI" (ByVal hProcess As Long, ByVal hModule As Long, LPMODULEINFO As MODULEINFO, cb As Long) As Boolean
Public Declare Function GetModuleFileNameEx Lib "PSAPI" Alias "GetModuleFileNameExA" (ByVal hProcess As Long, ByVal hModule As Long, ByVal lpFilename As String, nSize As Long) As Boolean
Public Declare Function GetModuleBaseName Lib "PSAPI.DLL" Alias "GetModuleBaseNameA" (ByVal hProcess As Long, ByVal hModule As Long, ByVal lpFilename As String, ByVal nSize As Long) As Long
'Public Declare Sub CloseHandle Lib "kernel32" (ByVal hPass As Long)
Public Declare Function GetCurrentProcessId Lib "kernel32" () As Long

Public Declare Function GetCurrentProcess Lib "kernel32.dll" () As Long
Public Declare Function OpenProcessToken Lib "advapi32.dll" (ByVal processHandle As Long, ByVal DesiredAccess As Long, TokenHandle As Long) As Long
Public Declare Function LookupPrivilegeValue Lib "advapi32.dll" Alias "LookupPrivilegeValueA" (ByVal lpSystemName As String, ByVal lpName As String, lpLuid As LUID) As Long
Public Declare Function AdjustTokenPrivileges Lib "advapi32.dll" (ByVal TokenHandle As Long, ByVal DisableAllPrivileges As Long, NewState As TOKEN_PRIVILEGES, ByVal BufferLength As Long, PreviousState As TOKEN_PRIVILEGES, ReturnLength As Long) As Long
Public Declare Function GetLastError Lib "kernel32.dll" () As Long
Public Declare Function FormatMessage Lib "kernel32.dll" Alias "FormatMessageA" (ByVal dwFlags As Long, lpSource As Any, ByVal dwMessageId As Long, ByVal dwLanguageId As Long, ByVal lpBuffer As String, ByVal nSize As Long, Arguments As Long) As Long
'
Public Const PROCESS_VM_READ = (&H10)
Public Const PROCESS_VM_WRITE = (&H20)
Public Const PROCESS_VM_OPERATION = (&H8)
Public Const PROCESS_QUERY_INFORMATION = (&H400)
Public Const PROCESS_QUERY_LIMITED_INFORMATION = (&H1000)
Public Const PROCESS_READ_WRITE_QUERY = PROCESS_VM_READ + PROCESS_VM_WRITE + PROCESS_VM_OPERATION + PROCESS_QUERY_INFORMATION
'
Public Type MODULEINFO
   lpBaseOfDll                   As Long
   SizeOfImage                   As Long
   EntryPoint                    As Long
End Type

'
Public Type LUID
    LowPart As Long
    HighPart As Long
End Type
'
Public Type LUID_AND_ATTRIBUTES
    pLuid As LUID
    Attributes As Long
End Type
'
Public Type TOKEN_PRIVILEGES
    PrivilegeCount As Long
    Privileges(0 To 0) As LUID_AND_ATTRIBUTES
End Type

Public Function ProcessInfo(lProcessID As Long, ByRef asModuleInfo() As String, Optional sFilter As String = "") As Long
    Const MAX_PATH As Integer = 260
    Const PROCESS_QUERY_INFORMATION = &H400&
    Const PROCESS_VM_READ = &H10&
    Const OPEN_PROCESS_FLAGS = PROCESS_QUERY_INFORMATION& Or PROCESS_VM_READ&
     
    Dim bFilterModule As Boolean
    Dim lCountMatching As Long
    Dim bRetVal As Boolean
    Dim lNeeded As Long
    Dim lNumItems As Long
    Dim lThisModule As Long
    Dim sModuleName As String
    Dim sModuleFileName As String
    Dim lNumCols As Long
    Dim lNumRows As Long
    Dim lProcessHwnd As Long
    Dim lPos As Long
    Dim lLenFileName As Long
    Dim alModules() As Long
    Dim tModuleInfo As MODULEINFO
    Dim lBaseOfDLL As Long
    Dim lSizeOfImage As Long
    Dim lEntryPoint As Long
    
    On Error GoTo ErrFailed
     
    'Open the process
    lProcessHwnd = OpenProcess(OPEN_PROCESS_FLAGS, 0&, lProcessID)
    If lProcessHwnd = 0 Then
        'Failed to open process
        Exit Function
    End If
    
    
    'Enum modules
    lNumItems = 1024
    ReDim alModules(0 To lNumItems)
    
    If EnumProcessModules(lProcessHwnd, alModules(0), (1024 * 4), lNeeded) = False Then
        ' Exit cleanly if this fails
        Exit Function
    End If
    
    
    'Calc number of modules returned
    lNumItems = lNeeded / 4
    lNumRows = lNumItems
    lNumCols = 6
    
    
    ReDim asModuleInfo(1 To 6, 1 To 1)
     
    'Add array titles
    asModuleInfo(1, 1) = "Module ID"
    asModuleInfo(2, 1) = "Module Name"
    asModuleInfo(3, 1) = "Base Addr"
    asModuleInfo(4, 1) = "Module Path"
    asModuleInfo(5, 1) = "Size Of Image"
    asModuleInfo(6, 1) = "Entry Point"
 
    'Loop over modules
    For lThisModule = 0 To lNumItems - 1
        If alModules(lThisModule) <> 0 Then
            sModuleFileName = ""
            sModuleName = ""
            'Get module information
            bRetVal = GetModuleInformation(lProcessHwnd, alModules(lThisModule), tModuleInfo, lNeeded)
            lBaseOfDLL = tModuleInfo.lpBaseOfDll
            lSizeOfImage = tModuleInfo.SizeOfImage
            lEntryPoint = tModuleInfo.EntryPoint
              
          
            If bRetVal = False Then
                sModuleFileName = "Unknown"
                sModuleName = "Unknown"
            Else
                'Get Module File Name
                lLenFileName = MAX_PATH
                sModuleFileName = String$(lLenFileName, Chr$(0))
                bRetVal = GetModuleFileNameEx(lProcessHwnd, alModules(lThisModule), sModuleFileName, lLenFileName)
                lPos = InStr(sModuleFileName, Chr$(0))
                If lPos > 0 Then
                    sModuleFileName = Mid$(sModuleFileName, 1, lPos - 1)
                End If
                'Get Module Name
                lLenFileName = MAX_PATH
                sModuleName = Space$(lLenFileName)
                bRetVal = GetModuleBaseName(lProcessHwnd, alModules(lThisModule), sModuleName, lLenFileName)
                lPos = InStr(sModuleName, Chr$(0))
                If lPos > 0 Then
                    sModuleName = Mid$(sModuleName, 1, lPos - 1)
                End If
            End If
             
            bFilterModule = False
            If Len(sFilter) Then
                'Check filter
                If (UCase$(sModuleFileName) Like UCase$("*" & sFilter)) = False Then
                    bFilterModule = True
                Else
                    bFilterModule = False
                End If
            End If
 
            If bFilterModule = False Then
                lCountMatching = lCountMatching + 1
                ReDim Preserve asModuleInfo(1 To 6, 1 To lCountMatching + 1)
                asModuleInfo(1, lCountMatching + 1) = alModules(lThisModule)
                asModuleInfo(2, lCountMatching + 1) = sModuleName
                asModuleInfo(3, lCountMatching + 1) = lBaseOfDLL
                asModuleInfo(4, lCountMatching + 1) = sModuleFileName
                asModuleInfo(5, lCountMatching + 1) = lSizeOfImage
                asModuleInfo(6, lCountMatching + 1) = lEntryPoint
            End If
        Else
            'No module ID
        End If
    Next
    
    Erase alModules
    Call CloseHandle(lProcessHwnd)
    ProcessInfo = lCountMatching
    
    Exit Function
    
ErrFailed:
    Debug.Print "Error in ProcessInfo: " & Err.Description
    Debug.Assert False
    Call CloseHandle(lProcessHwnd)
    ProcessInfo = -1
    Erase asModuleInfo
End Function
 

Public Function GetBaseAddress(processHandle As Long, moduleName As String) As Long
    Dim lThisMod As Long, lNumMods As Long, asProcInfo() As String
    Dim sThisMod As String, lThisItem As Long
    Dim address As Long
    '
    lNumMods = ProcessInfo(processHandle, asProcInfo)
    '
    For lThisMod = 1 To lNumMods
        '
        sThisMod = ""
        For lThisItem = 1 To UBound(asProcInfo)
            sThisMod = asProcInfo(lThisItem, lThisMod)
            '
            If LCase(sThisMod) = LCase(moduleName) Then
                address = asProcInfo(3, lThisMod) '3 = Base Address
                GoTo final
            End If
            '
        Next
        '
    Next
    '
final:
    GetBaseAddress = address
    '
End Function

Public Function DebugPrivilege() As Boolean
    Const TOKEN_ADJUST_PRIVILEGES As Long = &H20
    Const TOKEN_QUERY As Long = &H8
    Const SE_PRIVILEGE_ENABLED As Long = &H2
    Const SE_DEBUG_NAME As String = "SeDebugPrivilege"
    Const FORMAT_MESSAGE_FROM_SYSTEM As Long = &H1000
    Const FORMAT_MESSAGE_IGNORE_INSERTS As Long = &H200
    Const User_Default_Language As Long = &H400
    '
    Dim ErrorNumber As Long
    Dim ErrorMessage As String
    Dim hToken As Long
    Dim tkp As TOKEN_PRIVILEGES
    Dim tkpNULL As TOKEN_PRIVILEGES
    '
    If OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES Or TOKEN_QUERY, hToken) = 0 Then
        DebugPrivilege = False
        Exit Function
    End If
    '
    LookupPrivilegeValue vbNullString, SE_DEBUG_NAME, tkp.Privileges(0).pLuid
    tkp.PrivilegeCount = 1
    tkp.Privileges(0).Attributes = SE_PRIVILEGE_ENABLED
    AdjustTokenPrivileges hToken, False, tkp, Len(tkp), tkpNULL, Len(tkpNULL)
    ErrorNumber = GetLastError
    '
    If ErrorNumber <> 0 Then
        ErrorMessage = Space$(500)
        FormatMessage FORMAT_MESSAGE_FROM_SYSTEM Or FORMAT_MESSAGE_IGNORE_INSERTS, 0, ErrorNumber, User_Default_Language, ErrorMessage, Len(ErrorMessage), 0
        MsgBox Trim(ErrorMessage), vbExclamation, "DebugPrivilege"
        DebugPrivilege = False
        Exit Function
    End If
    '
    DebugPrivilege = True
    '
End Function


Public Function GetProcessID(handle As Long) As Long
    Dim process As Long
    '
    GetWindowThreadProcessId handle, process
    '
    GetProcessID = process
    '
End Function

Public Function ReadPointerLong(lProcessHandle As Long, lBaseAddres As Long, lAddress As Long, lOffSet As Long) As Long
    Dim lRealAddres         As Long
    Dim buffer()            As Byte
    Dim pointer             As Long
    Dim ret                 As Long
    '
    lRealAddres = lBaseAddres + lAddress
    '
    ReadProcessMemory lProcessHandle, lRealAddres, pointer, 4, 0
    '
    pointer = pointer + lOffSet
    '
    ReadProcessMemory lProcessHandle, pointer, ret, 4, 0
    '
    ReadPointerLong = ret
End Function

Public Function ReadPointerDouble(lProcessHandle As Long, lBaseAddres As Long, lAddress As Long, lOffSet As Long) As Double
    Dim lRealAddres         As Long
    Dim buffer()            As Byte
    Dim pointer             As Long
    Dim ret                 As Double
    '
    lRealAddres = lBaseAddres + lAddress
    '
    ReadProcessMemory lProcessHandle, lRealAddres, pointer, 8, 0
    '
    pointer = pointer + lOffSet
    '
    ReadProcessMemory lProcessHandle, pointer, ret, 8, 0
    '
    ReadPointerDouble = ret
End Function

Public Function ReadPointerByte(lProcessHandle As Long, lBaseAddres As Long, lAddress As Long, lOffSet As Long) As Byte
    Dim lRealAddres         As Long
    Dim buffer()            As Byte
    Dim pointer             As Long
    Dim ret                 As Byte
    '
    lRealAddres = lBaseAddres + lAddress
    '
    ReadProcessMemory lProcessHandle, lRealAddres, pointer, 4, 0
    '
    pointer = pointer + lOffSet
    '
    ReadProcessMemory lProcessHandle, pointer, ret, 4, 0
    '
    ReadPointerByte = ret
End Function
