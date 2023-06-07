#include "defines_mission.inc"

params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

// Fade Out
titleText ["", "BLACK OUT", 1e-3, true, false];

_newUnit allowDamage false;
_newUnit setPosATL [0,0,0];

private _handle = [_newUnit] spawn {
	params ["_newUnit"];

	// create airplane
	private _pos = [["area_spawn"],[],{true}] call BIS_fnc_randomPos;
	_pos set [2, 300];

	private _plane = createVehicle ["LIB_P47", _pos, [], 0, "FLY"];
	_plane setDir (getDir _plane + (_plane getRelDir [5574.44,6099.93]));
	[_plane, false] remoteExec ["enableSimulationGlobal", 2];

	// move player to plane
	_newUnit moveInDriver _plane;

	// enable airplane
	waitUntil {
		missionNamespace getVariable [MISSIONSTARTED, false]
	};
	[_plane, true] remoteExec ["enableSimulationGlobal", 2];
	_newUnit allowDamage true;

	// handlers for death
	_plane addEventHandler ["Killed", {
		params ["_unit"];

		driver _unit setDamage 1;
	}];
};

waitUntil {scriptDone _handle};
// Fade In
sleep 1;
titleText ["", "BLACK IN", 3, true, false];