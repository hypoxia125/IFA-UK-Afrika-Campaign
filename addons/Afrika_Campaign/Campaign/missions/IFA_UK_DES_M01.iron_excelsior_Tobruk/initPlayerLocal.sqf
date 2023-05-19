#include "defines_mission.inc"

params ["_player", "_didJIP"];

call compileScript ["scripts\player_enableSpectator.sqf"];

// Wait for server
waitUntil {
	GMVAR(SERVERINITDONE, false)
};

// handle initial spawn
[] spawn {
	// skip wait if singleplayer
	[format ["Server Start Check - Waiting for %1 to spawn", name player]] remoteExec ["diag_log", 2];

	if (isMultiplayer) then {
		waitUntil {!(isNull player) && {!(alive player) && {visibleMap}}};
	};
	waitUntil {alive player};

	[format ["Server Start Check - %1 spawned", name player]] remoteExec ["diag_log", 2];

	LAYER_BLACKSCREEN cutText ["$STR_IFA_UK_DES_WAITFORPLAYERS" call BIS_fnc_localize, "BLACK OUT", 1e-3, true];
	player enableSimulation false;
	player setVariable ["hyp_spawned", true, true];
	
	waitUntil {
		sleep 0.5;
		GMVAR(MISSIONSTARTED, false);
	};
	player enableSimulation true;
	LAYER_BLACKSCREEN cutText ["", "BLACK IN", 3, true];
};

// handle singleplayer
units group player - [player] apply {
	deleteVehicle _x;
};

/*--------------------------------------------------------------------------------------------------
	Diary
--------------------------------------------------------------------------------------------------*/
player createDiaryRecord [
	"Diary",
	[
		"$STR_IFA_UK_DES_M01_DIARY_SITU_TITLE" call BIS_fnc_localize,
		"$STR_IFA_UK_DES_M01_DIARY_SITU_DESC" call BIS_fnc_localize
	]
];