#include "..\defines_mission.inc"

private _objects = getMissionLayerEntities "Airstrip Lights" select 0;
private _pos = _objects apply {[getPosATL _x select 0, getPosATL _x select 1, 0]};
_objects apply {deleteVehicle _x};

airstripLights = [];
_pos apply {
    private _light = "#lightpoint" createVehicleLocal _x;
    _light setLightColor [1,1,1];
    _light setLightAmbient [1,1,1];
    _light setLightUseFlare true;
    _light setLightFlareSize 3;
    _light setLightFlareMaxDistance 500;
    _light setLightIntensity 50;

    airstripLights pushBack _light;
};