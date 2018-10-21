_unit		= _this select 0;
_srcUnit	= _this select 1;
_buildingTypes = _this select 2;
_range = 200;
_busy = false;
_task = "Wait";

doStop _unit;

/* [_unit,_srcUnit] spawn {
	_unit = _this select 0;
	_srcUnit = _this select 1;
	while {!(_unit isEqualTo objNull)} do {
		waitUntil {behaviour _unit == "COMBAT"};
		try {
			_busy = true;
			_unit call BIS_fnc_ambientAnim__terminate;
			waitUntil {behaviour _unit == "SAFE"};
			_busy = false;
		}
		catch { 
			//block, that process an exception. Exception is described in _exception variable
		};
	};
}; */

[_unit,_srcUnit,_range,_task] spawn {
	_unit = _this select 0;
	_srcUnit = _this select 1;
	_range = _this select 2;
	_task = _this select 3;
	waitUntil {_srcUnit distance _unit > _range*1.5};
	//hint format ["Count:  %1\nUnit Deleted",count (units group _unit)];
	//terminate _task;
	deleteVehicle _unit;
};

while {!(_unit isEqualTo objNull)} do {
	if (!_busy) then {
		if !(isNull objectParent _unit) then {
			_task = selectRandom["Drive"];
		} else {
			_task = selectRandom["Sit","Move","Wait"];
		};
		_busy = true;
	};
	
	if (isOnRoad _unit) then {_task = "Move"};
	
	switch (_task) do {
		case "Move": {
			_task = [_unit,_range,_buildingTypes] call T_civMove;
			_busy = false;
		};
		case "Sit": {
			_task = [_unit,_range] call T_civSit;
			_busy = false;
		};
		case "Wait": {
			if (isOnRoad _unit) then {
			
			} else {
				doStop _unit;
				sleep random [60,120,300];		
			};
			_busy = false;
		};
		case "GetInVehicle": {
			_vehicles = nearestObjects[_unit,["Car"],50];
			_veh = selectRandom _vehicles;
			if (!(isNil "_veh")) then {
				if (count crew _veh == 0 && str _veh != "PlayerVehicle") then {
					_unit assignAsDriver _veh;
					[_unit] orderGetIn true;
					waitUntil {!(isNull objectParent _unit)};				
				};

			};
			_busy = false;
		};
		
		case "Drive": {
			_dest = position (selectRandom nearestObjects[_unit,_buildingTypes,500]);
			_unit doMove _dest;
			waitUntil {_unit distance _dest < 20};
			_busy = false;
		};
	};
	
	//Get in a vehicle
	

};