function movement_rotate(_objectID, _dir) {
    with (_objectID) {
		 if (!variable_instance_exists(self, "pointing"))
		    pointing = new Vector2()
		var pointDir = pointing.direction()
		
		if (abs(angle_difference(pointDir, image_angle)) < maxTurnAngle) {
			pointDir += _dir
			pointing.x = dcos(pointDir)
			pointing.y = -dsin(pointDir)
		}
	}
}

function movement_setDirection(_objectID, _dir) {
	with (_objectID) {
		 if (!variable_instance_exists(self, "pointing"))
		    pointing = new Vector2()
			
		pointing.x = dcos(_dir)
		pointing.y = -dsin(_dir)
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

function movement_AI(_objectID, _target) {
	with (_objectID) {
		var targetDir = point_direction(x, y, _target.x, _target.y)
		var angleDif = angle_difference(targetDir, image_angle)
		
		if (abs(angleDif) > 90) throttle = max(--throttle, 0)
		else if (abs(angleDif) < maxTurnAngle) throttle = min(++throttle, 100)
		
		movement_rotate(self, turnRate * sign(angleDif))
	}	
}