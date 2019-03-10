VERSION 5.00
Begin VB.Form Form1
   Caption         =   "AppDynamics VB6 Wrapper Simple Test"
   ClientHeight    =   3210
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   4935
   LinkTopic       =   "Form1"
   ScaleHeight     =   3210
   ScaleWidth      =   4935
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1
      Height          =   285
      Left            =   1800
      TabIndex        =   2
      Text            =   "1500"
      Top             =   240
      Width           =   1335
   End
   Begin VB.CommandButton Command2
      Caption         =   "BT 2 - Cash Withdraw"
      Height          =   855
      Left            =   960
      TabIndex        =   1
      Top             =   2040
      Width           =   2775
   End
   Begin VB.CommandButton Command1
      Caption         =   "BT1 - Login"
      Height          =   855
      Left            =   960
      TabIndex        =   0
      Top             =   840
      Width           =   2775
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Dim rv As Variant



Private Sub Command1_Click()

Dim tokenBT, tokenExitCall As String
tokenBT = GetGUID
tokenExitCall = GetGUID
Dim valor As String
valor = Text1.Text

'Start the Business Transaction Execution for Cash WithDraw Transaction
rv = AppD_StartBT("Login", "NullCorrelation", tokenBT)

'---
'Your code would be here
'---

'Declare the Database Backend
rv = AppD_BackEndDeclare("DB", "SQLPRD06")
rv = AppD_SetIdentifyingProperty("SQLPRD06", "HOST", "SQLPRD06.company.com")
rv = AppD_SetIdentifyingProperty("SQLPRD06", "PORT", "1433")
rv = AppD_SetIdentifyingProperty("SQLPRD06", "DATABASE", "DBUsuarios")
rv = AppD_SetIdentifyingProperty("SQLPRD06", "VENDOR", "Microsoft")
rv = AppD_BackendAdd("SQLPRD06")

'Start the Exit Call (DB) Execution
rv = AppD_ExitCallBegin(tokenBT, tokenExitCall, "SQLPRD06")
rv = AppD_ExitCallSetDetails(tokenExitCall, "SELECT USERNAME FROM AUTHENTICATION WHERE USERNAME=JOHN")

Sleep Val(valor) 'Sleep to simulate a query execution/slowness


'Terminate the Exit Call Execution
rv = AppD_ExitCallEnd(tokenExitCall)

'---
' Your code would terminate here
'---

' Terminate the Business Transaction Execution
rv = AppD_EndBT(tokenBT)


End Sub

Private Sub Command2_Click()
Dim number As Integer
For number = 1 To 10
Dim tokenBT, tokenExitCall As String
tokenBT = GetGUID
tokenExitCall = GetGUID
Dim valor As String
valor = Text1.Text

'Start the Business Transaction Execution for Cash WithDraw Transaction
rv = AppD_StartBT("Cash Withdraw", "NullCorrelation", tokenBT)

'---
'Your code would be here
'---

'Declare the Database Backend
rv = AppD_BackEndDeclare("DB", "SQLPRD05")
rv = AppD_SetIdentifyingProperty("SQLPRD05", "HOST", "SQLPRD05.company.com")
rv = AppD_SetIdentifyingProperty("SQLPRD05", "PORT", "1433")
rv = AppD_SetIdentifyingProperty("SQLPRD05", "DATABASE", "DBUsuarios")
rv = AppD_BackendAdd("SQLPRD05")

'Start the Exit Call (DB) Execution
rv = AppD_ExitCallBegin(tokenBT, tokenExitCall, "SQLPRD05")
rv = AppD_ExitCallSetDetails(tokenExitCall, "SELECT * FROM USERS WHERE USERNAME=JOHN")

Sleep Val(valor) 'Sleep to simulate a query execution/slowness

'Terminate the Exit Call Execution
rv = AppD_ExitCallEnd(tokenExitCall)


'---
' Your code would terminate here
'---

' Terminate the Business Transaction Execution
rv = AppD_EndBT(tokenBT)

Next

End Sub

Private Sub Form_Load()

rv = AppD_Initialize("controllerhost.appdynamics.com", 8090, 0, "account_name", "account_key", "Application_Name", "Tier_Name", "Node_Name", "c:\\appdlib\\")

End Sub
