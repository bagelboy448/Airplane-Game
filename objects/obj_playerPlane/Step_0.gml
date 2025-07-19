image_angle = direction

throttle = clamp(throttle, 0, array_length(thrustCurve) - 1)
thrust = maxThrust * thrustCurve[throttle]
drag = dragCoefficient * sqr(speed)

if (turning) {
	turnSlowdown += (1 + dragCoefficient) / 30
	turnSlowdown = clamp(turnSlowdown, 0, drag)
    drag += turnSlowdown
	turning = false
}
else if (turnSlowdown > 0)
	turnSlowdown = 0

acceleration = thrust - drag
speed += acceleration
if (speed < 0) speed = 0

#region STALLING

//if (speed <= stallSpeed) {
//    stallCounter += delta_time / 1000000
//}
//else stallCounter = 0

//if (stallCounter >= stallTime && !stalling) {
//    stalling = true
//	show_debug_message("STALL")
//}

#endregion

//var exactSpeed = speed
var upper = ceil(speed)
var lower = floor(speed)
var percentage = speed - lower
turnRate = maxTurnRate * lerp(turnRateCurve[lower], turnRateCurve[upper], percentage)