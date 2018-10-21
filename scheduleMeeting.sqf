_host 		= _this select 0;
_attendee	= _this select 1;

//_pos = position _host;
//_building = nearestBuilding (position _host);
_buildings = nearestObjects [position _host, ["Land_Hotel_02_F"], 50];
_building = selectRandom _buildings; //find "Land_Hotel_02_F"
_allpositions = _building buildingPos -1;
_pos = selectRandom _allpositions;
//_pos = position _building;
_close=false;

_grp = group _attendee;
_host doMove _pos;
_wp = (_grp) addWaypoint [_pos, 0];
//_wp setWaypointCompletionRadius 10;
_wp setWaypointStatements ["true","_close = true"];

//hint "Heading towards meeting"; 
//when close, join host group
while {!_close} do {
	_meters = _attendee distance2D _pos;
	//hint format ["%1 meters",_meters];
	if (_meters < 100) then {_close = true;};
	sleep 1;
};
//hint "Meeting in progress";
[_attendee] joinSilent (group _host);

//hold meeting (wait some delay)
sleep 60;
//hint "Meeting completed";

//leave host group and rejoin original group
[_attendee] joinSilent _grp;