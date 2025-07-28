global.Theaters = {
    ground: 0,
	airToGround: 300,
	airToAir: 3000,
	highAltitude: 12000,
	space: 20000
}

global.Theaters.check = function(_altitude) {
    if (_altitude < global.Theaters.airToGround) return "ground"
    else if (_altitude < global.Theaters.airToAir) return "airToGround"
    else if (_altitude < global.Theaters.highAltitude) return "airToAir"
    else if (_altitude < global.Theaters.space) return "highAltitude"
	else return "space"
}