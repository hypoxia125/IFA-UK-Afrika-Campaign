if !(isServer) exitWith {};

private _players = [true] call HYP_fnc_getPlayers;
_players findIf {alive _x && _x distance this <= 600} != -1
||
{combatBehaviour this in ["COMBAT", "STEALTH"]}