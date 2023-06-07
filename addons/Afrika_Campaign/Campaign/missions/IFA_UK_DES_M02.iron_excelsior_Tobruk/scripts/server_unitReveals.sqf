#include "..\defines_mission.inc"

[] spawn {
    scriptName "initServer.sqf - unit reveal loop";

    while {units east findif {alive _x} != -1} do {
        units east apply {
            private _unit = _x;
            private _players = [true] call HYP_fnc_getPlayers;

            _players apply {_unit reveal [_x, 4]};
        };
    };

    sleep 10;
};