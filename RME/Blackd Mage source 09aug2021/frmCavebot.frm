VERSION 5.00
Begin VB.Form frmCavebot 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Cave Bot"
   ClientHeight    =   4320
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   6825
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4320
   ScaleWidth      =   6825
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdClearT 
      Caption         =   "Clear"
      Height          =   255
      Left            =   2160
      Style           =   1  'Graphical
      TabIndex        =   27
      ToolTipText     =   "Deletes current selected item in the list box"
      Top             =   1800
      Width           =   615
   End
   Begin VB.CommandButton cmdReloadW 
      Caption         =   "refresh"
      Height          =   255
      Left            =   5640
      Style           =   1  'Graphical
      TabIndex        =   26
      Top             =   3120
      Width           =   735
   End
   Begin VB.ComboBox txtFileW 
      Height          =   315
      Left            =   3720
      TabIndex        =   25
      Text            =   "waypoints.txt"
      Top             =   3120
      Width           =   1815
   End
   Begin VB.CommandButton cmdReloadT 
      Caption         =   "refresh"
      Height          =   255
      Left            =   2160
      Style           =   1  'Graphical
      TabIndex        =   24
      Top             =   3120
      Width           =   735
   End
   Begin VB.ComboBox txtFileT 
      Height          =   315
      Left            =   240
      TabIndex        =   23
      Text            =   "targeting.txt"
      Top             =   3120
      Width           =   1815
   End
   Begin VB.CommandButton cmdClearW 
      Caption         =   "Clear"
      Height          =   255
      Left            =   5880
      Style           =   1  'Graphical
      TabIndex        =   22
      ToolTipText     =   "Deletes current selected item in the list box"
      Top             =   1800
      Width           =   615
   End
   Begin VB.CommandButton cmdAddSetKill 
      Caption         =   "Add"
      Height          =   255
      Left            =   2760
      Style           =   1  'Graphical
      TabIndex        =   21
      ToolTipText     =   "Deletes current selected item in the list box"
      Top             =   840
      Width           =   615
   End
   Begin VB.CheckBox chkWaypointsEnable 
      Caption         =   "Run Waypoints"
      Height          =   195
      Left            =   3720
      TabIndex        =   20
      Top             =   3840
      Value           =   2  'Grayed
      Width           =   1395
   End
   Begin VB.CheckBox chkTargetingEnable 
      Caption         =   "Run Targeting"
      Height          =   195
      Left            =   240
      TabIndex        =   19
      Top             =   3840
      Value           =   2  'Grayed
      Width           =   1395
   End
   Begin VB.TextBox txtSetKill 
      Height          =   285
      Left            =   2160
      TabIndex        =   17
      Top             =   480
      Width           =   1215
   End
   Begin VB.CommandButton cmdWalk 
      Caption         =   "WALK"
      Height          =   375
      Left            =   5880
      TabIndex        =   16
      Top             =   240
      Width           =   735
   End
   Begin VB.TextBox txtEditW 
      Height          =   375
      Left            =   3720
      TabIndex        =   13
      Top             =   2400
      Width           =   2055
   End
   Begin VB.CommandButton cmdDeleteSelectedW 
      Caption         =   "del"
      Height          =   255
      Left            =   5880
      Style           =   1  'Graphical
      TabIndex        =   12
      ToolTipText     =   "Deletes current selected item in the list box"
      Top             =   2400
      Width           =   615
   End
   Begin VB.CommandButton cmdLoadScriptW 
      Caption         =   "Load"
      Height          =   255
      Left            =   4680
      Style           =   1  'Graphical
      TabIndex        =   11
      ToolTipText     =   "Loads from given file"
      Top             =   3480
      Width           =   855
   End
   Begin VB.CommandButton cmdSaveScriptW 
      Caption         =   "Save"
      Height          =   255
      Left            =   3720
      Style           =   1  'Graphical
      TabIndex        =   10
      ToolTipText     =   "Saves to given file"
      Top             =   3480
      Width           =   855
   End
   Begin VB.TextBox txtEditT 
      Height          =   375
      Left            =   240
      TabIndex        =   7
      Top             =   2400
      Width           =   1815
   End
   Begin VB.CommandButton cmdDeleteSelectedT 
      Caption         =   "del"
      Height          =   255
      Left            =   2160
      Style           =   1  'Graphical
      TabIndex        =   6
      ToolTipText     =   "Deletes current selected item in the list box"
      Top             =   2400
      Width           =   615
   End
   Begin VB.CommandButton cmdLoadScriptT 
      Caption         =   "Load"
      Height          =   255
      Left            =   1200
      Style           =   1  'Graphical
      TabIndex        =   5
      ToolTipText     =   "Loads from given file"
      Top             =   3480
      Width           =   855
   End
   Begin VB.CommandButton cmdSaveScriptT 
      Caption         =   "Save"
      Height          =   255
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   4
      ToolTipText     =   "Saves to given file"
      Top             =   3480
      Width           =   855
   End
   Begin VB.ListBox list_waypoints 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   1815
      ItemData        =   "frmCavebot.frx":0000
      Left            =   3720
      List            =   "frmCavebot.frx":0002
      TabIndex        =   3
      Top             =   240
      Width           =   2055
   End
   Begin VB.ListBox list_targeting 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   1815
      ItemData        =   "frmCavebot.frx":0004
      Left            =   240
      List            =   "frmCavebot.frx":0006
      TabIndex        =   2
      Top             =   240
      Width           =   1815
   End
   Begin VB.Line Line 
      BorderColor     =   &H00808080&
      Index           =   7
      X1              =   3600
      X2              =   6720
      Y1              =   4200
      Y2              =   4200
   End
   Begin VB.Line Line 
      BorderColor     =   &H00808080&
      Index           =   6
      X1              =   120
      X2              =   3480
      Y1              =   4200
      Y2              =   4200
   End
   Begin VB.Label Label1 
      Caption         =   "Creature Name:"
      Height          =   255
      Left            =   2160
      TabIndex        =   18
      Top             =   240
      Width           =   1215
   End
   Begin VB.Line Line 
      BorderColor     =   &H00808080&
      Index           =   4
      X1              =   6720
      X2              =   6720
      Y1              =   120
      Y2              =   4200
   End
   Begin VB.Line Line 
      BorderColor     =   &H00808080&
      Index           =   3
      X1              =   3480
      X2              =   3480
      Y1              =   120
      Y2              =   4200
   End
   Begin VB.Label Label3 
      Caption         =   "Save and Load waypoints"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   3720
      TabIndex        =   15
      Top             =   2880
      Width           =   1935
   End
   Begin VB.Label Label2 
      Caption         =   "Edit line:"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   3720
      TabIndex        =   14
      Top             =   2160
      Width           =   735
   End
   Begin VB.Label lblFile 
      Caption         =   "Save and Load targeting"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   240
      TabIndex        =   9
      Top             =   2880
      Width           =   1815
   End
   Begin VB.Label lblEdit 
      Caption         =   "Edit line:"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   240
      TabIndex        =   8
      Top             =   2160
      Width           =   735
   End
   Begin VB.Label lbl11 
      Caption         =   "Waypoints"
      ForeColor       =   &H8000000D&
      Height          =   195
      Index           =   1
      Left            =   3780
      TabIndex        =   1
      Top             =   0
      Width           =   795
   End
   Begin VB.Line Line 
      BorderColor     =   &H00808080&
      Index           =   2
      X1              =   3600
      X2              =   3720
      Y1              =   120
      Y2              =   120
   End
   Begin VB.Line Line 
      BorderColor     =   &H00808080&
      Index           =   1
      X1              =   4560
      X2              =   6720
      Y1              =   120
      Y2              =   120
   End
   Begin VB.Line Line 
      BorderColor     =   &H00808080&
      Index           =   0
      X1              =   3600
      X2              =   3600
      Y1              =   120
      Y2              =   4200
   End
   Begin VB.Label lbl11 
      Caption         =   "Targeting"
      ForeColor       =   &H8000000D&
      Height          =   195
      Index           =   0
      Left            =   300
      TabIndex        =   0
      Top             =   0
      Width           =   675
   End
   Begin VB.Line Line 
      BorderColor     =   &H00808080&
      Index           =   5
      X1              =   120
      X2              =   240
      Y1              =   120
      Y2              =   120
   End
   Begin VB.Line Line 
      BorderColor     =   &H00808080&
      Index           =   9
      X1              =   1080
      X2              =   3480
      Y1              =   120
      Y2              =   120
   End
   Begin VB.Line Line 
      BorderColor     =   &H00808080&
      Index           =   10
      X1              =   120
      X2              =   120
      Y1              =   120
      Y2              =   4200
   End
End
Attribute VB_Name = "frmCavebot"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdAddSetKill_Click()

If txtSetKill.Text <> "" Then
list_targeting.AddItem txtSetKill.Text
End If

End Sub

Private Sub cmdClearT_Click()

    'If MsgBox("Clear Targeting list?", vbYesNo + vbQuestion, "Targeting List") = vbYes Then
        list_targeting.Clear
    'End If

End Sub

Private Sub cmdClearW_Click()

'If chkWaypointsEnable.Value = 0 Then
'list_waypoints.Clear
'End If

    'If MsgBox("Clear Waypoints list?", vbYesNo + vbQuestion, "Waypoints List") = vbYes Then
        list_waypoints.Clear
    'End If

End Sub

Private Sub cmdDeleteSelectedT_Click()
Dim intcount As Variant

'If chkTargetingEnable.Value = 0 Then

For intcount = list_targeting.ListCount - 1 To 0 Step -1
    If list_targeting.Selected(intcount) Then list_targeting.RemoveItem (intcount)
Next intcount

txtEditT.Text = ""
'End If

End Sub

Private Sub cmdDeleteSelectedW_Click()
Dim intcount As Variant

'If chkTargetingEnable.Value = 0 Then

For intcount = list_waypoints.ListCount - 1 To 0 Step -1
    If list_waypoints.Selected(intcount) Then list_waypoints.RemoveItem (intcount)
Next intcount

txtEditW.Text = ""
'End If

End Sub

Private Sub cmdLoadScriptT_Click()
    On Error GoTo goterr
    
    Dim strRes As String
    Dim strRes2 As String
    Dim sOpen As SelectedFile
    Dim count As Integer
    Dim FileList As String
    
    FileDialog.sFilter = "Ini (*.txt)" & Chr$(0) & "*.txt"
    
    ' See Standard CommonDialog Flags for all options
    FileDialog.FLAGS = OFN_EXPLORER Or OFN_LONGNAMES Or OFN_HIDEREADONLY
    'FileDialog.sDlgTitle = "Show Open"
    FileDialog.sInitDir = App.Path & "\Save\"
    sOpen = ShowOpen(Me.hwnd)
    If Err.Number <> 32755 And sOpen.bCanceled = False Then
        strRes = sOpen.sLastDirectory & sOpen.sFiles(1)
        'strRes2 = LoadSettingsMacro(strRes)
        If strRes2 = "" Then
            'UpdateFormsFromVars
            'MsgBox BString(30) & strRes, vbOKOnly + vbInformation, BString(29)
        Else
            MsgBox strRes2, vbOKOnly + vbCritical, "Error loading " & strRes
        End If
    End If
    Exit Sub
            
goterr:
    If Err.Number <> 32755 Then
        MsgBox "Unexpected error " & Err.Number & ": " & Err.Description, vbOKOnly + vbCritical, "LoadSettingsFromFile"
    End If
    
End Sub

Private Sub cmdLoadScriptW_Click()
Dim strPath As String

'If MsgBox("LOAD Waypoints list?", vbYesNo + vbQuestion, "Load Waypoints") = vbYes Then
    'list_waypoints.Clear
    'LoadSettingsFromFileW
    'strPath = App.Path & "\Save\"
    'If Right$(strPath, 1) <> "\" Then
    '    strPath = strPath & "\"
    'End If
'End If
    
End Sub

Private Sub cmdReloadT_Click()
  Dim fs As Scripting.FileSystemObject
  Dim f As Scripting.Folder
  Dim f1 As Scripting.File
  
  Set fs = New Scripting.FileSystemObject
  Set f = fs.GetFolder(App.Path & "\Save")
  txtFileT.Clear
  For Each f1 In f.Files
    If LCase(Right(f1.Name, 3)) = "txt" Then
      If f1.Name <> "code.txt" Then
        txtFileT.AddItem f1.Name
      End If
    End If
  Next
  txtFileT.Text = "targeting.txt"
  Exit Sub

End Sub

Private Sub cmdReloadW_Click()
  Dim fs As Scripting.FileSystemObject
  Dim f As Scripting.Folder
  Dim f1 As Scripting.File
  
  Set fs = New Scripting.FileSystemObject
  Set f = fs.GetFolder(App.Path & "\Save")
  txtFileW.Clear
  For Each f1 In f.Files
    If LCase(Right(f1.Name, 3)) = "txt" Then
      If f1.Name <> "code.txt" Then
        txtFileW.AddItem f1.Name
      End If
    End If
  Next
  txtFileW.Text = "waypoints.txt"
  Exit Sub
  
End Sub

Private Sub cmdSaveScriptT_Click()
  Dim fn As Integer
  Dim strInfo As String
  Dim lindex As Long

'If MsgBox("SAVE Targeting list?", vbYesNo + vbQuestion, "Save Targeting") = vbYes Then
    If txtFileT.Text <> "" Then
        fn = FreeFile
        Open App.Path & "\Save\" & txtFileT.Text For Output As #fn
            For lindex = 0 To list_targeting.ListCount - 1
            Print #fn, list_targeting.List(lindex)
            Next lindex
        Close #fn
    End If
  Exit Sub
'End If

End Sub

Private Sub cmdSaveScriptW_Click()
  Dim fn As Integer
  Dim strInfo As String
  Dim lindex As Long
    
'If MsgBox("SAVE Waypoints list?", vbYesNo + vbQuestion, "Save Waypoints") = vbYes Then
    If txtFileW.Text <> "" Then
        fn = FreeFile
        Open App.Path & "\Save\" & txtFileW.Text For Output As #fn
            For lindex = 0 To list_waypoints.ListCount - 1
            Print #fn, list_waypoints.List(lindex)
            Next lindex
        Close #fn
    End If
  Exit Sub
'End If
  
End Sub

Private Sub cmdWalk_Click()

list_waypoints.AddItem "WALK(" & MyX & "," & MyY & "," & MyZ & ")"

End Sub

Private Sub Form_Unload(Cancel As Integer)
    If MustUnload = False Then
        Cancel = True
        Me.Hide
    End If
End Sub

Private Sub list_targeting_Click()

  If list_targeting.ListIndex >= 0 Then
    txtEditT.Text = list_targeting.List(list_targeting.ListIndex)
  End If

End Sub

Private Sub list_waypoints_Click()

  If list_waypoints.ListIndex >= 0 Then
    txtEditW.Text = list_waypoints.List(list_waypoints.ListIndex)
  End If

End Sub

Private Sub txtEditT_Change()
'targeting
  If list_targeting.ListIndex >= 0 Then
    list_targeting.List(list_targeting.ListIndex) = txtEditT.Text
  End If
  
End Sub

Private Sub txtEditW_Change()
'waypoints
  If list_waypoints.ListIndex >= 0 Then
    list_waypoints.List(list_waypoints.ListIndex) = txtEditW.Text
  End If
  
End Sub
