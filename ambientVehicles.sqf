_unit		= _this select 0;
_range = 500;
_vehicleTypes = ["C_Truck_02_covered_F",
	"C_Truck_02_transport_F",
	"C_Offroad_01_F",
	"C_Hatchback_01_F",
	"C_Hatchback_01_sport_F",
	"C_SUV_01_F",
	"C_Van_01_transport_F",
	"C_Van_01_box_F"];

while{true} do {
	//find empty areas
	_pos = getPosATL _unit;
	//hint format["Current Position: %1",_pos];
	_nearestBuildings = nearestObjects [_unit,["Building"],_range];
	_limit = round (count _nearestBuildings/30);
	
	_cnt = count (nearestObjects[_pos, _vehicleTypes, _range]);
	if (_cnt < _limit) then {
		_list = nearestObjects[_pos,[], _range];
		_list = _list call BIS_fnc_arrayShuffle;
		{
			//hint "in the for loop!";
			_v = nil;
			//are there too many vehicle already nearby?
			//_cnt = count (nearestObjects[_pos, _vehicleTypes, _range]);
			//hint format ["count: %1",_cnt];
			if (_cnt < _limit) then {
				if ((_x distance _pos) > 50) then {
					_str = str(_x);
					if (_str find "parkingmeter" >= 0) then {
						 _v = [_x] call T_parkingMeterVehicles;
					};
					if (_str find "fence" >= 0 || _str find "wall" >= 0 || _str find "tyre_01_line" >= 0 || _str find "palmtotem" >= 0) then {
						 _v = [_x] call T_fenceVehicles;
					};
					if (!isNil "_v") then {
						if (_v select 3) then {
							_vehicle = _v select 0;
							_vehiclePos = _v select 1;
							_vehDir = _v select 2;
							
							//collision detection
							_intersects = [_vehicle,_vehiclePos,_vehDir] call T_collisionDetection;
							//hint format["intersects: %1",_intersects];
							if (_intersects == 0) then {
								_cnt = _cnt+1;
								//_veh = _vehicle createVehicle _vehiclePos;
								_veh = createVehicle [_vehicle, _vehiclePos, [], 0, "NONE"];
								_veh setVehicleLock "LOCKEDPLAYER";
								_veh setDir (_vehDir);
								_veh enableDynamicSimulation true;
								_veh allowDamage false;
								_null = [_veh] spawn 
								{
									sleep 5;
									_this select 0 allowDamage true;
								};
								//hint format["%1 vehicle created!\ncount %2\n%3",_str,_cnt,_vehiclePos];
								//sleep 1;						 
							 };
						};					
					};
				};
			};
		} forEach _list;
	};
};