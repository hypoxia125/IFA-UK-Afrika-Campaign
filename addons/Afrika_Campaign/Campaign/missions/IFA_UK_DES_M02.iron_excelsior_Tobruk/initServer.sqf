#include "defines_mission.inc"

// server variables
missionNamespace setVariable [
    MISSION + "landers",
    entities "LIB_LCVP",
    false
];

missionNamespace setVariable [
    MISSION + "tanks",
    entities "LIB_DAK_PzKpfwVI_E",
    false
];

missionNamespace setVariable [
    MISSION + "trucks",
    entities "LIB_DAK_OpelBlitz_Tent",
    false
];

// view distance
setViewDistance VIEW_DISTANCE;

// respawn point
//[west, "area_spawn", "Air Spawn"] call BIS_fnc_addRespawnPosition;

call compileScript ["scripts\server_explosiveBarrels.sqf"];
call compileScript ["scripts\server_unitReveals.sqf"];
call compileScript ["scripts\server_handleResupplyZone.sqf"];
call compileScript ["scripts\server_handleSpawn.sqf"];
call compileScript ["scripts\server_createHQEntity.sqf"];

execVM "missionFlow.sqf";

// server init done
missionNamespace setVariable [SERVERINITDONE, true, true];