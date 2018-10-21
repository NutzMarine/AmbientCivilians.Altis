_obj = _this select 0; //fence object
_return = [nil,nil,nil,false];


_gateFlag = (str(_obj) find "gate") >= 0; //dont place in front of gates
_cliffFlag = (str(_obj) find "cliff") >= 0; //dont place at "cliff" objects (i.e. there are cliff_wall objects that are problematic)
_roadFlag = [getPosATL _obj, 20] call BIS_fnc_nearestRoad; //check if close to road
_roadFlag = isNil "_roadFlag";
_canalFlag = (str(_obj) find "canal") >= 0;
_wiredFlag = (str(_obj) find "wired") >= 0;
if (_gateFlag || _roadFlag || _cliffFlag || _canalFlag || _wiredFlag) then {
	_return = [nil,nil,nil,false];
} else {
	//hint "I made it here!";
	_vehicleTypes = ["C_Truck_02_covered_F",
	"C_Truck_02_transport_F",
	"C_Offroad_01_F",
	"C_Hatchback_01_F",
	"C_Hatchback_01_sport_F",
	"C_SUV_01_F",
	"C_Van_01_transport_F",
	"C_Van_01_box_F"];
	_vehicle = selectRandom _vehicleTypes;

	_road = [getPosATL _obj, 50] call BIS_fnc_nearestRoad;
	_roadConnectedTo = roadsConnectedTo _road;
	_connectedRoad = _roadConnectedTo select 0;
	_vehDir = direction _obj + 90;
	_shiftDir = _vehDir + 90;

	_vehiclePos = _obj getRelPos[3, _shiftDir];

	_vehiclePos = [_vehiclePos select 0, _vehiclePos select 1, 0];

	_nearbyVehicles = nearestObjects[_vehiclePos,["Car","Truck"],15];
	_nearbyObjects = nearestObjects[_vehiclePos,[],2]; // if this is too high, i.e. 4, then cant spawn anything near fences!
	_nearbyPosts = (str nearestObjects[_vehiclePos,[],5]) find "lampstreet";
	_onRoadFlag = isOnRoad _vehiclePos;
	if (count _nearbyObjects == 0 && count _nearbyVehicles == 0 && _nearbyPosts == -1 && !_onRoadFlag) then {
		_return = [_vehicle,_vehiclePos,_vehDir,true];
	};
};
_return