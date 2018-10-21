_unit		= _this select 0;
_range 		= _this select 1;
_buildingTypes = _this select 2;

//Move somewhere
_pos = position _unit;
_nearestBuildings = nearestObjects [_unit,_buildingTypes,_range];
_building = selectRandom _nearestBuildings;
if (isNil "_building") then {
	//[center, minDist, maxDist, objDist, waterMode, maxGrad, shoreMode, blacklistPos, defaultPos]
	_pos = [_unit, 1, 300, 0, 0, 0, 0] call BIS_fnc_findSafePos;
} else {
	_pos = selectRandom (_building buildingPos -1);
};
_dist = 5;
if (isNil "_pos") then {
	_pos = [_unit, 1, 300, 0, 0, 0, 0] call BIS_fnc_findSafePos;
	_dist = 20;
};
if (_pos isEqualTo [0,0,0]) then {
	_pos = [_unit, 1, 300, 0, 0, 0, 0] call BIS_fnc_findSafePos;
	_dist = 20;
};
_unit doMove _pos;
while {position _unit distance _pos > _dist} do {
	sleep 1;
};
doStop _unit;
sleep random[10,20,30];
_return = true;
_return