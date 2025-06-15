VERSION 5.00
Begin VB.Form frmDebug 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Settings"
   ClientHeight    =   5715
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   6780
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5715
   ScaleWidth      =   6780
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.HScrollBar scrollLight 
      Height          =   255
      Left            =   4800
      Max             =   15
      TabIndex        =   63
      Top             =   3480
      Value           =   15
      Width           =   1695
   End
   Begin VB.TextBox txtHurMana 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   5880
      TabIndex        =   61
      Text            =   "60"
      Top             =   3120
      Width           =   615
   End
   Begin VB.TextBox txtHur 
      Alignment       =   2  'Center
      Height          =   255
      Left            =   4800
      TabIndex        =   60
      Text            =   "utani hur"
      Top             =   3120
      Width           =   975
   End
   Begin VB.TextBox txtUtamoMana 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   5880
      TabIndex        =   58
      Text            =   "50"
      Top             =   2760
      Width           =   615
   End
   Begin VB.TextBox txtUtamo 
      Alignment       =   2  'Center
      Height          =   255
      Left            =   4800
      TabIndex        =   57
      Text            =   "utamo vita"
      Top             =   2760
      Width           =   975
   End
   Begin VB.TextBox txtStatusOffset 
      Height          =   255
      Left            =   1680
      TabIndex        =   55
      Top             =   3120
      Width           =   975
   End
   Begin VB.TextBox txtStatusdbg 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   2760
      TabIndex        =   54
      Text            =   "-"
      Top             =   3120
      Width           =   615
   End
   Begin VB.CommandButton cmdE 
      Caption         =   ">"
      Height          =   255
      Left            =   6240
      TabIndex        =   53
      Top             =   2160
      Width           =   375
   End
   Begin VB.CommandButton cmdW 
      Caption         =   "<"
      Height          =   255
      Left            =   5880
      TabIndex        =   52
      Top             =   2160
      Width           =   375
   End
   Begin VB.CommandButton cmdS 
      Caption         =   "\/"
      Height          =   255
      Left            =   5280
      TabIndex        =   51
      Top             =   2160
      Width           =   375
   End
   Begin VB.CommandButton cmdN 
      Caption         =   "/\"
      Height          =   255
      Left            =   4920
      TabIndex        =   50
      Top             =   2160
      Width           =   375
   End
   Begin VB.TextBox txtLightdbg 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   2760
      TabIndex        =   48
      Text            =   "-"
      Top             =   2760
      Width           =   615
   End
   Begin VB.TextBox txtmyPosYOffset 
      Height          =   255
      Left            =   1680
      TabIndex        =   46
      Top             =   4560
      Width           =   975
   End
   Begin VB.TextBox txtmyPosXOffset 
      Height          =   255
      Left            =   1680
      TabIndex        =   44
      Top             =   4200
      Width           =   975
   End
   Begin VB.TextBox txtSpeeddbg 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   2760
      TabIndex        =   43
      Text            =   "-"
      Top             =   3840
      Width           =   615
   End
   Begin VB.TextBox txtYdbg 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   2760
      TabIndex        =   42
      Text            =   "-"
      Top             =   4560
      Width           =   615
   End
   Begin VB.TextBox txtXdbg 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   2760
      TabIndex        =   41
      Text            =   "-"
      Top             =   4200
      Width           =   615
   End
   Begin VB.TextBox txtZdbg 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   2760
      TabIndex        =   40
      Text            =   "-"
      Top             =   4920
      Width           =   615
   End
   Begin VB.TextBox txtmyPosZOffset 
      Height          =   255
      Left            =   1680
      TabIndex        =   38
      Top             =   4920
      Width           =   975
   End
   Begin VB.TextBox txtSpyOffset 
      Height          =   255
      Left            =   1680
      TabIndex        =   36
      Top             =   3480
      Width           =   975
   End
   Begin VB.TextBox txtSpeedOffset 
      Height          =   255
      Left            =   1680
      TabIndex        =   34
      Top             =   3840
      Width           =   975
   End
   Begin VB.TextBox txtPartialcap 
      Height          =   285
      Left            =   1440
      TabIndex        =   30
      Top             =   960
      Width           =   1215
   End
   Begin VB.CommandButton cmdClassID 
      Caption         =   "Caption ID:"
      Height          =   255
      Left            =   3720
      TabIndex        =   28
      Top             =   960
      Width           =   1095
   End
   Begin VB.TextBox txtMsgCombo 
      Height          =   315
      Left            =   4920
      TabIndex        =   27
      Text            =   "Hello"
      Top             =   1800
      Width           =   1695
   End
   Begin VB.ComboBox cmbChar 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   315
      ItemData        =   "frmDebug.frx":0000
      Left            =   4920
      List            =   "frmDebug.frx":0002
      Style           =   2  'Dropdown List
      TabIndex        =   26
      Top             =   1440
      Width           =   1695
   End
   Begin VB.CommandButton cmdLoad 
      Caption         =   "Load"
      Height          =   375
      Left            =   5280
      TabIndex        =   25
      Top             =   5160
      Width           =   1335
   End
   Begin VB.CommandButton cmdSave 
      Caption         =   "Save"
      Height          =   375
      Left            =   3720
      TabIndex        =   24
      Top             =   5160
      Width           =   1335
   End
   Begin VB.TextBox txtLightOffset 
      Height          =   255
      Left            =   1680
      TabIndex        =   22
      Top             =   2760
      Width           =   975
   End
   Begin VB.TextBox txtBaseAddress 
      Height          =   255
      Left            =   1440
      TabIndex        =   21
      Top             =   1320
      Width           =   1215
   End
   Begin VB.TextBox txtMainAddress 
      Height          =   255
      Left            =   1440
      TabIndex        =   18
      Top             =   1680
      Width           =   1215
   End
   Begin VB.TextBox txttibia_ManaOffSet 
      Height          =   255
      Left            =   1680
      TabIndex        =   17
      Top             =   2400
      Width           =   975
   End
   Begin VB.TextBox txttibia_HealthOffSet 
      Height          =   255
      Left            =   1680
      TabIndex        =   16
      Top             =   2040
      Width           =   975
   End
   Begin VB.CommandButton cmdKey 
      Caption         =   "Send All"
      Height          =   255
      Left            =   3720
      TabIndex        =   10
      Top             =   1800
      Width           =   1095
   End
   Begin VB.TextBox txtCaption 
      Height          =   285
      Left            =   4920
      TabIndex        =   8
      Text            =   "MasterCores"
      Top             =   600
      Width           =   1695
   End
   Begin VB.CommandButton cmdwID 
      Caption         =   "Show all IDs:"
      Height          =   255
      Left            =   3720
      TabIndex        =   6
      ToolTipText     =   "Show IDs from every client (uses class name)"
      Top             =   1440
      Width           =   1095
   End
   Begin VB.CommandButton cmdRead 
      Caption         =   "Read"
      Height          =   255
      Left            =   2760
      TabIndex        =   5
      Top             =   5280
      Width           =   615
   End
   Begin VB.TextBox txtManadbg 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   2760
      TabIndex        =   4
      Text            =   "-"
      Top             =   2400
      Width           =   615
   End
   Begin VB.TextBox txtHPdbg 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   2760
      TabIndex        =   3
      Text            =   "-"
      Top             =   2040
      Width           =   615
   End
   Begin VB.TextBox txtClassname 
      Height          =   285
      Left            =   1200
      TabIndex        =   2
      Top             =   600
      Width           =   1455
   End
   Begin VB.CommandButton cmdApplyClass 
      Caption         =   "Apply"
      Height          =   255
      Left            =   1440
      TabIndex        =   1
      Top             =   5280
      UseMaskColor    =   -1  'True
      Width           =   975
   End
   Begin VB.CommandButton cmdChangeClass 
      Caption         =   "Restore"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   5280
      Width           =   975
   End
   Begin VB.Label Label19 
      Caption         =   "Light size :"
      Height          =   255
      Left            =   3720
      TabIndex        =   64
      Top             =   3480
      Width           =   975
   End
   Begin VB.Label Label18 
      Caption         =   "Auto Haste :"
      Height          =   255
      Left            =   3720
      TabIndex        =   62
      Top             =   3120
      Width           =   975
   End
   Begin VB.Label Label10 
      Caption         =   "Auto Utamo :"
      Height          =   255
      Left            =   3720
      TabIndex        =   59
      Top             =   2760
      Width           =   1095
   End
   Begin VB.Label Label3 
      Caption         =   "Status Flags Offset"
      Height          =   255
      Left            =   240
      TabIndex        =   56
      Top             =   3120
      Width           =   1335
   End
   Begin VB.Label Label2 
      Caption         =   "Move All :"
      Height          =   255
      Left            =   3960
      TabIndex        =   49
      Top             =   2160
      Width           =   735
   End
   Begin VB.Label Label22 
      Caption         =   "myPosY Offset"
      Height          =   255
      Left            =   240
      TabIndex        =   47
      Top             =   4560
      Width           =   1335
   End
   Begin VB.Label Label21 
      Caption         =   "myPosX Offset"
      Height          =   255
      Left            =   240
      TabIndex        =   45
      Top             =   4200
      Width           =   1335
   End
   Begin VB.Label Label17 
      Caption         =   "myPosZ Offset"
      Height          =   255
      Left            =   240
      TabIndex        =   39
      Top             =   4920
      Width           =   1335
   End
   Begin VB.Label Label16 
      Caption         =   "Level Spy Offset"
      Height          =   255
      Left            =   240
      TabIndex        =   37
      Top             =   3480
      Width           =   1335
   End
   Begin VB.Label Label15 
      Caption         =   "Speed Offset"
      Height          =   255
      Left            =   240
      TabIndex        =   35
      Top             =   3840
      Width           =   975
   End
   Begin VB.Label txtcapID 
      BackColor       =   &H8000000E&
      Height          =   255
      Left            =   2760
      TabIndex        =   33
      ToolTipText     =   "Show ID of top most client window"
      Top             =   960
      Width           =   615
   End
   Begin VB.Label txtclassID 
      BackColor       =   &H8000000E&
      Height          =   255
      Left            =   2760
      TabIndex        =   32
      ToolTipText     =   "Show ID of top most client window"
      Top             =   600
      Width           =   615
   End
   Begin VB.Label Label14 
      Caption         =   "Partial Caption"
      Height          =   255
      Left            =   240
      TabIndex        =   31
      Top             =   960
      Width           =   1095
   End
   Begin VB.Line Line17 
      X1              =   3720
      X2              =   6600
      Y1              =   1320
      Y2              =   1320
   End
   Begin VB.Label txtwID 
      BackColor       =   &H8000000E&
      Caption         =   "0"
      Height          =   255
      Left            =   4920
      TabIndex        =   29
      ToolTipText     =   "Show ID of top most client window"
      Top             =   960
      Width           =   1695
   End
   Begin VB.Line Line16 
      X1              =   6720
      X2              =   3600
      Y1              =   5640
      Y2              =   5640
   End
   Begin VB.Line Line15 
      X1              =   6720
      X2              =   3600
      Y1              =   4680
      Y2              =   4680
   End
   Begin VB.Line Line13 
      X1              =   6720
      X2              =   6720
      Y1              =   5640
      Y2              =   4680
   End
   Begin VB.Line Line1 
      X1              =   3600
      X2              =   3600
      Y1              =   5640
      Y2              =   4680
   End
   Begin VB.Label Label13 
      Caption         =   "Load Configuration:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   3720
      TabIndex        =   23
      Top             =   4800
      Width           =   1935
   End
   Begin VB.Label Label12 
      Caption         =   "Base Address"
      Height          =   255
      Left            =   240
      TabIndex        =   20
      Top             =   1320
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "Class Name"
      Height          =   255
      Left            =   240
      TabIndex        =   19
      Top             =   600
      Width           =   855
   End
   Begin VB.Line Line14 
      X1              =   3480
      X2              =   120
      Y1              =   5640
      Y2              =   5640
   End
   Begin VB.Label Label11 
      Caption         =   "Light Offset"
      Height          =   255
      Left            =   240
      TabIndex        =   15
      Top             =   2760
      Width           =   975
   End
   Begin VB.Label Label9 
      Caption         =   "mainAddress"
      Height          =   255
      Left            =   240
      TabIndex        =   14
      Top             =   1680
      Width           =   1095
   End
   Begin VB.Label Label8 
      Caption         =   "tibia_ManaOffSet"
      Height          =   255
      Left            =   240
      TabIndex        =   13
      Top             =   2400
      Width           =   1335
   End
   Begin VB.Label Label7 
      Caption         =   "tibia_HealthOffSet"
      Height          =   255
      Left            =   240
      TabIndex        =   12
      Top             =   2040
      Width           =   1335
   End
   Begin VB.Label Label6 
      Caption         =   "Address:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   240
      TabIndex        =   11
      Top             =   240
      Width           =   855
   End
   Begin VB.Label Label5 
      Caption         =   "Client caption :"
      Height          =   255
      Left            =   3720
      TabIndex        =   9
      Top             =   600
      Width           =   1095
   End
   Begin VB.Line Line12 
      X1              =   3600
      X2              =   3600
      Y1              =   2520
      Y2              =   120
   End
   Begin VB.Line Line11 
      X1              =   6720
      X2              =   6720
      Y1              =   2520
      Y2              =   120
   End
   Begin VB.Line Line10 
      X1              =   6720
      X2              =   3600
      Y1              =   2520
      Y2              =   2520
   End
   Begin VB.Label Label4 
      Caption         =   "Test Window detection:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   3720
      TabIndex        =   7
      Top             =   240
      Width           =   2415
   End
   Begin VB.Line Line9 
      X1              =   6720
      X2              =   3600
      Y1              =   120
      Y2              =   120
   End
   Begin VB.Line Line4 
      X1              =   120
      X2              =   120
      Y1              =   120
      Y2              =   5640
   End
   Begin VB.Line Line3 
      X1              =   3480
      X2              =   120
      Y1              =   120
      Y2              =   120
   End
   Begin VB.Line Line2 
      X1              =   3480
      X2              =   3480
      Y1              =   5640
      Y2              =   120
   End
End
Attribute VB_Name = "frmDebug"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Sub keybd_event Lib "user32" _
         (ByVal bVk As Byte, _
          ByVal bScan As Byte, _
          ByVal dwFlags As Long, ByVal dwExtraInfo As Long)

Private Sub cmdApplyClass_Click()

ApplyAddress

End Sub

Private Sub cmdChangeClass_Click()

InitializeCampsADR

'cmdApplyClass_Click

End Sub

Private Sub cmdClassID_Click()
Dim lhWndP As Long
Dim tibiaclient As Long

If GetHandleFromPartialCaption(lhWndP, txtCaption.Text) = True Then
    tibiaclient = lhWndP
    txtwID.Caption = tibiaclient
    Else
    txtwID.Caption = "nothing"
End If

End Sub

Private Sub cmdE_Click()
Dim tibiaclient As Long
Dim i As Long
Dim x As Long
Dim letra As String

If TibiaWindow <> 0 Then
    Do
        tibiaclient = FindWindowEx(0, tibiaclient, tibiaclassname, vbNullString)
        If tibiaclient = 0 Then
            Exit Do
        Else
            PostMessage tibiaclient, WM_KEYDOWN, VK_RIGHT, lparamvar
            PostMessage tibiaclient, WM_KEYUP, VK_RIGHT, lparamvar
        End If
    Loop
End If
    
End Sub

Private Sub cmdKey_Click()
Dim tibiaclient As Long
Dim i As Long
Dim x As Long
Dim letra As String

If TibiaWindow <> 0 Then
    Do
        tibiaclient = FindWindowEx(0, tibiaclient, tibiaclassname, vbNullString)
        If tibiaclient = 0 Then
            Exit Do
        Else
            For i = 1 To Len(txtMsgCombo.Text)
                letra = Mid(txtMsgCombo.Text, i)
                PostMessage tibiaclient, WM_CHAR, Asc(letra), lparamvar
            Next i
            PostMessage tibiaclient, WM_CHAR, 13, lparamvar
            PostMessage tibiaclient, WM_KEYDOWN, 13, lparamvar
            PostMessage tibiaclient, WM_KEYUP, 13, lparamvar

        End If
    Loop
Else
    'do nothing
End If

End Sub

Private Sub cmdLoad_Click()

Dim strRes As String
Dim strPath As String
Dim strFPath As String

    LoadSettingsFromFile

    strPath = App.Path
    If Right$(strPath, 1) <> "\" Then
        strPath = strPath & "\"
    End If
    
    'test
    'ApplyAddress

End Sub

Private Sub cmdN_Click()
Dim tibiaclient As Long
Dim i As Long
Dim x As Long
Dim letra As String

If TibiaWindow <> 0 Then
    Do
        tibiaclient = FindWindowEx(0, tibiaclient, tibiaclassname, vbNullString)
        If tibiaclient = 0 Then
            Exit Do
        Else
            PostMessage tibiaclient, WM_KEYDOWN, VK_UP, lparamvar
            PostMessage tibiaclient, WM_KEYUP, VK_UP, lparamvar
        End If
    Loop
End If
    
End Sub

Private Sub cmdRead_Click()
Dim tibiaclient As Long
Dim lhWndP As Long

'txtHPdbg.Text = MyHP
'txtManadbg.Text = MyMana

If TibiaWindow = 0 Then
    txtHPdbg.Text = "-"
    txtManadbg.Text = "-"
    txtXdbg.Text = "-"
    txtYdbg.Text = "-"
    txtZdbg.Text = "-"
    txtSpeeddbg.Text = "-"
    txtLightdbg.Text = "-"
    txtStatusdbg.Text = "-"
Else
    txtHPdbg.Text = MyHP
    txtManadbg.Text = MyMana
    txtXdbg.Text = MyX
    txtYdbg.Text = MyY
    txtZdbg.Text = MyZ
    txtSpeeddbg.Text = MySpeed
    txtLightdbg.Text = MyLight
    txtStatusdbg.Text = MyStatus
End If
    
    Do
    tibiaclient = FindWindowEx(0, tibiaclient, tibiaclassname, vbNullString)
    If tibiaclient = 0 Then
      tibiaclient = FindWindow(tibiaclassname, vbNullString)
        If tibiaclient = 0 Then
            txtclassID.Caption = "0"
            Exit Do
        Else
            txtclassID.Caption = tibiaclient
        End If
      Exit Do
    Else
    txtclassID.Caption = tibiaclient
    End If
    Loop
    
    If GetHandleFromPartialCaption(lhWndP, partialCap) = True Then
        txtcapID.Caption = lhWndP
    Else
        txtcapID.Caption = "0"
    End If

End Sub

Private Sub cmdS_Click()
Dim tibiaclient As Long
Dim i As Long
Dim x As Long
Dim letra As String

If TibiaWindow <> 0 Then
    Do
        tibiaclient = FindWindowEx(0, tibiaclient, tibiaclassname, vbNullString)
        If tibiaclient = 0 Then
            Exit Do
        Else
            PostMessage tibiaclient, WM_KEYDOWN, VK_DOWN, lparamvar
            PostMessage tibiaclient, WM_KEYUP, VK_DOWN, lparamvar
        End If
    Loop
End If
    
End Sub

Private Sub cmdSave_Click()

SaveSettingsToFile

End Sub

Private Sub cmdW_Click()
Dim tibiaclient As Long
Dim i As Long
Dim x As Long
Dim letra As String

If TibiaWindow <> 0 Then
    Do
        tibiaclient = FindWindowEx(0, tibiaclient, tibiaclassname, vbNullString)
        If tibiaclient = 0 Then
            Exit Do
        Else
            PostMessage tibiaclient, WM_KEYDOWN, VK_LEFT, lparamvar
            PostMessage tibiaclient, WM_KEYUP, VK_LEFT, lparamvar
        End If
    Loop
End If
    
End Sub

Private Sub cmdwID_Click()
Dim lhWndP As Long
Dim tibiaclient As Long
Dim i As Long
Dim j As Long
Dim item As Long

cmbChar.Clear

    Do
        tibiaclient = FindWindowEx(0, tibiaclient, tibiaclassname, vbNullString)
        If tibiaclient = 0 Then
            Exit Do
        Else
            cmbChar.AddItem tibiaclient
            cmbChar.Text = tibiaclient
        End If
    Loop
    
    'Do
    '    If GetHandleFromPartialCaption(lhWndP, partialCap) = True Then
    '        cmbChar.AddItem lhWndP
    '        cmbChar.Text = lhWndP
    '    Else
    '    Exit Do
    '    End If
    'Loop
    
    
       ' For i = 0 To cmbChar.ListCount
       '     item = cmbChar.List(i)
       '         For j = 0 To cmbChar.ListCount
       '             If item = cmbChar.List(j) Then
       '                 cmbChar.RemoveItem j
       '                 Exit For
       '             End If
       '         Exit For
       '     Next j
       ' Next i

End Sub

Private Sub Form_Unload(Cancel As Integer)
    If MustUnload = False Then
        Cancel = True
        Me.Hide
    End If
End Sub


Private Sub LoadSettingsFromFile()
    On Error GoTo goterr
    
    Dim strRes As String
    Dim strRes2 As String
    Dim sOpen As SelectedFile
    Dim count As Integer
    Dim FileList As String
    
    FileDialog.sFilter = "Ini (*.ini)" & Chr$(0) & "*.ini"
    
    ' See Standard CommonDialog Flags for all options
    FileDialog.FLAGS = OFN_EXPLORER Or OFN_LONGNAMES Or OFN_HIDEREADONLY
    'FileDialog.sDlgTitle = "Show Open"
    FileDialog.sInitDir = App.Path & "\Save"
    sOpen = ShowOpen(Me.hwnd)
    If Err.Number <> 32755 And sOpen.bCanceled = False Then
        strRes = sOpen.sLastDirectory & sOpen.sFiles(1)
        strRes2 = LoadSettings(strRes)
        'test apply
        ApplyAddress
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

Private Sub SaveSettingsToFile()
    On Error GoTo goterr
    
    Dim strRes As String
    Dim strRes2 As String
    Dim sOpen As SelectedFile
    Dim count As Integer
    Dim FileList As String
    
    FileDialog.sFilter = "Ini (*.ini)" & Chr$(0) & "*.ini"
    
    ' See Standard CommonDialog Flags for all options
    FileDialog.FLAGS = OFN_EXPLORER Or OFN_LONGNAMES Or OFN_HIDEREADONLY
    'FileDialog.sDlgTitle = "Show Open"
    FileDialog.sInitDir = App.Path & "\Save"
    sOpen = ShowSave(Me.hwnd)
    If Err.Number <> 32755 And sOpen.bCanceled = False Then
        strRes = sOpen.sLastDirectory & sOpen.sFiles(1)
        If Right$(strRes, 4) <> ".ini" Then
            strRes = strRes & ".ini"
        End If
        strRes2 = SaveSettings(strRes)
        If strRes2 = "" Then
            'MsgBox BString(32) & strRes, vbOKOnly + vbInformation, BString(31)
        Else
            MsgBox strRes2, vbOKOnly + vbCritical, "Error saving " & strRes
        End If
    End If
    Exit Sub
    
goterr:
    If Err.Number <> 32755 Then
        MsgBox "Unexpected error " & Err.Number & ": " & Err.Description, vbOKOnly + vbCritical, "Error"
    End If
    
End Sub

Private Sub txtMainAddress_Change()
If IsNumeric(txtMainAddress.Text) = True Then
    ' ok
Else
    txtMainAddress.Text = "&H0"
End If
End Sub

Private Sub txtLightOffset_Change()
If IsNumeric(txtLightOffset.Text) = True Then
    ' ok
Else
    txtLightOffset.Text = "&H0"
End If
End Sub

Private Sub txtmyPosXOffset_Change()
If IsNumeric(txtmyPosXOffset.Text) = True Then
    ' ok
Else
    txtmyPosXOffset.Text = "&H0"
End If
End Sub

Private Sub txtmyPosYOffset_Change()
If IsNumeric(txtmyPosYOffset.Text) = True Then
    ' ok
Else
    txtmyPosYOffset.Text = "&H0"
End If
End Sub

Private Sub txtmyPosZOffset_Change()
If IsNumeric(txtmyPosZOffset.Text) = True Then
    ' ok
Else
    txtmyPosZOffset.Text = "&H0"
End If
End Sub

Private Sub txtSpeedOffset_Change()
If IsNumeric(txtSpeedOffset.Text) = True Then
    ' ok
Else
    txtSpeedOffset.Text = "&H0"
End If
End Sub

Private Sub txtSpyOffset_Change()
If IsNumeric(txtSpyOffset.Text) = True Then
    ' ok
Else
    txtSpyOffset.Text = "&H0"
End If
End Sub

Private Sub txtStatusOffset_Change()
If IsNumeric(txtStatusOffset.Text) = True Then
    ' ok
Else
    txtStatusOffset.Text = "&H0"
End If
End Sub

Private Sub txttibia_HealthOffSet_Change()
If IsNumeric(txttibia_HealthOffSet.Text) = True Then
    ' ok
Else
    txttibia_HealthOffSet.Text = "&H0"
End If
End Sub

Private Sub txttibia_ManaOffSet_Change()
If IsNumeric(txttibia_ManaOffSet.Text) = True Then
    ' ok
Else
    txttibia_ManaOffSet.Text = "&H0"
End If
End Sub

Private Sub txtUtamo_Change()

If txtUtamo.Text = "" Then
    txtUtamo.Text = "?"
Else
    'ok
End If

End Sub

Private Sub txtUtamoMana_Change()

If IsNumeric(txtUtamoMana) = True Then
    ' ok
Else
    txtUtamoMana.Text = "0"
End If

End Sub

Private Sub txtHurMana_Change()

If IsNumeric(txtHurMana) = True Then
    ' ok
Else
    txtHurMana.Text = "0"
End If

End Sub

Private Sub txtHur_Change()

If txtHur.Text = "" Then
    txtHur.Text = "?"
Else
    'ok
End If

End Sub
