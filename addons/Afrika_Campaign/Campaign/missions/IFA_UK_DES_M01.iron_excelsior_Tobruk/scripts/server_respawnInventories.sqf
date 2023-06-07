#include "..\defines_mission.inc"

{
    [west, _x] call BIS_fnc_addRespawnInventory;
} forEach [
    "IFA_UK_DES_M01_Loadout_Rifleman",
    "IFA_UK_DES_M01_Loadout_Assault"
];

{
    [west, [_x, 1, 1]] call BIS_fnc_addRespawnInventory;
} forEach [
    "IFA_UK_DES_M01_Loadout_Sniper",
    "IFA_UK_DES_M01_Loadout_Medic"
];