Attribute VB_Name = "AppDynamics"
  'Guid Generation Libs
    Public Declare Sub CoCreateGuid Lib "ole32.dll" (ByRef pguid As Guid)
    Public Declare Function StringFromGUID2 Lib "ole32.dll" (ByVal rguid As Long, ByVal lpsz As Long, ByVal cchMax As Long) As Long
   
   'Sleep
    Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
   
   'AppDynamics Functions
    Public Declare Function AppD_Initialize Lib "c:\\appdlib\\appdWrapper.dll" (ByVal controller_host As String, ByVal controller_port As Integer, ByVal controller_use_ssl As Integer, _
    ByVal controller_acct As String, ByVal controller_key As String, ByVal app As String, ByVal tier As String, ByVal node As String, ByVal logdir As String) As Long
    Public Declare Function AppD_Terminate Lib "c:\\appdlib\\appdWrapper.dll" () As Integer
    Public Declare Function AppD_StartBT Lib "c:\\appdlib\\appdWrapper.dll" (ByVal BTName As String, ByVal CorrelationHeader As String, ByVal Guid As String) As Integer
    Public Declare Function AppD_EndBT Lib "c:\\appdlib\\appdWrapper.dll" (ByVal BTHandle As String) As Integer
    Public Declare Function AppD_BackEndDeclare Lib "c:\\appdlib\\appdWrapper.dll" (ByVal BackendType As String, ByVal UnregistredName As String) As Integer
    Public Declare Function AppD_SetIdentifyingProperty Lib "c:\\appdlib\\appdWrapper.dll" (ByVal BackEnd As String, ByVal Key As String, ByVal Value As String) As Integer
    Public Declare Function AppD_BackendAdd Lib "c:\\appdlib\\appdWrapper.dll" (ByVal BackEnd As String) As Integer
    Public Declare Function AppD_ExitCallBegin Lib "c:\\appdlib\\appdWrapper.dll" (ByVal BTHandleGuid As String, ByVal ExitCallGuid As String, ByVal BackEnd As String) As Integer
    Public Declare Function AppD_ExitCallEnd Lib "c:\\appdlib\\appdWrapper.dll" (ByVal ExitCallGuid As String) As Integer
    Public Declare Function AppD_ExitCallSetDetails Lib "c:\\appdlib\\appdWrapper.dll" (ByVal ExitCallGuid As String, ByVal Details As String) As Integer
    Public Declare Function AppD_AddBTError Lib "c:\\appdlib\\appdWrapper.dll" (ByVal guid As String, ByVal level As Integer, ByVal message As String, ByVal mark_bt_as_error As Integer) As Integer

Public Type Guid
    Data1 As Long
    Data2 As Integer
    Data3 As Integer
    Data4(0 To 7) As Byte
End Type
  
' Guid Generation Function. An enhancement would be transfer this to the C++ DLL.

Public Function GetGUID() As String
    Dim MyGUID As Guid
    Dim GUIDByte() As Byte
    Dim GuidLen As Long
    
    CoCreateGuid MyGUID
    
    ReDim GUIDByte(80)
    GuidLen = StringFromGUID2(VarPtr(MyGUID.Data1), VarPtr(GUIDByte(0)), UBound(GUIDByte))
    
    GetGUID = Left(GUIDByte, GuidLen)
End Function

