_unit 		= _this select 0;
_groupName	= _this select 1;
_side 		= _this select 2;

_tmpGroup = createGroup _side;
{[_x] joinSilent _tmpGroup;} forEach units (group _unit);
_groupName = createGroup _side;
{[_x] joinSilent _groupName;} forEach units _tmpGroup;
deleteGroup _tmpGroup;

if (_side == East) then {
	{_x addMagazines ["16Rnd_9x21_Mag",2];} forEach units _groupName;
	{_x addWeapon "hgun_Rook40_F";} forEach units _groupName;
};

if (_side == Civilian) then {
	{removeAllWeapons _x} forEach units _groupName;
};
_return = group _unit;
_return