#include "defines_mission.inc"

params ["_oldUnit", "_killer", "_respawn", "_respawnDelay"];

private _aceActivated = (isClass (configFile >> "cfgpatches" >> "ace_main"));

if !(player getVariable ["hyp_spawned", false]) exitWith {};

// Instant black screen
if (isMultiplayer) then {
	titleText ["$STR_IFA_UK_DES_WAITFORSPAWN" call BIS_fnc_localize, "BLACK OUT", 1e-3, true, false];
} else {
	titleText ["" call BIS_fnc_localize, "BLACK OUT", 1e-3, true, false];
};

if (_aceActivated) then {
	// Play Death Sound
	private _sound = playSound "ACE_hit_Male01ENGB_high_4";
	waitUntil {isNull _sound};

	[true, false] call HYP_fnc_disableACEVolumeUpdate;
};

// kill squad mates
{
	_x setDamage 1;
} forEach units group _oldUnit;
private _tank = _oldUnit getVariable [MISSION + "playerTank", objNull];
deleteVehicle _tank;

// Mute Game
0 fadeSound 0;
0 fadeRadio 0;
0 fadeSpeech 0;
0 fadeEnvironment 0;

// Wait
waitUntil {alive player};

// Unmute Game
3 fadeSound 1;
3 fadeRadio 1;
3 fadeSpeech 1;
3 fadeEnvironment 0;

if (_aceActivated) then {
	[] spawn {
		sleep 3;
		[false, false] call HYP_fnc_disableACEVolumeUpdate;
	};
};

// Fade in for map screen
titleText ["", "BLACK IN", 1, true, false];