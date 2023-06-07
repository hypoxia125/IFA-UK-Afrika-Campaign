#include "defines_mission.inc"

// global variables
private _planes = [
		fw190_0, fw190_1, fw190_2, fw190_3, fw190_4, fw190_5, fw190_6, fw190_7, fw190_8, fw190_9
];
missionNamespace setVariable [MISSION + "allPlanes", _planes, true];

// server variables
respawn_initialPos = [5359.91,1273.69,0];

call compileScript ["scripts\server_handleSpawn.sqf"];
call compileScript ["scripts\server_createAirfieldLights.sqf"];
call compileScript ["scripts\server_explosiveBarrels.sqf"];
call compileScript ["scripts\server_createMinefields.sqf"];
call compileScript ["scripts\server_hideMarkers.sqf"];
call compileScript ["scripts\server_createHQEntity.sqf"];
call compileScript ["scripts\server_initialRespawnPos.sqf"];
call compileScript ["scripts\server_respawnInventories.sqf"];

execVM "missionFlow.sqf";

/*--------------------------------------------------------------------------------------------------
    Server Complete
--------------------------------------------------------------------------------------------------*/
missionNamespace setVariable [SERVERINITDONE, true, true];