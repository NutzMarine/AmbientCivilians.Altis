_unit		= _this select 0;
_group		= _this select 1;

_range = 500;
_dir = 0;

_vehicleTypes = ["C_Truck_02_covered_F",
	"C_Truck_02_transport_F",
	"C_Offroad_01_F",
	"C_Hatchback_01_F",
	"C_Hatchback_01_sport_F",
	"C_SUV_01_F",
	"C_Van_01_transport_F",
	"C_Van_01_box_F"];

_center = position _unit;
_roads = _center nearRoads _range;
_maxSize	= round (count _roads / 10);
_count = 0;
_veh = nil;
while {true} do {
	if (_unit distance _center > _range/2) then {
		_center = position _unit;
		_roads = _center nearRoads _range;
		_maxSize	= round (count _roads / 10);
		//hint format["Center moved!\nCount: %1",_count];
	};
	if (_count < _maxSize) then {
		_road = selectRandom _roads;
		_pos = position _road;
		if (_road distance _unit > 50) then {
			if (count nearestObjects[_pos,["Car"],10] == 0) then {
				_roadConnectedTo = roadsConnectedTo _road;
				_connectedRoad = _roadConnectedTo select 0;
				if (!(isNil "_connectedRoad")) then {
					_dir = (_connectedRoad getDir _road) + selectRandom [0,180];
				} else {
					_dir = selectRandom[0,90,180,270];
				};
				_vehicle = selectRandom _vehicleTypes;
				_veh = createVehicle [_vehicle, _pos, [], 0, "NONE"];
				createVehicleCrew _veh;
				{
					[_x] joinSilent _group;
				} forEach units (group _veh);
				//hint format["Creating vehicle!\n%1\nCount: %2",_group, _count+1];
				_group setBehaviour "CARELESS";
				_group setSpeedMode "LIMITED";
				_drive = [_veh,_roads] spawn T_civDriving;
 				_cleanup = [_veh,_unit,_range,_drive] spawn {
					_veh = _this select 0;
					_srcUnit = _this select 1;
					_range = _this select 2;
					_thread = _this select 3;
					waitUntil {_veh distance _srcUnit > _range*1.2};
					terminate _thread;
					{_veh deleteVehicleCrew _x} forEach crew _veh;
					deleteVehicle _veh;
				}; 
			};
		};	
	};
	_count  = count (units _group);
	//hint format["Count: %1",_count];
};
