#undef TAG
#define TAG						"IFA_UK_DES_"
#undef MISSION
#define MISSION					TAG+"M03_"

private ["_pos"];
for "_i" from 0 to 1000 do {
	_pos = [[MISSION + "spawnArea"],[],{true}] call BIS_fnc_randomPos;
	_pos set [2, 0];

	if (allUnits findIf {_x distance _pos <= 5} == -1) then {break} else {continue};
};


private _tank = createVehicle ["LIB_UK_DR_M4A3_75", _pos, [], 0, "NONE"];
_tank setDir (getDir _tank + (_tank getRelDir [7978.01,912.228,0]));
[_tank, false] remoteExec ["enableSimulationGlobal", 2];

// tank items
clearItemCargoGlobal _tank;
clearMagazineCargoGlobal _tank;
clearBackpackCargoGlobal _tank;
clearWeaponCargoGlobal _tank;

private _tankItems = [
	["ACE_fieldDressing", 20],
	["ACE_elasticBandage", 20],
	["ACE_packingBandage", 20],
	["ACE_quikclot", 20],
	["ACE_epinephrine", 10],
	["ACE_EarPlugs", 5],
	["ACE_morphine", 10],
	["ACE_personalAidKit", 5],
	["ACE_salineIV_500", 10],
	["FirstAidKit", 10],
	["ToolKit", 3]
];

if (isClass (configFile >> "cfgpatches" >> "ace_cargo")) then {
	_tankItems insert [
		-1,
		[
			["ACE_fieldDressing", 20],
			["ACE_elasticBandage", 20],
			["ACE_packingBandage", 20],
			["ACE_quikclot", 20],
			["ACE_epinephrine", 10],
			["ACE_EarPlugs", 5],
			["ACE_morphine", 10],
			["ACE_personalAidKit", 5],
			["ACE_salineIV_500", 10]
		]
	];

	[_tank, 4*2] call ace_cargo_fnc_setSpace;
	for "_i" from 1 to 4 do {
		["ACE_Track", _tank, true] call ace_cargo_fnc_loadItem;
	};
};

{
	_x params ["_item", "_count"];

	_tank addItemCargoGlobal [_item, _count];
} forEach _tankItems;

_tank;