#include "..\defines_mission.inc"

private _dummyGrp = createGroup [PLAYER_SIDE, true];
_dummyGrp setGroupIdGlobal ["Headquarters"];
private _dummy = _dummyGrp createUnit ["B_soldier_F", [0,0,0], [], 0, "NONE"];
_dummy addItem "ItemRadio";
_dummy assignItem "ItemRadio";

_dummy enableSimulationGlobal false;
_dummy hideObjectGlobal true;
_dummy allowDamage false;

[_dummy, "B_commander"] remoteExec ["setIdentity", 0, _dummy];

missionNamespace setVariable ["HQ", _dummy, true];