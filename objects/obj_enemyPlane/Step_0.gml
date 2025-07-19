//var crossZ = dcos(direction) * dsin(aimDir) - dsin(direction) * dcos(aimDir)

if (instance_exists(obj_playerPlane)) {
    aimDir = point_direction(x, y, obj_playerPlane.x, obj_playerPlane.y)
	if (speed < obj_playerPlane.speed + 3 && throttle < 100) {
		throttle++
	}
	else if (throttle > 0) {
		throttle--
	}
}


#region turning

var dotProduct = dcos(direction) * dcos(aimDir) + dsin(direction) * dsin(aimDir)

if (dotProduct + aimTolerance < 1) {
	
	var upper = ceil(speed)
	var lower = floor(speed)
	var percentage = speed - lower
	turnRate = maxTurnRate * lerp(turnRateCurve[lower], turnRateCurve[upper], percentage)
	
	var crossZ = dcos(direction) * dsin(aimDir) - dsin(direction) * dcos(aimDir)
	if (crossZ < 0) {
	    direction -= turnRate
	}
	else 
		direction += turnRate
	
	turning = true
	
}

image_angle = direction

#endregion

#region acceleration

thrust = maxThrust * thrustCurve[throttle]
drag = dragCoefficient * speed * speed

if (turning) {
    turnSlowdown += dragCoefficient
	turnSlowdown = clamp(turnSlowdown, 0, drag)
    drag += turnSlowdown
	turning = false
}
else if (turnSlowdown > 0)
	turnSlowdown = 0
	
acceleration = thrust - drag
speed += acceleration
if (speed < 0) speed = 0

#endregion

