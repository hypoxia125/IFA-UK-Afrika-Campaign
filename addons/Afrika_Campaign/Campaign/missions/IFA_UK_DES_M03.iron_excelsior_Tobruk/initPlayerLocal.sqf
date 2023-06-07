#include "defines_mission.inc"

params ["_player", "_didJIP"];

setTerrainGrid TERRAIN_GRID;

call compileScript ["scripts\player_enableSpectator.sqf"];

LAYER_BLACKSCREEN cutText ["$STR_IFA_UK_DES_WAITFORPLAYERS" call BIS_fnc_localize, "BLACK OUT", 1e-3, true];

// Wait for server
waitUntil {
	missionNamespace getVariable [SERVERINITDONE, false];
};

if !(isMultiplayer) then {
	[player] execVM "onPlayerRespawn.sqf";
};

// handle initial spawn
[] spawn {
	// skip wait if singleplayer
	[format ["Server Start Check - Waiting for %1 to spawn", name player]] remoteExec ["diag_log", 2];

	if (isMultiplayer) then {
		waitUntil {!(isNull player) && {!(alive player)}};
	};
	waitUntil {alive player && {vehicle player != player}};

	LAYER_BLACKSCREEN cutText ["$STR_IFA_UK_DES_WAITFORPLAYERS" call BIS_fnc_localize, "BLACK OUT", 1e-3, true];
	player enableSimulation false;
	player setVariable ["hyp_spawned", true, true];
	
	waitUntil {
		sleep 0.5;
		missionNamespace getVariable [MISSIONSTARTED, false];
	};
	player enableSimulation true;
	LAYER_BLACKSCREEN cutText ["", "BLACK IN", 3, true];
};

// Diary Record
player createDiaryRecord [
	"diary",
	[
		"$STR_IFA_UK_DES_M03_DIARY_01_TITLE" call BIS_fnc_localize,
		"$STR_IFA_UK_DES_M03_DIARY_01_DESC" call BIS_fnc_localize
	]
];