#include "..\defines_mission.inc"

// set up spectator
{
	missionNamespace setVariable [_x, true];
} forEach [
	"BIS_respSpecShowFocus",			// Show info about the selected unit (dissapears behind the respawn UI)
	"BIS_respSpecShowCameraButtons",	// Show buttons for switching between free camera, 1st and 3rd person view (partially overlayed by respawn UI)
	"BIS_respSpecShowControlsHelper",	// Show the controls tutorial box
	"BIS_respSpecShowHeader",			// Top bar of the spectator UI including mission time
	"BIS_respSpecLists"					// Show list of available units and locations on the left hand side
];