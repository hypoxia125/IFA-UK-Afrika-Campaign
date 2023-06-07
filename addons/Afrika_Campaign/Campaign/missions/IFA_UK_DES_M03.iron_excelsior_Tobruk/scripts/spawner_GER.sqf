#include "..\defines_mission.inc"

private _position = [5939.77,2184.69,0];
private _dir = 177.487;

private _classes = [
	"LIB_DAK_NCO", 
	"LIB_DAK_medic", 
	"LIB_DAK_Soldier_4", 
	"LIB_DAK_AT_soldier", 
	"LIB_DAK_Soldier_2", 
	"LIB_DAK_grenadier", 
	"LIB_DAK_radioman", 
	"LIB_DAK_Soldier"
];

private _waypoints = [
	[[5963.15,2042.19,0], "MOVE"],
	[[6137.53,1772.35,0], "MOVE"],
	[[6330.42,1608.57,0], "MOVE"],
	[[6591.39,1474.67,0], "MOVE"],
	[[6934.08,1373.22,0], "MOVE"],
	[[7321.25,1312.46,0], "MOVE"]
];

while {missionNamespace getVariable [MISSION + "spawner_UK", true]} do {
	private _players = [true] call HYP_fnc_getPlayers;
	if (_players findIf {_x distance _position <= 500} != -1) then {
		missionNamespace setVariable [MISSION + "spawner_UK", false];
		continue;
	};

	private _veh = createVehicle ["LIB_UK_DR_M3_Halftrack", _position, [], 0, "NONE"];
	_veh setDir _dir;

	private _group = createGroup [east, true];
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
	} forEach _waypoints;

	sleep 300;
};