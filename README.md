#### Simple Visual Basic 6 Wrapper for AppDynamics C++ SDK

#### Functions available
* Agent Initialization & Termination
* Start & End Business Transactions
* Declare Backends & Properties
* Begin & End Exit Calls

Please refer to [AppDynamics Documentation](https://docs.appdynamics.com/pages/viewpage.action?pageId=45486534) to understand all available functions available in the C++ SDK. You can expand the Wrapper Coverage adding the desired functions and compiling a new DLL.

#### How to use

1) Add the **mdlAppd.bas** file to your VB project and **appdWrapper.dll** to the desired location. Update this location on the bas module file. Remember that the AppDynamics C++ SDK (32 bit) library (appdynamics.dll) should be available on the machine path (C:\Windows\System32 and C:\Windows\SysWow64\)

2) Call the **AppD_Initialize** functions to set the controller connection, application, tier, node and log information.

3) Call the **AppD_StartBT** and the following functions. Refer to the Form1.frm sample to see a complete sequence of calls.


Important: This *wrapper* is not official part of product and not oficially supported by AppDynamics.

#### Expected results:

**Flowmap**

![Flowmap](https://raw.githubusercontent.com/luisredda/appd-cpp-vb6-wrapper/master/FlowmapVB6.jpeg)

**Business Transactions**

![BTs](https://raw.githubusercontent.com/luisredda/appd-cpp-vb6-wrapper/master/BTVB6.jpeg)

**Snapshot

![Snapshot](https://raw.githubusercontent.com/luisredda/appd-cpp-vb6-wrapper/master/SnapshotVB6.jpeg)
