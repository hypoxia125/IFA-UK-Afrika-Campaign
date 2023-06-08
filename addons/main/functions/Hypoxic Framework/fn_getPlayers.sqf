/*--------------------------------------------------------------------------------------------------
	Get Alive Players

	Usage: Returns alive players, no headless clients

	Parameters:
		NONE

	Return:
		Alive Players - Array of Players
--------------------------------------------------------------------------------------------------*/
params [
	["_alive", false, [true]]
];

private _players = (allUnits + allDead) select {isPlayer _x};
if (_alive) then {
	_players = allUnits select {isPlayer _x};
};

_players