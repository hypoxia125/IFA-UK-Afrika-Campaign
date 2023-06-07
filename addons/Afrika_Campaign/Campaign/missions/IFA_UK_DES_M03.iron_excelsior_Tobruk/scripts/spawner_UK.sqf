#include "..\defines_mission.inc"

private _position = [8099.18,897.725,0];
private _dir = 273.287;

private _classes = [
	"LIB_UK_DR_Sergeant", 
	"LIB_UK_DR_Corporal", 
	"LIB_UK_DR_Medic", 
	"LIB_UK_DR_AT_Soldier", 
	"LIB_UK_DR_LanceCorporal", 
	"LIB_UK_DR_Rifleman", 
	"LIB_UK_DR_Engineer", 
	"LIB_UK_DR_Radioman"
];

private _waypoints = [
	[[7719.13,1103.01], "MOVE"],
	[[7441.82,1185.26], "MOVE"],
	[[7221.48,1349.13], "MOVE"],
	[[6887.61,1384.72], "MOVE"],
	[[6606.52,1466.35], "MOVE"],
	[[6308.24,1624.08], "MOVE"],
	[[6103.25,1813.11], "MOVE"],
	[[5965.77,2037.74], "MOVE"],
	[[6214.95,2367.32], "MOVE"],
	[[6435.9,2630.62], "MOVE"],
	[[6675.25,2799.4], "MOVE"],
	[[6862.45,2989.04], "MOVE"],
	[[6793.09,3245.59], "MOVE"],
	[[6853.85,3507.04], "GETOUT"],
	[[7159.29,3642.66], "SAD"],
	[[7133.7,3502.22], "SAD"],
	[[7329.03,3196.19], "SAD"],
	[[7104.06,2672.97], "SAD"],
	[[5959.35,2222.05], "MOVE"]
];

while {missionNamespace getVariable [MISSION + "spawner_UK", true]} do {
	private _veh = createVehicle ["LIB_UK_DR_M3_Halftrack", _position, [], 0, "NONE"];
	_veh setDir _dir;

	private _group = createGroup [PLAYER_SIDE, true];
	{

		private _unit = _group createUnit [_x, [0,0,0], [], 0, "NONE"];
		[_unit] joinSilent _group;
		if (leader _unit == _unit) then {_unit moveInCommander _veh} else {_unit moveInAny _veh};

		_unit addEventHandler ["Killed", {
			params ["_unit", "_killer", "_instigator", "_useEffects"];

			_unit spawn {
				sleep 300;
				deleteVehicle _this;
			};
		}];

		_unit setVariable ["lambs_danger_disableAI", true, true];
	} forEach _classes;

	// waypoints
	{
		_x params ["_pos", "_type"];
		private _wp = _group addWaypoint [_pos, 0];
		_wp setWaypointType _type;

		_wp setWaypointCompletionRadius 15;

		if (_forEachIndex == count _waypoints - 1) then {
			_wp setWaypointStatements [
				"true",
				toString {
					if (local this) then {
						deleteVehicle _this;
						{
							deleteVehicle _x;
						} forEach thisList;
					};
				}
			];
		};

		if (_forEachIndex == 13) then {
			_wp setWaypointStatements [
				"true",
				toString {
					if (local this) then {
						group this leaveVehicle vehicle this;
					};
				}
			];
		};
	} forEach _waypoints;

	sleep 300;
};