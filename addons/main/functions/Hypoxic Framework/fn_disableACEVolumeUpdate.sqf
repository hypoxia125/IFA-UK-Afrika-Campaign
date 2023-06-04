params [
	["_mode", false, [true]],
	["_global", false, [true]]
];

if !(isClass (configFile >> "cfgpatches" >> "ace_volume")) exitWith {};

missionNamespace setVariable ["ace_hearing_disableVolumeUpdate", _mode, _global];
_mode