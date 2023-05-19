#include "defines_mission.inc"

// global variables
private _planes = [
		fw190_0, fw190_1, fw190_2, fw190_3, fw190_4, fw190_5, fw190_6, fw190_7, fw190_8, fw190_9
];
SETMVAR(MISSION + "allPlanes", _planes, true);

if ("ace_common" in (activatedAddons apply {toLowerANSI _x})) then {
    SETMVAR(MISSION + "aceActivated", true, true);
} else {
    SETMVAR(MISSION + "aceActivated", false, true);
};

// server variables
respawn_initialPos = [5359.91,1273.69,0];

// handle spawn
[] spawn {
    waitUntil {
        private _players = call HYP_fnc_getAlivePlayers;

        if (time % 25 == 0) then {
            ["Waiting for all players in lobby to spawn..."] remoteExec ["hintSilent"];
        };

        count _players > 0
        &&
        {
            _players findIf {
                private _spawned = _x getVariable ["hyp_spawned", false];
                diag_log format ["%1 players spawned", count _players];
                !_spawned
            } == -1;
        };
    };
    diag_log format ["Mission Starting - All Players Spawned"];
    SETMVAR(MISSIONSTARTED, true, true);
    [""] remoteExec ["hintSilent"];
};

// create airfield lights
private _objects = getMissionLayerEntities "Airstrip Lights" select 0;
private _pos = _objects apply {[getPosATL _x select 0, getPosATL _x select 1, 0]};
_objects apply {deleteVehicle _x};

airstripLights = [];
_pos apply {
    private _light = "#lightpoint" createVehicleLocal _x;
    _light setLightColor [1,1,1];
    _light setLightAmbient [1,1,1];
    _light setLightUseFlare true;
    _light setLightFlareSize 3;
    _light setLightFlareMaxDistance 500;
    _light setLightIntensity 50;

    airstripLights pushBack _light;
};

// explosive barrels
private _objects = getMissionLayerEntities "Explosive Barrels" select 0;
_objects apply {
    _x addEventHandler ["Killed", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];

        _this spawn {
            params ["_unit", "_killer", "_instigator", "_useEffects"];

            sleep random 3;
            private _bomb = createVehicle ["Bo_GBU12_LGB", getPosATL _unit, [], 0, "NONE"];
            _bomb hideObjectGlobal true;
            _bomb setDamage 1;

            _unit setVelocityModelSpace [random 10, random 10, random 50 max 30];
        };
    }];
};

// minefields
private _fields = getMissionLayerEntities "Minefields" select 0;
_fields apply {
    [_x, ["LIB_shumine_42_MINE"], 150, 150, true] call HYP_fnc_createMinefield;
};

// hide markers
(getMissionLayerEntities "Hide Markers" select 1) apply {_x setMarkerAlpha 0};

// HQ entity
private _dummyGrp = createGroup [resistance, true];
_dummyGrp setGroupIdGlobal ["Headquarters"];
private _dummy = _dummyGrp createUnit ["I_soldier_F", [0,0,0], [], 0, "NONE"];
_dummy addItem "ItemRadio";
_dummy assignItem "ItemRadio";

_dummy enableSimulationGlobal false;
_dummy hideObjectGlobal true;

[_dummy, "I_commander"] remoteExec ["setIdentity", 0, _dummy];

SETMVAR("HQ", _dummy, true);

// Create initial respawns
respawn_initial = [resistance, respawn_initialPos, "Insertion"] call BIS_fnc_addRespawnPosition;

// Respawn Inventories
{
    [resistance, _x] call BIS_fnc_addRespawnInventory;
} forEach [
    "IFA_UK_DES_M01_Loadout_Rifleman",
    "IFA_UK_DES_M01_Loadout_Assault"
];

{
    [resistance, [_x, 1, 1]] call BIS_fnc_addRespawnInventory;
} forEach [
    "IFA_UK_DES_M01_Loadout_Sniper",
    "IFA_UK_DES_M01_Loadout_Medic"
];

// Begin mission flow
execVM "missionFlow.sqf";

/*--------------------------------------------------------------------------------------------------
    Server Complete
--------------------------------------------------------------------------------------------------*/
SETMVAR(SERVERINITDONE, true, true);