#include "stdafx.h"
#include "appdynamics.h"
#include <stdio.h>
#include <objbase.h>

#define appdWrapper_EXPORTS
#include "appdWrapper.h"


int __stdcall AppD_Initialize(const char* controller_host, const unsigned short controller_port, const unsigned int controller_use_ssl, const char* controller_acct, const char* controller_key,
	const char* app, const char* tier, const char* node, const char* dir_logs)
{
	int returnValue = 0;

	appd_config *cfg = appd_config_init();

	appd_config_getenv(cfg, NULL);


	// Controller settings
	appd_config_set_controller_host(cfg,controller_host);
	appd_config_set_controller_port(cfg,controller_port);
	appd_config_set_controller_use_ssl(cfg, controller_use_ssl);
	appd_config_set_controller_account(cfg, controller_acct);
	appd_config_set_controller_access_key(cfg, controller_key);

	// App Model settings
	appd_config_set_app_name(cfg, app);
	appd_config_set_tier_name(cfg, tier);
	appd_config_set_node_name(cfg, node);

	// Log settings
	appd_config_set_logging_min_level(cfg, appd_config_log_level(APPD_LOG_LEVEL_DEBUG));
	appd_config_set_logging_log_dir(cfg, dir_logs);

	// This calls initializes the agent
	int initRC = appd_sdk_init(cfg);
	return initRC;
}

void __stdcall AppD_Terminate() {

	appd_sdk_term();
 }
	//Start a Business Transaction Execution.
  int __stdcall AppD_StartBT(const char* name, const char* correlation_header, const char* guid) {

	appd_bt_handle btHandle = appd_bt_begin(name, correlation_header);

	appd_bt_store(btHandle, guid);

	return 0;
	
}

  //End a Business Transaction Execution
 void __stdcall AppD_EndBT(const char* handle) {
	
	 appd_bt_handle btHandle = appd_bt_get(handle);
	 appd_bt_end(btHandle);
 }

 //Declare a BackEnd
 void __stdcall AppD_BackEndDeclare(const char* type, const char* unregistered_name) {

	 //Types can be HTTP, DB, CACHE, RABBITMQ, WEBSERVICE, JMS, WEBSPHERE_MQ
	 appd_backend_declare(type, unregistered_name);
 }

 //Set properties to a Declared Backend, for example an URL for a Webservice or DB Instance
 int __stdcall AppD_SetIdentifyingProperty(const char* backend, const char* key, const char* value) {

	 int ret;
	 ret = appd_backend_set_identifying_property(backend, key, value);
	 return ret;
 }

 //Add a Backend
 int __stdcall AppD_BackendAdd(const char* backend) {

	 int ret;
	 ret = appd_backend_add(backend);
	 return ret;
 }

 //Begin an Exit Call
 void __stdcall AppD_ExitCallBegin(const char* bthandleid, const char* exitcallguid, const char* backend) {
	 appd_bt_handle bt = appd_bt_get(bthandleid);
	 appd_exitcall_handle exitCall = appd_exitcall_begin(bt, backend);
	 appd_exitcall_store(exitCall, exitcallguid);
 }

 //End an Exit Call
 void __stdcall AppD_ExitCallEnd(const char* exitcallguid) {
	 appd_exitcall_handle exitCall = appd_exitcall_get(exitcallguid);
	 appd_exitcall_end(exitCall);
}

 //Set details for an exit call. For example the SQL Statement for a Database Exit Call.
 int __stdcall  AppD_ExitCallSetDetails(const char* exitcallguid, const char*  details) {
	 int ret;
	 appd_exitcall_handle exitCall = appd_exitcall_get(exitcallguid);
	 ret = appd_exitcall_set_details(exitCall, details);
	 return ret;
 }
