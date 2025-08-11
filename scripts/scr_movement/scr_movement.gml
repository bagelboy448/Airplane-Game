function movement_directionRotate(_objectID, _mode, _dir) {
    with (_objectID) {
	    if (!variable_instance_exists(self, "pointing"))
		    pointing = new Vector2()
			
		var pointDir = pointing.direction()
		var magnitude = pointing.magnitude()
		pointDir += _dir
		pointing.x = dcos(pointDir)
		pointing.y = -dsin(pointDir)
	}
}

function movement_flightModes(_objectID, _mode, _smoothing = true) {
    with (_objectID) {
		if (!variable_instance_exists(self, "pointing"))
		    pointing = new Vector2()
		if (!variable_instance_exists(self, "position"))
		    position = new Vector2(x, y)
		if (!variable_instance_exists(self, "velocity"))
		    velocity = new Vector2()
		if (!variable_instance_exists(self, "acceleration"))
		    acceleration = new Vector2()
			
	    switch (_mode) {
		    case "jet":
				
				var pointDir = pointing.direction()
				var crossZ = dcos(pointDir) * dsin(image_angle) - dcos(image_angle) * dsin(pointDir)
				
				if (_smoothing) {
				    if (abs(angle_difference(pointDir, image_angle)) > 90)
					    image_angle -= turnRate * sign(crossZ)
					else
						image_angle -= turnRate * crossZ
				}
				else {
				    if (abs(angle_difference(pointDir, image_angle)) > turnRate)
						image_angle -= turnRate * sign(crossZ)
					else
						image_angle = pointDir
				}
				
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
				break
			default: break
		}
	}
}