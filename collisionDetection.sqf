_vehicle = _this select 0;
_vehiclePos = _this select 1; //position comes in as AGL or ATL
_vehDir = _this select 2;
_d = 7;
_h = 2; //meters above position seems to avoid most low-level ground detections that we don't care about (sidewalks with high hit boxes)
_checkPos = [[_d*sin(_vehDir),_d*cos(_vehDir),0],
	[_d*cos(_vehDir),_d*sin(_vehDir),0],
	[-1*_d*sin(_vehDir),-1*_d*cos(_vehDir),0],
	[-1*_d*cos(_vehDir),-1*_d*sin(_vehDir),0]];

_cnt_i = 0;

//hint format["obj count: %1",_objs];
{
	_pos = (ATLToASL _vehiclePos) vectorAdd [0,0,_h];
	_relPos = ATLToASL (_pos vectorAdd _x);
	//hint format["%1 -----> %2",_pos,_relPos];
	_intersects = lineIntersectsSurfaces [_pos,_relPos,objNull,objNull]; //REQUIRES ASL POSITIONS
	if (!(_intersects isEqualTo [])) then {
		_cnt_i = _cnt_i + 1;
	};
} forEach _checkPos;
//hint format["count: %1",_cnt];
_cnt_i