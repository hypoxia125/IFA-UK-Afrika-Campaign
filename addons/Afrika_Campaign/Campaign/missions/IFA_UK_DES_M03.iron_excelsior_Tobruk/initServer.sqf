#include "defines_mission.inc"

// Set View Distance
setViewDistance VIEW_DISTANCE;
setObjectViewDistance VIEW_DISTANCE;

// Disable All Lambs
{
	_x setVariable ["lambs_danger_disableAI", true, true];
} forEach allUnits;

// Killed EH for already spawned units
{
	_x addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];

		_unit spawn {
			sleep 300;
			deleteVehicle _this;
		};
	}]
} forEach allUnits

call compileScript ["scripts\server_handleSpawn.sqf"];
call compileScript ["scripts\server_createHQEntity.sqf"];

execVM "missionFlow.sqf";

// server init done
missionNamespace setVariable [SERVERINITDONE, true, true];