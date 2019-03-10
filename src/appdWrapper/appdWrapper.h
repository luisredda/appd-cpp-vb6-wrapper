
#ifndef appdWrapper_H
#define appdWrapper_H


#ifdef appdWrapper_EXPORTS

int __stdcall AppD_Initialize(const char* controller_host, const unsigned short controller_port, const unsigned int controller_use_ssl, const char* controller_acct, const char* controller_key,
	const char* app, const char* tier, const char* node);
int __stdcall AppD_StartBT(const char* name, const char* correlation_header, char* outGuid);
void __stdcall AppD_EndBT(const char* handle);
void __stdcall AppD_BackEndDeclare(const char* type, const char* unregistered_name);
int __stdcall AppD_SetIdentifyingProperty(const char* backend, const char* key, const char* value);
int __stdcall AppD_BackendAdd(const char* backend);
void __stdcall AppD_ExitCallBegin(const char* bthandleid, const char* exitcallguid, const char* backend);
void __stdcall AppD_ExitCallEnd(const char* exitcallguid);
int __stdcall  AppD_ExitCallSetDetails(const char* exitcallguid, const char*  details);
void __stdcall AppD_Terminate();

#endif
#endif


