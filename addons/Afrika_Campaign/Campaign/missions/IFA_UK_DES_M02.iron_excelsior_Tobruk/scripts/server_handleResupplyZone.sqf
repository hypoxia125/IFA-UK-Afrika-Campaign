#include "..\defines_mission.inc"

[] spawn {
    scriptName "initServer.sqf - Handle Resupply Zone";

    private _area = "area_spawn" call BIS_fnc_getArea;

    waitUntil {missionNamespace getVariable [MISSIONSTARTED, false]};

    while {sleep 1; true} do {
        private _players = [true] call HYP_fnc_getPlayers;

        _players apply {
            private _player = _x;
            if (_player inArea _area && {vehicle _player != _player}) then {
                private _vehicle = vehicle _player;
                private _vehicleDmg = getAllHitPointsDamage _vehicle;

                _vehicleDmg params ["_hitpointArray", "_selectionArray", "_damageArray"];

                if (_damageArray findIf {_x > 0} == -1) then {
                    ["$STR_IFA_UK_DES_REPAIRCOMPLETE"] remoteExec ["HYP_fnc_localizedHint", _player];
                    [_vehicle, 1] remoteExec ["setVehicleAmmoDef", _vehicle];
                    continue;
                };

                ["$STR_IFA_UK_DES_REPAIRING"] remoteExec ["HYP_fnc_localizedHint", _player];
                _damageArray = _damageArray apply {
                    if (_x <= 0) then {0} else {_x - 0.3};
                };

                for "_i" from 0 to (count _damageArray - 1) do {
                    _vehicle setHitPointDamage [_hitpointArray select _i, _damageArray select _i];
                    [_vehicle, [_hitpointArray select _i, _damageArray select _i]] remoteExec ["setHitPointDamage", _vehicle];
                };
                [_vehicle, 1] remoteExec ["setVehicleAmmoDef", _vehicle];
            };
        };
    };
};