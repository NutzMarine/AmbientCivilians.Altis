_pm		= _this select 0; //parking meter object
_return = [nil,nil,nil,false];

_vehicleTypes = ["C_Truck_02_covered_F",
	"C_Truck_02_transport_F",
	"C_Offroad_01_F",
	"C_Hatchback_01_F",
	"C_Hatchback_01_sport_F",
	"C_SUV_01_F",
	"C_Van_01_transport_F",
	"C_Van_01_box_F"];
_vehicle = selectRandom _vehicleTypes;

_road = [getPosATL _pm, 50] call BIS_fnc_nearestRoad;
_roadConnectedTo = roadsConnectedTo _road;
_connectedRoad = _roadConnectedTo select 0;
_vehDir = (_connectedRoad getDir _road);
_shiftDir = _vehDir + 90;

_vehiclePos = _pm getRelPos[3, _shiftDir];
_dist1 = _vehiclePos distance _road;
_vehiclePos2 = _pm getRelPos[3, _shiftDir+180];
_dist2 = _vehiclePos2 distance _road;

//Pick position that is closest to road
if (_dist2 < _dist1) then {
	_vehiclePos = _vehiclePos2;
	_vehDir = _vehDir + 180;
};

_vehiclePos = [_vehiclePos select 0, _vehiclePos select 1, 0];

_vehDir = _vehDir+180;

_nearbyVehicles = nearestObjects[_vehiclePos,["Car","Truck"],15];
_nearbyObjects = nearestObjects[_vehiclePos,[],2];
if (count _nearbyObjects == 0 && count _nearbyVehicles == 0) then {
	_return = [_vehicle,_vehiclePos,_vehDir,true];
};
_return