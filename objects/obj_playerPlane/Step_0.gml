image_angle = direction

if (HP <= 0) {
    instance_destroy()
}

var currentSpeed = speed
speed += thrustCurve[throttle]
speed -= drag * sqr(currentSpeed)

if (speed < 0) speed = 0

#region STALLING

if (speed <= stallSpeed) {
    stallCounter += delta_time / 1000000
}
else stallCounter = 0

if (stallCounter >= stallTime && !stalling) {
    stalling = true
	show_debug_message("STALL")
}

#endregion

