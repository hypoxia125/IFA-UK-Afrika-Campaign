#include "defines_mission.inc"

waitUntil {
	missionNamespace getVariable [MISSIONSTARTED, false];
};

sleep 3;

// intro voice chat
[true, true] call HYP_fnc_disableACEVolumeUpdate;
private _speech = ["intro", "IFA_UK_DES_M02", nil, "SIDE", nil, nil, 0.1] spawn BIS_fnc_kbTell;
waitUntil {scriptDone _speech};
[false, true] call HYP_fnc_disableACEVolumeUpdate;

sleep 2;

private _tracks = [
	"LeadTrack01_F_Jets",
	"LeadTrack02_F_Jets",
	"EventTrack01_F_Jets",
	"LeadTrack01_F_Malden",
	"LeadTrack02_F_Malden"
];
[_tracks] remoteExec ["HYP_fnc_jukebox"];

// truck task
private _pos = [6318.78,4409.58,10];
[
	PLAYER_SIDE,
	"truck",
	"truck",
	_pos,
	"AUTOASSIGNED",
	10,
	true,
	"destroy",
	true
] call BIS_fnc_taskCreate;

[] spawn {
	waitUntil {
		TRIGGER_TICKRATE_DEFAULT;
		private _trucks = missionNamespace getVariable [MISSION + "trucks", []];
		_trucks findIf {alive _x} == -1;
	};

	["truck", "SUCCEEDED"] call BIS_fnc_taskSetState;
	[true, true] call HYP_fnc_disableACEVolumeUpdate;
	private _speech = ["tasks", "IFA_UK_DES_M02", ["truck", "truck"], "SIDE", nil, nil, 0.1] spawn BIS_fnc_kbTell;
	waitUntil {scriptDone _speech};
	[false, true] call HYP_fnc_disableACEVolumeUpdate;
};

// tank task
private _pos = [3657.89,5225,10];
[
	PLAYER_SIDE,
	"tank",
	"tank",
	_pos,
	"AUTOASSIGNED",
	9,
	true,
	"destroy",
	true
] call BIS_fnc_taskCreate;

[] spawn {
	waitUntil {
		TRIGGER_TICKRATE_DEFAULT;
		private _tanks = missionNamespace getVariable [MISSION + "tanks", []];
		_tanks findIf {alive _x} == -1;
	};

	["tank", "SUCCEEDED"] call BIS_fnc_taskSetState;
	[true, true] call HYP_fnc_disableACEVolumeUpdate;
	private _speech = ["tasks", "IFA_UK_DES_M02", ["tank", "tank"], "SIDE", nil, nil, 0.1] spawn BIS_fnc_kbTell;
	waitUntil {scriptDone _speech};
	[false, true] call HYP_fnc_disableACEVolumeUpdate;
};

// lander task
private _pos = [5410.91,5784.51,10];
[
	PLAYER_SIDE,
	"lander",
	"lander",
	_pos,
	"AUTOASSIGNED",
	8,
	true,
	"Destroy",
	true
] call BIS_fnc_taskCreate;

[] spawn {
	waitUntil {
		TRIGGER_TICKRATE_DEFAULT;
		private _landers = missionNamespace getVariable [MISSION + "landers", []];
		_landers findIf {alive _x} == -1;
	};

	["lander", "SUCCEEDED"] call BIS_fnc_taskSetState;
	[true, true] call HYP_fnc_disableACEVolumeUpdate;
	private _speech = ["tasks", "IFA_UK_DES_M02", ["lander", "lander"], "SIDE", nil, nil, 0.1] spawn BIS_fnc_kbTell;
	waitUntil {scriptDone _speech};
	[false, true] call HYP_fnc_disableACEVolumeUpdate;
};

// all objectives complete
[] spawn {
	waitUntil {
		TRIGGER_TICKRATE_DEFAULT;
		["truck", "tank", "lander"] findIf {!([_x] call BIS_fnc_taskCompleted)} == -1;
	};

	[true, true] call HYP_fnc_disableACEVolumeUpdate;
	private _speech = ["tasks", "IFA_UK_DES_M02", ["final", "final"], "SIDE", nil, nil, 0.1] spawn BIS_fnc_kbTell;
	waitUntil {scriptDone _speech};
	[false, true] call HYP_fnc_disableACEVolumeUpdate;

	private _players = [true] call HYP_fnc_getPlayers;
	{
		[_x, true] remoteExec ["setCaptive", _x];
	} forEach _players;

	sleep 3;

	["victory", true, true, true, false] remoteExec ["BIS_fnc_endMission"];
};