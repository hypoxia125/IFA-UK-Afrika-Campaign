#include "..\defines_mission.inc"

private _objects = getMissionLayerEntities "Explosive Barrels" select 0;
_objects apply {
	_x addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];

		_this spawn {
			params ["_unit", "_killer", "_instigator", "_useEffects"];

			sleep random 3;
			private _bomb = createVehicle ["Bo_GBU12_LGB", getPosATL _unit, [], 0, "NONE"];
			_bomb hideObjectGlobal true;
			_bomb setDamage 1;

			_unit setVelocityModelSpace [random 10, random 10, random 50 max 30];
		};
	}];
};

{
	_x spawn {
		private _triggerArea = _this;

		private _objects = (entities "") select {_x inArea _triggerArea};
		while {TRIGGER_TICKRATE_DEFAULT; _objects findIf {alive _x} != -1} do {
			if (_objects findIf {!alive _x} != -1) then {
				{
					_x setDamage 1;
				} forEach _objects
			};
		};
	};
} forEach [trigger_tigerArea_01, trigger_tigerArea_02];