#include "..\defines_mission.inc"

private _fields = getMissionLayerEntities "Minefields" select 0;
_fields apply {
    [_x, ["LIB_shumine_42_MINE"], 150, 150, true] call HYP_fnc_createMinefield;
};