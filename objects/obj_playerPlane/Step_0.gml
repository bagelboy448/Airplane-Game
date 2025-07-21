var timerKeys = ds_map_keys_to_array(timers)
for (var i = 0; i < array_length(timerKeys); ++i) {
	if (timers[? timerKeys[i]].timer > 0) {
	    timers[? timerKeys[i]].timer--
	}
	else if (timers[? timerKeys[i]].timer != -1) {
		timers[? timerKeys[i]].timer = -1
	    timers[? timerKeys[i]].effect(self)
	}
}

throttle = clamp(throttle, 0, array_length(thrustCurve) - 1)

#region flight modes

switch (flightMode) {
    case "standard":
	default:
        
		thrust = maxThrust * thrustCurve[throttle]
		drag = dragCoefficient * sqr(speed)
		
		
		if (turning) {
			turnSlowdown += dragCoefficient
		    drag += turnSlowdown
			turning = false
		}
		else if (turnSlowdown > 0)
			turnSlowdown = 0

		acceleration = thrust - drag
		speed += acceleration
		if (speed < 0) speed = 0
		
		image_angle = direction
		
        break
		
	case "vtol":
		
		thrust = vtolMaxThrust * (throttle / 100)
		drag = dragCoefficient * sqr(speed)
		
		var xI = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")))
		var yI = (keyboard_check(vk_down)  || keyboard_check(ord("S"))) - (keyboard_check(vk_up)   || keyboard_check(ord("W")))
		var inputDirection = point_direction(0, 0, xI, yI)
		
		var accelerationVector = {
		    _x: thrust * dcos(inputDirection) * abs(xI),
		    _y: thrust * -dsin(inputDirection) * abs(yI)
		}
		
		acceleration = sqrt(sqr(accelerationVector._x) + sqr(accelerationVector._y)) - drag
		
		var speedVector = {
		    _x: speed * dcos(direction),
		    _y: speed * -dsin(direction)
		}
		
		speedVector._x += accelerationVector._x
		speedVector._y += accelerationVector._y
		
		speed = sqrt(sqr(speedVector._x) + sqr(speedVector._y)) - drag
		direction = point_direction(0, 0, speedVector._x, speedVector._y)
		if (speed < 0) speed = 0
		
		image_angle = point_direction(x, y, mouse_x, mouse_y)
		
		break

}

#endregion

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

// exactSpeed = speed
var upper = ceil(speed)
var lower = floor(speed)
var percentage = speed - lower
turnRate = maxTurnRate * lerp(turnRateCurve[lower], turnRateCurve[upper], percentage) // can potentially go out of range

#region weapons

for (var i = 0; i < array_length(weapons); ++i) {
	
	if (weapons[i].loading && weaponTimers[? weapons[i]].loadTimer > 0) {
	    weaponTimers[? weapons[i]].loadTimer--
	}
	else if (weapons[i].loading && weaponTimers[? weapons[i]].loadTimer == 0 && weapons[i].magazine < weapons[i].magazineCapacity) {
		weapons[i].magazine++
		weaponTimers[? weapons[i]].loadTimer = weapons[i].loadingDelay
		
		audio_play_sound(weapons[i].loadingSound, 0, false)
	}
	
	if (weaponTimers[? weapons[i]].fireTimer > 0) {
		weaponTimers[? weapons[i]].fireTimer--
	}
	else if (mouse_check_button(mb_left)) {
		weaponTimers[? weapons[i]].fireTimer = weapons[i].fireDelay

		instance_create_depth(x, y, depth - 1, weapons[i].projectile, {
			sprite_index: weapons[i].projectileSprite,
			speed: weapons[i].projectileSpeed + (speed * dcos(image_angle - direction)),
			direction: image_angle + (random(weapons[i].projectileSpread) * choose(1, -1)),
			image_angle: image_angle,
			damage: weapons[i].projectileDamage,
			damageSpeedMultiplier: weapons[i].damageSpeedMultiplier,
			duration: weapons[i].projectileDuration
		})
		
		if (weapons[i].loading) {
		    weapons[i].magazine--
			weaponTimers[? weapons[i]].loadTimer = weapons[i].loadingDelay
		}
		
		audio_play_sound(weapons[i].fireSound, 0, false)
	}
}

#endregion