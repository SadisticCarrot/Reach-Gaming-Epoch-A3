
private["_return","_pos","_medical","_plyrUID","_weapons","_vars","_itemsplayer","_weaponsplayer","_appearance","_plyr","_dmg","_allowSave","_cIndex","_Svars","_current_crypto","_group","_revive","_vehiclePlyr"];_plyr=_this select 0;_vars=_this select 1;if(isNull _plyr)exitWith{diag_log "DEBUG SAVE ABORT null player object";};if !(_plyr getVariable["SETUP",false])exitWith{diag_log format["DEBUG SAVE ABORT not setup: %1",_plyr]};_plyrUID=_plyr getVariable["PUID",""];if(_plyrUID=="")exitWith{diag_log format["DEBUG SAVE ABORT %1",_plyrUID]};if !(alive _plyr)exitWith{_return=["PlayerStats",_plyrUID,0,1]call EPOCH_server_hiveSETBIT;};_vehiclePlyr=vehicle _plyr;if(_vehiclePlyr !=_plyr)then{if !(_vehiclePlyr in EPOCH_saveVehQueue)then{EPOCH_saveVehQueue pushBack _vehiclePlyr;};};if(typeName _vars=="ARRAY")then{if(count _vars==EPOCH_customVarCount)then{_allowSave=true;{if(typeName(_vars select _forEachIndex)!=typeName _x)exitWith{_allowSave=false};}forEach EPOCH_defaultVars;if(_allowSave)then{if !(_vars isEqualTo EPOCH_defaultVars_SEPXVar)then{_cIndex=EPOCH_customVars find "Crypto";_Svars=_plyr getVariable["VARS",[]+EPOCH_defaultVars_SEPXVar];_current_crypto=_Svars select _cIndex;_vars set[_cIndex,_current_crypto];};_group=_plyr getVariable["GROUP",""];_revive=_plyr getVariable["REVIVE",true];_pos=getPosATL _plyr;if(vehicle _plyr !=_plyr)then{_closest=[EPOCH_staticTraderLocations,[],{_plyr distance _x},"ASCEND"]call BIS_fnc_sortBy;if !(_closest isEqualTo[])then{_pos=_closest select 0;_pos set[2,0];};};_dmg=damage _plyr;_medical=[getBleedingRemaining _plyr,0,getOxygenRemaining _plyr,_dmg];_appearance=[goggles _plyr,headgear _plyr,vest _plyr,backpack _plyr,uniform _plyr,typeOf _plyr];_itemsplayer=[getItemCargo(uniformContainer _plyr),getItemCargo(vestContainer _plyr),getItemCargo(backpackContainer _plyr)];_weaponsplayer=[getWeaponCargo(uniformContainer _plyr),getWeaponCargo(vestContainer _plyr),getWeaponCargo(backpackContainer _plyr)];_weapons=[currentWeapon _plyr,weaponsItems _plyr,[primaryWeapon _plyr,secondaryWeapon _plyr,handgunWeapon _plyr]];if(count _this >=4)then{_plyr setVariable["VARS",nil];}else{_plyr setVariable["VARS",_vars];};_return=["Player",_plyrUID,EPOCH_expiresPlayer,[[getDir _plyr,_pos,(call EPOCH_fn_InstanceID)],_medical,_appearance,[],_vars,_weapons,assignedItems _plyr,magazinesAmmo _plyr,_itemsplayer,_weaponsplayer,_group,_revive]]call EPOCH_server_hiveSETEX;if(_vars select 12 >=180)then{_plyr setDamage 1;}else{["PlayerStats",_plyrUID,0,0]call EPOCH_server_hiveSETBIT;};};};};