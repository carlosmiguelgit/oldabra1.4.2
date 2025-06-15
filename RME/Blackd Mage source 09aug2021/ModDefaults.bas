Attribute VB_Name = "ModDefaults"
Option Explicit

Public Sub InitializeCamps()
Dim i As Long

Menu.cmbHotkey1.Clear
Menu.cmbHotkey2.Clear
Menu.cmbEat.Clear

Menu.cmbHotkey1.AddItem "F1"
Menu.cmbHotkey1.AddItem "F2"
Menu.cmbHotkey1.AddItem "F3"
Menu.cmbHotkey1.AddItem "F4"
Menu.cmbHotkey1.AddItem "F5"
Menu.cmbHotkey1.AddItem "F6"
Menu.cmbHotkey1.AddItem "F7"
Menu.cmbHotkey1.AddItem "F8"
Menu.cmbHotkey1.AddItem "F9"
Menu.cmbHotkey1.AddItem "F10"
Menu.cmbHotkey1.AddItem "F11"
Menu.cmbHotkey1.AddItem "F12"
Menu.cmbHotkey1.AddItem "--"
Menu.cmbHotkey1.Text = "--"
        
Menu.cmbHotkey2.AddItem "F1"
Menu.cmbHotkey2.AddItem "F2"
Menu.cmbHotkey2.AddItem "F3"
Menu.cmbHotkey2.AddItem "F4"
Menu.cmbHotkey2.AddItem "F5"
Menu.cmbHotkey2.AddItem "F6"
Menu.cmbHotkey2.AddItem "F7"
Menu.cmbHotkey2.AddItem "F8"
Menu.cmbHotkey2.AddItem "F9"
Menu.cmbHotkey2.AddItem "F10"
Menu.cmbHotkey2.AddItem "F11"
Menu.cmbHotkey2.AddItem "F12"
Menu.cmbHotkey2.AddItem "--"
Menu.cmbHotkey2.Text = "--"

Menu.cmbEat.AddItem "F1"
Menu.cmbEat.AddItem "F2"
Menu.cmbEat.AddItem "F3"
Menu.cmbEat.AddItem "F4"
Menu.cmbEat.AddItem "F5"
Menu.cmbEat.AddItem "F6"
Menu.cmbEat.AddItem "F7"
Menu.cmbEat.AddItem "F8"
Menu.cmbEat.AddItem "F9"
Menu.cmbEat.AddItem "F10"
Menu.cmbEat.AddItem "F11"
Menu.cmbEat.AddItem "F12"
Menu.cmbEat.AddItem "--"
Menu.cmbEat.Text = "--"

'Versions ' lista de versões

Menu.txtSpellLow.Text = "F1"
Menu.txtSpellHi.Text = "exura vita"
Menu.txtLow.Text = "0"
Menu.txtHi.Text = "0"
Menu.txtMPLow.Text = "25"
Menu.txtMPHi.Text = "80"
Menu.txtHealtmr.Text = "100"
Menu.txtManaTrain.Text = "0"
Menu.txtManaPot.Text = "0"
Menu.txtHealPot.Text = "0"
Menu.txtFlash.Text = "0"
Menu.txtTrainSpell.Text = "utevo lux"

Menu.chkTrain.Value = 0
Menu.chkIdle.Value = 0
Menu.chkEat.Value = 0
Menu.chkLight.Value = 0
Menu.chkFlash.Value = 0
Menu.chkSpeed.Value = 0
Menu.chkUtamo.Value = 0
Menu.chkHur.Value = 0

End Sub

Public Sub InitializeCampsADR()

frmDebug.txtClassname.Text = "shadowillusion"
frmDebug.txtPartialcap.Text = "Shadowillusion"
frmDebug.txttibia_HealthOffSet.Text = "&H468"
frmDebug.txttibia_ManaOffSet.Text = "&H4A0"
frmDebug.txtMainAddress.Text = "&H8036f0"
frmDebug.txtBaseAddress.Text = "shadowillusion_dxd.exe"
frmDebug.txtLightOffset.Text = "&HA0"
frmDebug.txtSpeedOffset.Text = "&H0"
frmDebug.txtSpyOffset.Text = "&H0"
frmDebug.txtStatusOffset.Text = "&H458"
frmDebug.txtmyPosZOffset.Text = "&H14"
frmDebug.txtmyPosXOffset.Text = "&H0"
frmDebug.txtmyPosYOffset.Text = "&H0"
frmDebug.txtUtamo.Text = "utamo vita"
frmDebug.txtUtamoMana.Text = "50"
frmDebug.txtHur.Text = "utani hur"
frmDebug.txtHurMana.Text = "60"
frmDebug.scrollLight.Value = 15

End Sub

Public Sub ApplyAddress()

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
myPosZOffset = CLng(frmDebug.txtmyPosZOffset.Text)
myPosXOffset = CLng(frmDebug.txtmyPosXOffset.Text)
myPosYOffset = CLng(frmDebug.txtmyPosYOffset.Text)

End Sub
