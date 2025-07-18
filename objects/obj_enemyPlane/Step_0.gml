if (object_exists(obj_playerPlane)) {
	aimPoint = {
		x: obj_playerPlane.x,
		y: obj_playerPlane.y
	}
}

if (speed < maxSpeed) {
    speed += thrust
}

if (aimPoint != undefined) {
	var aimDir = point_direction(x, y, aimPoint.x, aimPoint.y)
	var crossZ = dcos(direction) * dsin(aimDir) - dsin(direction) * dcos(aimDir)

	if (crossZ - crossTolerance > 0) direction += turnForce
	else if (crossZ + crossTolerance < 0) direction -= turnForce
	else if (abs(direction - aimDir) < 180 + directionTolerance && abs(direction - aimDir) > 180 - directionTolerance) {
		if (irandom(1) == 1)
			direction += turnForce
		else
			direction -= turnForce
	}
}

event_inherited()