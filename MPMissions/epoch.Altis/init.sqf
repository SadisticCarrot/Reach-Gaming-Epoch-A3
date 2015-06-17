
// Add this at the top of your Init.sqf
#include "start_blck.sqf";
//If server execute this script
if (isServer) then {
	execVM "\q\addons\custom_server\init.sqf";
//If anything but server execute this script
} else {
	[] spawn {
		//This is to spawn the markers when players enter after server has started
		[] execVM "debug\addmarkers.sqf";
		[] execVM "debug\addmarkers2.sqf";
		[] execVM "debug\addmarkers75.sqf";
		[] execVM "debug\addmarkers752.sqf";
		//Event handler to show messages to players // this can be used for other scripts to send messages to players -- see AIM.sqf
		"blck_Message" addPublicVariableEventHandler {titleText[format["%1",_this select 1],"PLAIN DOWN",1];};
	};
}; 
//Status Bar
	if(hasInterface) then{[] execVM "addons\Status_Bar\init_statusBar.sqf"};
//////////////////////////////////////////////////////////////////////////
//cmEARPLUGS CODE START

call compile preProcessFileLineNumbers "cmEarplugs\config.sqf";

//cmEARPLUGS CODE END
//////////////////////////////////////////////////////////////////////////
[] execVM "scripts\safezone.sqf";

	//Debug pic
execVM "DebugPic.sqf";
//
execVM "custom\remove_heli_rockets.sqf";
//
[] execVM "addons\messages\init.sqf";
//add this to the bottom of your init.sqf
[]execVM "IgiLoad\IgiLoadInit.sqf";