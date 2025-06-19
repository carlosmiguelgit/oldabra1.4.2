Attribute VB_Name = "ModLight"
Option Explicit
Public Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hwnd As Long, lpdwProcessId As Long) As Long
Public Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long
Public Declare Function WriteProcessMemory Lib "kernel32" (ByVal hProcess As Long, ByVal lpBaseAddress As Any, lpBuffer As Any, ByVal nSize As Long, lpNumberOfBytesWritten As Long) As Long
Public Declare Function ReadProcessMemory Lib "kernel32" (ByVal hProcess As Long, ByVal lpBaseAddress As Any, ByRef lpBuffer As Any, ByVal nSize As Long, lpNumberOfBytesWritten As Long) As Long
Public Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long

Public Function Memory_ReadByte(address As Long, process_Hwnd As Long) As Byte
  
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
   Memory_ReadByte = valbuffer
   
   ' Close the Process Handle
   CloseHandle phandle
  
End Function
Public Function Memory_ReadLongLight(address As Long, process_Hwnd As Long) As Long
  
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
   Memory_ReadLongLight = valbuffer
   
   ' Close the Process Handle
   CloseHandle phandle
  
End Function
Public Sub Memory_WriteByte(address As Long, valbuffer As Byte, process_Hwnd As Long)

   'Declare some variables we need
   Dim pid As Long         ' Used to hold the Process Id
   Dim phandle As Long     ' Holds the Process Handle
   
   ' First get a handle to the "game" window
   If (process_Hwnd = 0) Then Exit Sub
   
   ' We can now get the pid
   GetWindowThreadProcessId process_Hwnd, pid
   
   ' Use the pid to get a Process Handle
   phandle = OpenProcess(PROCESS_READ_WRITE_QUERY, False, pid)
   If (phandle = 0) Then Exit Sub
   
   ' Write Long
   WriteProcessMemory phandle, address, valbuffer, 1, 0&
   
   ' Close the Process Handle
   CloseHandle phandle

End Sub
Public Sub Memory_WriteLong(address As Long, valbuffer As Long, process_Hwnd As Long)

   'Declare some variables we need
   Dim pid As Long         ' Used to hold the Process Id
   Dim phandle As Long     ' Holds the Process Handle
   
   ' First get a handle to the "game" window
   If (process_Hwnd = 0) Then Exit Sub
   
   ' We can now get the pid
   GetWindowThreadProcessId process_Hwnd, pid
   
   ' Use the pid to get a Process Handle
   phandle = OpenProcess(PROCESS_READ_WRITE_QUERY, False, pid)
   If (phandle = 0) Then Exit Sub
   
   ' Write Long
   WriteProcessMemory phandle, address, valbuffer, 4, 0&
   
   ' Close the Process Handle
   CloseHandle phandle

End Sub

Public Sub UpdateLightOTClient()
 Dim tibiaclient As Long
 Dim lWindowsHandle As Long
 Dim lProcessID As Long
 Dim lProcessBase As Long
 Dim lProcessHandle As Long
 Dim iRealAddress As Long
 Dim pointer As Long
 Dim retorno As Long
 
    tibiaclient = TibiaWindow
    lWindowsHandle = tibiaclient
    lProcessID = GetProcessID(lWindowsHandle)
    DebugPrivilege
    lProcessHandle = OpenProcess(PROCESS_READ_WRITE_QUERY, 0, lProcessID)
    lProcessBase = GetBaseAddress(lProcessID, adrBaseAddress)
    
    iRealAddress = lProcessBase + mainAddress
    ReadProcessMemory lProcessHandle, iRealAddress, pointer, 4, 0
    pointer = pointer + lightOffset
    WriteProcessMemory lProcessHandle, pointer, frmDebug.scrollLight.Value, 1, 0

End Sub

Public Function HighByteOfLong(address As Long) As Byte
  Dim h As Byte
  h = CByte(address \ 256) ' high byte
  HighByteOfLong = h
End Function

Public Function LowByteOfLong(address As Long) As Byte
  Dim h As Byte
  Dim l As Byte
  h = CByte(address \ 256)
  l = CByte(address - (CLng(h) * 256)) ' low byte
  LowByteOfLong = l
End Function

Public Sub UpdateSpeed()
 Dim tibiaclient As Long
 Dim lWindowsHandle As Long
 Dim lProcessID As Long
 Dim lProcessBase As Long
 Dim lProcessHandle As Long
 Dim iRealAddress As Long
 Dim pointer As Long
 Dim textSpeed As Long
 
    tibiaclient = TibiaWindow
    lWindowsHandle = tibiaclient
    lProcessID = GetProcessID(lWindowsHandle)
    DebugPrivilege
    lProcessHandle = OpenProcess(PROCESS_READ_WRITE_QUERY, 0, lProcessID)
    lProcessBase = GetBaseAddress(lProcessID, adrBaseAddress)
    
    iRealAddress = lProcessBase + mainAddress
    ReadProcessMemory lProcessHandle, iRealAddress, pointer, 4, 0
    pointer = pointer + speedOffset
    
    textSpeed = CLng(MySpeedBase + 500)
    WriteProcessMemory lProcessHandle, pointer, textSpeed, 4, 0

End Sub

Public Sub UpdateSpy()
 Dim tibiaclient As Long
 Dim lWindowsHandle As Long
 Dim lProcessID As Long
 Dim lProcessBase As Long
 Dim lProcessHandle As Long
 Dim iRealAddress As Long
 Dim pointer As Long
 
    tibiaclient = TibiaWindow
    lWindowsHandle = tibiaclient
    lProcessID = GetProcessID(lWindowsHandle)
    DebugPrivilege
    lProcessHandle = OpenProcess(PROCESS_READ_WRITE_QUERY, 0, lProcessID)
    lProcessBase = GetBaseAddress(lProcessID, adrBaseAddress)
    
    iRealAddress = lProcessBase + mainAddress
    ReadProcessMemory lProcessHandle, iRealAddress, pointer, 4, 0
    pointer = pointer + spyOffset
    WriteProcessMemory lProcessHandle, pointer, MyZ, 4, 0

End Sub

Public Sub UpdateSpyUP()
 Dim tibiaclient As Long
 Dim lWindowsHandle As Long
 Dim lProcessID As Long
 Dim lProcessBase As Long
 Dim lProcessHandle As Long
 Dim iRealAddress As Long
 Dim pointer As Long
 Dim i As Long
 
    tibiaclient = TibiaWindow
    lWindowsHandle = tibiaclient
    lProcessID = GetProcessID(lWindowsHandle)
    DebugPrivilege
    lProcessHandle = OpenProcess(PROCESS_READ_WRITE_QUERY, 0, lProcessID)
    lProcessBase = GetBaseAddress(lProcessID, adrBaseAddress)
    
    iRealAddress = lProcessBase + mainAddress
    ReadProcessMemory lProcessHandle, iRealAddress, pointer, 4, 0
    pointer = pointer + spyOffset
    WriteProcessMemory lProcessHandle, pointer, (MyZ - 1), 4, 0

End Sub

Public Sub UpdateSpyDOWN()
 Dim tibiaclient As Long
 Dim lWindowsHandle As Long
 Dim lProcessID As Long
 Dim lProcessBase As Long
 Dim lProcessHandle As Long
 Dim iRealAddress As Long
 Dim pointer As Long
 Dim i As Long
 
    tibiaclient = TibiaWindow
    lWindowsHandle = tibiaclient
    lProcessID = GetProcessID(lWindowsHandle)
    DebugPrivilege
    lProcessHandle = OpenProcess(PROCESS_READ_WRITE_QUERY, 0, lProcessID)
    lProcessBase = GetBaseAddress(lProcessID, adrBaseAddress)
    
    iRealAddress = lProcessBase + mainAddress
    ReadProcessMemory lProcessHandle, iRealAddress, pointer, 4, 0
    pointer = pointer + spyOffset
    WriteProcessMemory lProcessHandle, pointer, (MyZ + 1), 4, 0

End Sub
