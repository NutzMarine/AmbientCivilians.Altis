_unit		= _this select 0;
_roads 		= _this select 1;
_busy = false;
_task = "Wait";
_dest = position (selectRandom _roads);
//_vehicle = vehicle _unit;

doStop _unit;



while {!(_unit isEqualTo objNull)} do {
	if (!_busy) then {
		_task = selectRandom["Drive"];
		_busy = true;
	};
	
	switch (_task) do {		
		case "Drive": {
			_dest = position (selectRandom _roads);
			_unit doMove _dest;
			
			_honk = [_unit,_dest] spawn {
				_unit = _this select 0;
				_dest = _this select 1;
				while {true} do {
					waitUntil{count nearestObjects[_unit getRelPos[5,0],["Man","Car"],3] > 0};
					doStop _unit;
					if (selectRandom[0,0,0,1] == 1) then {
						driver _unit forceWeaponFire [currentWeapon _unit ,currentWeapon _unit ];
					};
					sleep 3;
					_unit setBehaviour "SAFE";
					_unit setSpeedMode "LIMITED";
					_unit doMove _dest;
					sleep 5;
				};
			};
			
			waitUntil {_unit distance _dest < 20};
			terminate _honk;
			doStop _unit;
			_busy = false;
		};
	};
	
	//Get in a vehicle
	

};