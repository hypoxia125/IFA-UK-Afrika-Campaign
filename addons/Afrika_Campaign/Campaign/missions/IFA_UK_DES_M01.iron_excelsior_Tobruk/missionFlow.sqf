#include "defines_mission.inc"

if !(isServer) exitWith {false};

waitUntil {
	diag_log format ["missionFlow.sqf - Waiting for Mission Start"];
	missionNamespace getVariable [MISSIONSTARTED, false];
};

sleep 1;

// insert - sentence introduction + task 1 + waitUntil
[true, true] call HYP_fnc_disableACEVolumeUpdate;
private _speech = ["intro", "IFA_UK_DES_M01", ["intro_1", "intro_1"], "SIDE"] spawn BIS_fnc_kbTell;
waitUntil {scriptDone _speech};
[false, true] call HYP_fnc_disableACEVolumeUpdate;
sleep 1;
I_Car_0 engineOn false;
I_Car_0 setPilotLight false;
sleep 3;

[true, true] call HYP_fnc_disableACEVolumeUpdate;
private _speech = ["intro", "IFA_UK_DES_M01", ["intro_2", "intro_4"], "SIDE"] spawn BIS_fnc_kbTell;
waitUntil {scriptDone _speech};
[false, true] call HYP_fnc_disableACEVolumeUpdate;
sleep 1;

["stealth"] remoteExec ["HYP_fnc_jukebox"];

// first task
private _taskPos = [5227.33,1557.13,0];

[
	PLAYER_SIDE,
	"infiltrate",
	"infiltrate",
	_taskPos vectorAdd [0,0,5],
	"ASSIGNED",
	100,
	true,
	"move",
	true
] call BIS_fnc_taskCreate;

waitUntil {
	TRIGGER_TICKRATE_DEFAULT;
	private _players = [true] call HYP_fnc_getPlayers;
	_players findIf {_x distance _taskPos <= 8} != -1;
};

["infiltrate", "SUCCEEDED"] call BIS_fnc_taskSetState;

[true, true] call HYP_fnc_disableACEVolumeUpdate;
private _speech = ["observe", "IFA_UK_DES_M01", nil, "SIDE"] spawn BIS_fnc_kbTell;
waitUntil {scriptDone _speech};
[false, true] call HYP_fnc_disableACEVolumeUpdate;
sleep 1;

// second task
private _taskPos = [5188.7,1597.61,11.6456];
[
	PLAYER_SIDE,
	"observe",
	"observe",
	_taskPos vectorAdd [0,0,5],
	"ASSIGNED",
	99,
	true,
	"scout",
	true
] call BIS_fnc_taskCreate;

["scripts\player_returnObservation.sqf"] remoteExec ["execVM"];

waitUntil {
	TRIGGER_TICKRATE_DEFAULT;
	private _players = [true] call HYP_fnc_getPlayers;
	_players findIf {
		_x getVariable [MISSION + "obsComplete", false];
	} != -1
};

["observe", "SUCCEEDED"] call BIS_fnc_taskSetState;

[true, true] call HYP_fnc_disableACEVolumeUpdate;
private _speech = ["destroy", "IFA_UK_DES_M01", nil, "SIDE"] spawn BIS_fnc_kbTell;
waitUntil {scriptDone _speech};
[false, true] call HYP_fnc_disableACEVolumeUpdate;
sleep 1;

// third task
private _taskPos = [4995.61,1675.17,0];
[
	PLAYER_SIDE,
	"destroy",
	"destroy",
	_taskPos vectorAdd [0,0,10],
	"ASSIGNED",
	98,
	true,
	"destroy",
	true
] call BIS_fnc_taskCreate;

waitUntil {
	TRIGGER_TICKRATE_DEFAULT;
	private _planes = missionNamespace getVariable [MISSION + "allPlanes", []];
	_planes findIf {alive _x} == -1;
};

["destroy", "SUCCEEDED"] call BIS_fnc_taskSetState;

[true, true] call HYP_fnc_disableACEVolumeUpdate;
private _speech = ["escape", "IFA_UK_DES_M01", nil, "SIDE"] spawn BIS_fnc_kbTell;
waitUntil {scriptDone _speech};
[false, true] call HYP_fnc_disableACEVolumeUpdate;
sleep 1;

// fourth task
private _taskPos = [5304.07,1043,0];
[
	PLAYER_SIDE,
	"escape",
	"escape",
	_taskPos vectorAdd [0,0,10],
	"ASSIGNED",
	97,
	true,
	"car",
	true
] call BIS_fnc_taskCreate;

private _marker = createMarkerLocal [MISSION + "marker_task_escape", _taskPos];
_marker setMarkerShapeLocal "ICON";
_marker setMarkerColorLocal "ColorBlufor";
_marker setMarkerType "hd_end";

waitUntil {
	TRIGGER_TICKRATE_DEFAULT;
	private _players = [true] call HYP_fnc_getPlayers;
	_players findIf {alive _x && !(_x inArea "area_ending")} == -1
};

["victory", true, true, true, false] remoteExec ["BIS_fnc_endMission"];
["IFA_UK_DES_M01.iron_excelsior_Tobruk_done"] remoteExec ["activateKey"];