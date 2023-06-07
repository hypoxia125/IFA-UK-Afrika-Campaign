#include "defines_mission.inc"

waitUntil {
	TRIGGER_TICKRATE_DEFAULT;
	missionNamespace getVariable [MISSIONSTARTED, false];
};

sleep 3;

[true, true] call HYP_fnc_disableACEVolumeUpdate;
private _speech = ["intro", "IFA_UK_DES_M03", nil, "SIDE", nil, nil, 0.1] spawn BIS_fnc_kbTell;
waitUntil {scriptDone _speech};
[false, true] call HYP_fnc_disableACEVolumeUpdate;

// music
private _tracks = [
	"LeadTrack02_F_Tank",
	"LeadTrack06_F_Tank",
	"LeadTrack01_F_Tank",
	"MainTheme_F_Tank",
	"LeadTrack05_F_Tank"

];
[_tracks] remoteExec ["HYP_fnc_jukebox"];

// Task 1
private _pos = [5948.59,2205.02,10];
[
	PLAYER_SIDE,
	"assault_01",
	"assault_01",
	_pos,
	"AUTOASSIGNED",
	10,
	true,
	"attack",
	true
] call BIS_fnc_taskCreate;

waitUntil {
	TRIGGER_TICKRATE_DEFAULT;
	private _units = units east select {_x distance2D [5948.59,2205.02,10] <= 100};
	private _playersInArea = units PLAYER_SIDE select {_x distance2D [5948.59,2205.02,10] <= 100};
	_units findIf {alive _x} == -1
	||
	{count _playersInArea >= count _units * 2}
};

["assault_01", "SUCCEEDED"] call BIS_fnc_taskSetState;

// Task 2
private _pos = [7336.2,3196.44,10];
[
	PLAYER_SIDE,
	"assault_02",
	"assault_02",
	_pos,
	"AUTOASSIGNED",
	9,
	true,
	"attack",
	true
] call BIS_fnc_taskCreate;

waitUntil {
	TRIGGER_TICKRATE_DEFAULT;
	private _centers = [
		[7187.77,3600.19,0],
		[7349.57,3214.08,0],
		[7109.19,2683.43,0]
	];
	private _units = units east select {
		private _unit = _x;
		_centers findIf {_x distance _unit <= 100} != -1
	};
	private _playersInArea = units PLAYER_SIDE select {
		private _unit = _x;
		_centers findIf {_x distance _unit <= 100} != -1
	};
	_units findIf {alive _x} == -1
	||
	{count _playersInArea >= count _units * 2}
};

["assault_02", "SUCCEEDED"] call BIS_fnc_taskSetState;

sleep 3;

[true, true] call HYP_fnc_disableACEVolumeUpdate;
private _speech = ["end", "IFA_UK_DES_M03", nil, "SIDE", nil, nil, 0.1] spawn BIS_fnc_kbTell;
waitUntil {scriptDone _speech};
[false, true] call HYP_fnc_disableACEVolumeUpdate;

sleep 3;

["victory", true, true, true, false] remoteExec ["BIS_fnc_endMission"];