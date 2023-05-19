#include "defines_mission.inc"

params ["_oldUnit", "_killer", "_respawn", "_respawnDelay"];

if !(player getVariable ["hyp_spawned", false]) exitWith {};

// Instant black screen
titleText ["", "BLACK OUT", 1e-3, true, false];

if (GMVAR(MISSION + "aceActivated", false)) then {
	// Play Death Sound
	private _sound = playSound "ACE_hit_Male01ENGB_high_4";
	waitUntil {isNull _sound};

	SETMVAR("ace_hearing_disableVolumeUpdate", true, false);
};

// Mute Game
0 fadeSound 0;
0 fadeRadio 0;
0 fadeSpeech 0;
0 fadeEnvironment 0;

// Wait
waitUntil {visibleMap};

// Unmute Game
3 fadeSound 1;
3 fadeRadio 1;
3 fadeSpeech 1;
3 fadeEnvironment 0;

if (GMVAR(MISSION + "aceActivated", false)) then {
	[] spawn {sleep 3; SETMVAR("ace_hearing_disableVolumeUpdate", false, false)}
};

// Fade in for map screen
titleText ["", "BLACK IN", 1, true, false];