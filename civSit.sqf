_unit		= _this select 0;
_range 		= _this select 1;

_objTypes = [
	"Land_PicnicTable_01_F",
	"Land_Bench_01_F",
	"Land_Bench_02_F"];

//Find a bench and go sit
_pos = position _unit;
_nearestObjects = nearestObjects [_unit,[],_range];
_nearestObjects = _nearestObjects call BIS_fnc_arrayShuffle; 
_bench = nil;
_anim = "SIT";
_dir = 0;
_pos = [0,0,0];

{
	if (isNil "_bench") then {
		if (str _x find "bench_0" == 8) then {
			_bench = _x;
			_dir = direction _bench+180;
			_pos = _bench getRelPos [0.0, 180] vectorAdd [0,0,.6];
			//_anim = "SIT_HIGH";
		};
		if (str _x find "picnictable" == 8) then {
			_bench = _x;
			_dir = direction _bench + selectRandom [0,180];
			_pos = _bench getRelPos [1, selectRandom [0,180]];
			//_anim = "SIT_AT_TABLE";
		};
	};
} forEach _nearestObjects;

if (!(isNil "_bench")) then {
	//hint "Going to a bench!";
	_unit doMove position _bench;
	
	waitUntil {_unit distance _bench > 5};
	if (count nearestObjects[_pos,["Man"],1] > 0) then {
		_unit setPos _pos;
		_unit setDir _dir;
		[_unit, _anim, "FULL"] call BIS_fnc_ambientAnim;
		_unit spawn {
			waitUntil {behaviour _this == "combat"};
			_this call BIS_fnc_ambientAnim__terminate;
			
		};
		sleep random [60,120,300];
		_unit call BIS_fnc_ambientAnim__terminate;
	};
};






