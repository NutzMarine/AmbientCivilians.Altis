//PRECOMPILE
T_setGroupSide				= compileFinal preProcessFileLineNumbers "setGroupSide.sqf";
T_ambientVehicles			= compileFinal preProcessFileLineNumbers "ambientVehicles.sqf";
T_parkingMeterVehicles		= compileFinal preProcessFileLineNumbers "parkingMeterVehicles.sqf";
T_fenceVehicles				= compileFinal preProcessFileLineNumbers "fenceVehicles.sqf";
T_houseVehicles				= compileFinal preProcessFileLineNumbers "houseVehicles.sqf";
T_collisionDetection		= compileFinal preProcessFileLineNumbers "collisionDetection.sqf";
T_ambientCivilians			= compileFinal preProcessFileLineNumbers "ambientCivilians.sqf";
T_civBehavior				= compileFinal preProcessFileLineNumbers "civBehavior.sqf";
T_civMove					= compileFinal preProcessFileLineNumbers "civMove.sqf";
T_civSit					= compileFinal preProcessFileLineNumbers "civSit.sqf";
T_civBuildingSpawn			= compileFinal preProcessFileLineNumbers "civBuildingSpawn.sqf";
T_ambientDrivers			= compileFinal preProcessFileLineNumbers "ambientDrivers.sqf";
T_civDriving				= compileFinal preProcessFileLineNumbers "civDriving.sqf";

//INIT
_ambientVehicles = [player] spawn T_ambientVehicles;

_groupCivs = createGroup Civilian;
_ambientCivilians = [player, _groupCivs] spawn T_ambientCivilians;

_groupDrivers = createGroup [Civilian,false];
_ambientDrivers = [player, _groupDrivers] spawn T_ambientDrivers;