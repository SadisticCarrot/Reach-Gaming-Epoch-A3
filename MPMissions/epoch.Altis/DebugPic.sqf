/*
        DebugPic script
        by Halv, idea from machine6fd's mission.sqm version
*/
 
//Change to your picture/path below
_pic = "custom\GameBord1.jpg";
 
 
//======================== Do not touch anything below this point ========================\\
if(isServer)then{
        diag_log "[DebugPic]: Waiting for 'Debug_static_F' to be build ...";
        waitUntil{count(nearestObjects [getMarkerPos "respawn_west", ["Debug_static_F"], 30]) > 0};
        _list = nearestObjects [getMarkerPos "respawn_west", ["Debug_static_F"], 30];
        _box = _list select 0;
        _rPos = _box modelToWorld [-0.226563,-9.76563,-5.04319];
        _rDir = (getDir _box)+180;
        _obj = createVehicle ["UserTexture10m_F", _rPos, [], 0, "CAN_COLLIDE"];
        _obj setDir _rDir;
        _obj setPos _rPos;
        _obj enableSimulation false;
        _obj setObjectTextureGlobal [0,_pic];
        diag_log format["[DebugPic]: build texture in %1 @ [%2,%3] with texture '%4'",worldName,_rPos,_rDir,_pic];
};