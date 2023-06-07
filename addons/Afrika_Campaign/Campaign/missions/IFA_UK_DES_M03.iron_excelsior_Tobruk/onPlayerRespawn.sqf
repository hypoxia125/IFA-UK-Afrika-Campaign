#include "defines_mission.inc"

params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

// Fade Out
titleText ["", "BLACK OUT", 1e-3, true, false];

_newUnit allowDamage false;
_newUnit setPosATL [0,0,0];

private _handle = [_newUnit] spawn {
	params ["_newUnit"];

	// create tank
	private _tank = call HYP_fnc_createPlayerTank;
	_newUnit setVariable [MISSION + "playerTank", _tank];

	// move player to plane
	_newUnit moveInCommander _tank;

	waitUntil {vehicle player != player};
	
	// add crew
	for "_i" from 1 to 4 do {
		private _unit = group _newUnit createUnit [typeOf _newUnit, [0,0,0], [], 0, "NONE"];
		_unit setUnitLoadout getUnitLoadout _newUnit;
		_unit moveInAny _tank;
	};

	// enable airplane
	waitUntil {
		missionNamespace getVariable [MISSIONSTARTED, false]
	};
	[_tank, true] remoteExec ["enableSimulationGlobal", 2];
	_newUnit allowDamage true;

	// handlers for death
	_tank addEventHandler ["Killed", {
		params ["_unit"];

		{
			_x setDamage 1;
		} forEach crew _unit;
	}];
};

waitUntil {scriptDone _handle};
// Fade In
sleep 1;
titleText ["", "BLACK IN", 3, true, false];