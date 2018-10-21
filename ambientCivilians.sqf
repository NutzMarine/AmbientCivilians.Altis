_unit		= _this select 0;
_group		= _this select 1;
_maxSize	= 100;
_range = 200;
_civTypes = [
	"C_man_p_beggar_F",
	"C_man_polo_1_F",
	"C_man_polo_2_F",
	"C_man_polo_3_F",
	"C_man_polo_4_F",
	"C_man_polo_5_F",
	"C_man_polo_6_F",
	"C_man_shorts_1_F",
	"C_man_1_1_F",
	"C_man_1_2_F",
	"C_man_1_3_F"];

_buildingTypes = ["House"];

	
_srcPos = position _unit;
_pos = _srcPos;
_nearestBuildings = nearestObjects [_unit,_buildingTypes,_range];
_maxSize = round (count _nearestBuildings)*2;
//_group = createGroup Civilian;
_tmpGroup = grpNull;
_leader = nil;
_placement = 0;

_group setBehaviour "SAFE";
_group setSpeedMode "LIMITED";

while {true} do {
	_size = count (units _group);
	_veh = nil;
	
	if (_srcPos distance _unit > _range/2) then {
		_srcPos = position _unit;
		_nearestBuildings = nearestObjects [_unit,_buildingTypes,_range];
		_maxSize = round (count _nearestBuildings)*2;
		_group setBehaviour "SAFE";
		_group setSpeedMode "LIMITED";
	};
	
	if (_size < _maxSize) then {
		_tmpGroup = createGroup Civilian;
		_civ = selectRandom _civTypes;
		
		
		_spawnType = selectRandom["Building"];
		switch (_spawnType) do {
			case "Building": {
				_building = selectRandom _nearestBuildings;
				_return = [_building,_pos] call T_civBuildingSpawn;
				_pos = _return select 0;
				_placement = _return select 1;
			};
			case "Object": {
			
			};
			case "Bench": {

			};
			case "Vehicle": {
				_vehicles = nearestObjects[_unit,["Car"],_range];
				_veh = selectRandom _vehicles;
				_pos = _veh getRelPos[2,-90];
			};
		};
		
		if (_size == 0 || isNil "_size") then {
			_civ = _civTypes select 0;
			_civ = _tmpGroup createUnit [_civ, _pos, [], _placement, "NONE"];
			_civ setRank "COLONEL";
			_group setBehaviour "SAFE";
			_group setSpeedMode "LIMITED";
		} else {
			_civ = _tmpGroup createUnit [_civ, _pos, [], _placement, "NONE"];
			removeAllWeapons _civ;
			removeVest _civ;
			_group setBehaviour "SAFE";
			_group setSpeedMode "LIMITED";
			//removeBackpack _civ;
		};
		[_civ] joinSilent _group;
		deleteGroup _tmpGroup;
		if (rank _civ == "COLONEL") then {
			_leader = _civ;
		};
		
		if (!(isNil "_veh")) then {
			_civ assignAsDriver _veh;
			[_civ] orderGetIn true;
		};
		_behavior = [_civ,_unit,_buildingTypes] spawn T_civBehavior;
	};
};