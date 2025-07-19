//var crossZ = dcos(direction) * dsin(aimDir) - dsin(direction) * dcos(aimDir)

//if (instance_exists(global.player)) {
//    aimDir = point_direction(x, y, global.player.x, global.player.y) // track player
//	if (speed < global.player.speed + 3 && throttle < 100) { // throttle up to faster than the player
//		throttle++
//	}
//	else if (throttle > 0) {
//		throttle--
//	}
//}

#region AI behavior

if (target != noone && instance_exists(target)) {
    switch (behavior) {
	    case "chaser":
			aimDir = point_direction(x, y, target.x, target.y)
			if (speed < target.speed && point_distance(x, y, target.x, target.y) > 1.1 * chaseDistance && throttle < 100) {
				throttle ++
			}
			else if (speed > target.speed && throttle > 0 && point_distance(x, y, target.x, target.y) < 0.9 * chaseDistance) {
				throttle -= 0.2
			}
	        break
			
		case "flanker":
			var px = chaseDistance * dcos(target.direction + 135) + target.x
			var py = chaseDistance * -dsin(target.direction + 135) + target.y
			var pointDistance = point_distance(x, y, px, py)
			aimDir = point_direction(x, y, px, py)
			if (speed < target.speed + 2 && pointDistance > 1.1 * chaseDistance && throttle < 100) {
				throttle += 0.5 + clamp(chaseDistance / pointDistance, 0, 2)
			}
			else if (speed > target.speed && pointDistance < 0.9 * chaseDistance && throttle > 0) {
				throttle -= 0.5 + clamp(chaseDistance / pointDistance, 0, 2)
			}
	        break
			
	    default:
	        break
	}
}

#endregion


#region turning

var dotProduct = dcos(direction) * dcos(aimDir) + dsin(direction) * dsin(aimDir)

if (dotProduct + aimTolerance < 1) { // detect if player is in front of plane within a certain tolerance
	
	var upper = ceil(speed)
	var lower = floor(speed)
	var percentage = speed - lower
	turnRate = maxTurnRate * lerp(turnRateCurve[lower], turnRateCurve[upper], percentage)
	
	var crossZ = dcos(direction) * dsin(aimDir) - dsin(direction) * dcos(aimDir) // calculate turn direction
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

throttle = clamp(throttle, 0, array_length(thrustCurve) - 1)
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

