#region flight modes

// flightModes = "jet", "hover"
switch (flightMode) {
    case "jet":
		
		var crossZ = dcos(pointDirection) * dsin(image_angle) - dcos(image_angle) * dsin(pointDirection)
		image_angle -= turnRate * crossZ
		
		acceleration.zero()
		
		acceleration.x += maxThrust * (throttle / 100) * dcos(image_angle) / mass
		acceleration.y += maxThrust * (throttle / 100) * -dsin(image_angle) / mass
		
		acceleration.x -= dragCoefficient * sqr(velocity.magnitude()) * dcos(velocity.direction()) / mass
		acceleration.y -= dragCoefficient * sqr(velocity.magnitude()) * -dsin(velocity.direction()) / mass
		
		velocity.add(acceleration)
		position.add(velocity)
		
		x = position.x
		y = position.y
		
		break
	
	case "hover":
	
		var mouseDir = point_direction(0, 0, mouse_x - x, mouse_y - y)
		var crossZ = dcos(mouseDir) * dsin(image_angle) - dcos(image_angle) * dsin(mouseDir)
		image_angle -= turnRate * crossZ
		
		var inputX = keyboard_check(ord("D")) - keyboard_check(ord("A"))
		var inputY = keyboard_check(ord("S")) - keyboard_check(ord("W"))
		
		acceleration.zero()
		
		if (inputX != 0 || inputY != 0) {
		    pointDirection = point_direction(0, 0, inputX, inputY)

			acceleration.x += maxThrustHover * (throttle / 100) * dcos(pointDirection) / mass
			acceleration.y += maxThrustHover * (throttle / 100) * -dsin(pointDirection) / mass
			
			acceleration.x -= dragCoefficient * sqr(velocity.magnitude()) * dcos(velocity.direction()) / mass
			acceleration.y -= dragCoefficient * sqr(velocity.magnitude()) * -dsin(velocity.direction()) / mass
		}
		else if (velocity.magnitude() > brakingForce) {
		    acceleration.x -= (dragCoefficient * sqr(velocity.magnitude()) + brakingForce) * dcos(velocity.direction()) / mass
			acceleration.y -= (dragCoefficient * sqr(velocity.magnitude()) + brakingForce) * -dsin(velocity.direction()) / mass
		}
		else {
			velocity.zero()
		}
		
		velocity.add(acceleration)
		position.add(velocity)
		
		x = position.x
		y = position.y
		
		break
		
	default: break
} // switch

#endregion

weapons_update(self, weapons[0])