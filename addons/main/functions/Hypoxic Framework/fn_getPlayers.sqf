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

private _players = allPlayers - entities "HeadlessClient_F";

if (_alive) exitWith {
	_players select { alive _x };
};

_players