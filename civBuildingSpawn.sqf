_building = _this select 0;
_pos = _this select 1;

if (!(isNil "_building")) then {
	_pos = selectRandom (_building buildingPos -1);
};
if (isNil "_pos") then {
	_pos = [_unit, 50, _range, 0, 0, 0, 0] call BIS_fnc_findSafePos;
	if (isNil "_pos") then {
		_pos = _srcPos;
	};
};
if (_pos isEqualTo [0,0,0]) then {
	_pos = [_unit, 50, _range, 0, 0, 0, 0] call BIS_fnc_findSafePos;
};
//_placement = selectRandom [0,50,50,50];
_placement = 0;
_return = [_pos, _placement];
_return