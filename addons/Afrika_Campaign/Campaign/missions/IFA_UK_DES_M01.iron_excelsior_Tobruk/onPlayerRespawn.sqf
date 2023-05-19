#include "defines_mission.inc"

params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

// Fade Out
titleText ["", "BLACK OUT", 1e-3, true, false];

// Set Face Towards Castle
_newUnit setDir (getDir _newUnit + (_newUnit getRelDir [5269.68,1637.52,0]));

// Fade In
sleep 1;
titleText ["", "BLACK IN", 3, true, false];