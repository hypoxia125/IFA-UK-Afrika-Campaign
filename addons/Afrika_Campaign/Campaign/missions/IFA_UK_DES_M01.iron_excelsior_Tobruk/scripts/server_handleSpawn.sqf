#include "..\defines_mission.inc"

[] spawn {
    waitUntil {
        private _players = [false] call HYP_fnc_getPlayers;

        if (time % 25 == 0) then {
            ["$STR_IFA_UK_DES_WAITFORPLAYERS"] remoteExec ["HYP_fnc_localizedHint"];
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
    missionNamespace setVariable [MISSIONSTARTED, true, true];
    [""] remoteExec ["hintSilent"];
};