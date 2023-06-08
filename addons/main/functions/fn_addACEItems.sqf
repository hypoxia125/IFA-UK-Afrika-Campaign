params [
	["_unit", objNull, [objNull]]
];

if !(local _unit) exitWith {};

private _promoteMedic = "Medikit" in items _unit;
if (_promoteMedic) then {
	_unit setUnitTrait ["medic", true];
};

// standard ace items
if !(isClass (configFile >> "CfgPatches" >> "ace_main")) exitWith {};

_unit addItem "ACE_EarPlugs";

// medical ace items
if !(isClass (configFile >> "CfgPatches" >> "ace_medical")) exitWith {};

private _items = items _unit;

if ("Medikit" in _items) then {
	{
		if (_x in ["Medikit", "FirstAidKit"]) then {
			_unit removeItem _x;
		};
	} forEach _items;
} else {
	{
		if (_x == "FirstAidKit") then {
			_unit removeItem _x;
		};
	} forEach _items;
};

private ["_itemsToAdd"];
if (_unit getUnitTrait "medic") then {
	_itemsToAdd = [
		["ACE_fieldDressing", 10],
		["ACE_elasticBandage", 10],
		["ACE_packingBandage", 10],
		["ACE_quikclot", 5],
		["ACE_epinephrine", 5],
		["ACE_morphine", 5],
		["ACE_splint", 4],
		["ACE_tourniquet", 4],
		["ACE_salineIV_500", 5],
		["ACE_surgicalKit", 1],
		["ACE_adenosine", 3]
	];
} else {
	_itemsToAdd = [
		["ACE_fieldDressing", 5],
		["ACE_elasticBandage", 5],
		["ACE_packingBandage", 5],
		["ACE_quikclot", 5],
		["ACE_epinephrine", 1],
		["ACE_morphine", 2],
		["ACE_splint", 1],
		["ACE_tourniquet", 1]	
	];
};

{
	_x params ["_item", "_count"];

	for "_i" from 1 to _count do {
		_unit addItem _item;
	};
} forEach _itemsToAdd;