#include "../defines_mission.inc"

if !(hasInterface) exitWith {false};

if !(canSuspend) exitWith {_this spawn _thisScript};

private _obsPos = [4995.96,1675.6,0];
waitUntil {
    !(lineIntersects [eyePos player, _obsPos])
	&&
	{screentoworld [0.5, 0.5] distance _obsPos <= 40}
};

player setVariable [
	MISSION + "obsComplete",
	true,
	true
];