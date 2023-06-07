params [
	["_trackList", [], []]
];

if !(hasInterface) exitWith {};
if (_trackList isEqualTo []) exitWith {};

if (_trackList isEqualType "") then {
	private _music = toString {
		true
	} configClasses (configFile >> "CfgMusic");
	_music = _music select {getText (_x >> "musicClass") == _trackList};
	_music = _music apply {configName _x};
	_trackList = _music;
};

HYP_jukebox_tracklist = _trackList;
addMusicEventHandler ["MusicStop", {
	params ["_musicClassname", "_eventHandlerId"];

	private ["_track"];
	for "_i" from 0 to 1000 do {
		_track = selectRandom HYP_jukebox_tracklist;
		if !(_track == _musicClassname) then {break};
	};

	playMusic _track;
}];

addMusicEventHandler ["MusicStart", {
	params ["_musicClassname", "_eventHandlerId"];

	[true, false] call HYP_fnc_disableACEVolumeUpdate;
	0 fadeMusic 0;
	[] spawn {
		3 fadeMusic 1;
		sleep 3;
		[false, false] call HYP_fnc_disableACEVolumeUpdate;
	};
}];

// play first song
playMusic selectRandom _trackList;