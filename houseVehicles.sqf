_obj = _this select 0; //fence object

_vehicleTypes = ["C_Truck_02_covered_F","C_Offroad_01_F"];
_vehicle = selectRandom _vehicleTypes;

_road = [getPosATL _obj, 50] call BIS_fnc_nearestRoad;
_shiftDir = _obj getDir _road;
_roadDist = _obj distance _road;

_roadConnectedTo = roadsConnectedTo _road;
_connectedRoad = _roadConnectedTo select 0;
_vehDir = (_shiftDir+90);

_vehiclePos = _obj getRelPos[20, _shiftDir+random[-5,0,5]];

_vehiclePos = [_vehiclePos select 0, _vehiclePos select 1, 0];

[_vehicle,_vehiclePos,_vehDir,true]