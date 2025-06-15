Attribute VB_Name = "ModAddress"
Option Explicit

Public TibiaWindow As Long 'tibia window foudn on findwindow api
Public tibiaclassname As String
Public partialCap As String
Public tibia_HealthOffSet As Long
Public tibia_ManaOffSet As Long
Public charName As String
Public adrBaseAddress As String
Public lightOffset As Long
Public speedOffset As Long
Public spyOffset As Long
Public myPosXOffset As Long
Public myPosYOffset As Long
Public myPosZOffset As Long
Public myStatusOffset As Long

Public Enum Flag
    Poisoned = 1
    Burning = 2
    Electrified = 4
    Drunk = 8
    ManaShield = 16
    Paralysed = 32
    Hasted = 64
    InBattle = 128
    Drowning = 256
    Freezing = 512
    Dazzled = 1024
    Cursed = 2048
    Buffed = 4096
    CannotLogoutOrEnterProtectionZone = 8192
    WithinPZ = 16384
    Bleeding = 32768
End Enum

Public Const MAX_NAME_LENGHT = 30

Public LIGHT_NOP As Long
Public LIGHT_AMOUNT As Long
Public LightIntensity As Byte
Public LightColour As Byte
Public LightDist As Long
Public LightColourDist As Long

Public adrXgo As Long
Public adrYgo As Long
Public adrZgo As Long
Public adrXPos As Long
Public adrYPos As Long
Public adrZPos As Long
Public MyX As Long
Public MyY As Long
Public MyZ As Long
Public MySpeed As Long
Public MyLight As Long
Public MySpeedBase As Long
Public MyStatus As Long

Public adrPointerToInternalFPSminusH5D As Long ' pointer to an address near the internal value for FPS (inversely relative to FPS) , add +&H5D and you are there
Public adrInternalFPS As Long ' only for Tibia 7.6

Public LEVELSPY_NOP As Long
Public LEVELSPY_ABOVE As Long
Public LEVELSPY_BELOW As Long
Public MAXDATTILES As Long
Public MAXTILEIDLISTSIZE As Long
Public adrMulticlient As Long
Public adrConnectionKey As Long
Public RedSquare As Long
'Public adrSelectedCharIndex As AddressPath
Public adrLastPacket As Long
Public adrCharListPtr As Long
Public adrGo As Long
Public adrNumberOfAttackClick As Long
Public adrNumberOfAttackClicks As Long
Public adrCharListPtrEND As Long
Public proxyChecker As Long
Public LoginServerStartPointer As Long
Public LoginServerStep As Long
Public HostnamePointerOffset As Long
Public IPAddressPointerOffset As Long
Public PortOffset As Long

Public TIBIA_LASTPID As Long
Public TIBIA_LASTOFFSET As Long
Public TIBIA_LASTBASE As Long

Public TibiaVersionLong As Long
Public TibiaVersion As String
Public DefaultTibiaFolder As String
Public OverwriteTibiaExePath As String
Public TibiaExePath As String

Public TibiaIsConnected As Boolean
Public adrNChar As Long
Public CharDist As Long
Public NameDist As Long
Public OutfitDist As Long
Public adrNum As Long

Public adrXOR As Long
'Public adrMyHP As Long
Public mainAddress As Long
Public adrMyMaxHP As Long
Public adrMyMana As Long
Public adrMyMaxMana As Long
Public adrMySoul As Long
Public MAP_POINTER_ADDR As Long
Public OFFSET_POINTER_ADDR As Long
Public PLAYER_Z As Long

Public LAST_BATTLELISTPOS As Long

Public MyHP As Long
Public MyMaxHP As Long
Public MyMana As Long
Public MyMaxMana As Long
Public MySoul As Long
Public MyHPpercent As Long
Public Mymanapercent As Long
    
Public adrConnected As Long
Public MustUnload As Boolean

Public useDynamicOffset As String
Public tibiaModuleRegionSize As Long
Public useDynamicOffsetBool As Boolean
