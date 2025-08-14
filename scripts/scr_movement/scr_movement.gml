function throttle_up(_objectID, _amount = 1) {
	with (_objectID) {
	    if (!variable_instance_exists(self, "throttle"))
			throttle = 0
		throttle += _amount
		throttle = min(throttle, 100)
	}
}

function throttle_down(_objectID, _amount = 1) {
	with (_objectID) {
	    if (!variable_instance_exists(self, "throttle"))
			throttle = 0
		throttle -= _amount
		throttle = max(throttle, 0)
	}
}

function throttle_adjust(_objectID, _amount) {
    with (_objectID) {
	    if (!variable_instance_exists(self, "throttle"))
			throttle = 0
		throttle += _amount
		throttle = clamp(throttle, 0, 100)
	}
}

function movement_rotate(_objectID, _dir) {
    with (_objectID) {
		 if (!variable_instance_exists(self, "pointing"))
		    pointing = new Vector2()
		var pointDir = pointing.direction()
		
		if (pointing.magnitude() == 0) {			
			pointing.x = dcos(_dir)
			pointing.y = -dsin(_dir)
		}
		else if (abs(angle_difference(pointDir, image_angle)) < maxTurnAngle) {
			pointing.rotate(_dir)
		}
	}
}

function movement_rotate_towards_point(_objectID, _x, _y, _smooth = true) {
    with (_objectID) {
		if (!variable_instance_exists(self, "pointing"))
			pointing = new Vector2()
		//var pointDir = pointing.direction()
		var aimDir = point_direction(x, y, _x, _y)
		//var crossZ = dcos(aimDir) * dsin(pointDir) - dcos(pointDir) * dsin(aimDir)
		//if (_smooth) {
		//    if (abs(angle_difference(aimDir, pointDir)) > 90)
		//		pointDir -= turnRate * sign(crossZ)
		//	else
		//		pointDir -= turnRate * crossZ
		//}
		//else {
		//    if (abs(angle_difference(aimDir, pointDir)) <= turnRate)
		//		pointDir = aimDir
		//	else
		//		pointDir -= turnRate * sign(crossZ)
		//}
		movement_rotate(self, aimDir)
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

function movement_flightModes(_objectID, _flightMode, _smooth = true) {
    with (_objectID) {
		if (!variable_instance_exists(self, "pointing"))
		    pointing = new Vector2()
		if (!variable_instance_exists(self, "position"))
		    position = new Vector2(x, y)
		if (!variable_instance_exists(self, "velocity"))
		    velocity = new Vector2()
		if (!variable_instance_exists(self, "acceleration"))
		    acceleration = new Vector2()
			
	    switch (_flightMode) {
		    case "jet":
				
				var pointDir = pointing.direction()
				var crossZ = dcos(pointDir) * dsin(image_angle) - dcos(image_angle) * dsin(pointDir)
				
				if (_smooth) {
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
				var vDir = velocity.direction()
				var vMag = velocity.magnitude()				
		
				acceleration.x += maxThrust * (throttle / 100) * dcos(image_angle) / mass
				acceleration.y += maxThrust * (throttle / 100) * -dsin(image_angle) / mass
				

				acceleration.x -= dragCoefficient * sqr(vMag) * dcos(vDir) / mass
				acceleration.y -= dragCoefficient * sqr(vMag) * -dsin(vDir) / mass
		
				velocity.add(acceleration)
				position.add(velocity)
		
				x = position.x
				y = position.y
				
				break
				
			case "hover":
				
				acceleration.zero()
				var vDir = velocity.direction()
				var vMag = velocity.magnitude()
				
				if (pointing.magnitude() != 0) {
				    var pointDir = pointing.direction()
					
					acceleration.x += maxThrustHover * (throttle / 100) * dcos(pointDir) / mass
					acceleration.y += maxThrustHover * (throttle / 100) * -dsin(pointDir) / mass
					
					acceleration.x -= dragCoefficient * sqr(vMag) * dcos(vDir) / mass
					acceleration.y -= dragCoefficient * sqr(vMag) * -dsin(vDir) / mass
				}
				else if (vMag > brakingForce) {
				    acceleration.x -= (dragCoefficient * sqr(vMag) + brakingForce) * dcos(vDir) / mass
					acceleration.y -= (dragCoefficient * sqr(vMag) + brakingForce) * -dsin(vDir) / mass
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
		}
	}
}

function movement_cleanup(_objectID) {
    with (_objectID) {
	    if (variable_instance_exists(self, "pointing"))
		    delete pointing
		if (variable_instance_exists(self, "position"))
		    delete position
		if (variable_instance_exists(self, "velocity"))
		    delete velocity
		if (variable_instance_exists(self, "acceleration"))
		    delete acceleration
	}
}

function movement_playerInput(_objectID, _flightMode) {
    with (_objectID) {
		if (!variable_instance_exists(self, "pointing"))
		    pointing = new Vector2()

	    switch (_flightMode) {
		    case "jet":
				
				if (pointing.magnitude() == 0) {
				    pointing.x = dcos(image_angle)
				    pointing.y = -dsin(image_angle)
				}
				
				if (abs(angle_difference(pointing.direction(), image_angle)) < maxTurnAngle) {
					var rotation = sign(keyboard_check(ord("A")) - keyboard_check(ord("D")))
					if (rotation != 0) {
					    pointing.rotate(turnRate * sign(rotation))
					}
				}
				
				break
				
			case "hover":
				
				var xInput = sign(keyboard_check(ord("D")) - keyboard_check(ord("A")))
				var yInput = sign(keyboard_check(ord("S")) - keyboard_check(ord("W")))
				
				pointing.x = xInput
				pointing.y = yInput
				
				break
				
			default: break
		}
	}
}

function movement_playerRotation(_objectID, _flightMode, _smooth = true) {
    with (_objectID) {
	    if (_flightMode == "hover") {
		    var mouseDir = point_direction(x, y, mouse_x, mouse_y)
			var crossZ = dcos(mouseDir) * dsin(image_angle) - dcos(image_angle) * dsin(mouseDir)
				
			if (_smooth) {
				if (abs(angle_difference(mouseDir, image_angle)) > 90)
					image_angle -= turnRate * sign(crossZ)
				else
					image_angle -= turnRate * crossZ
			}
			else {
				if (abs(angle_difference(pointDir, image_angle)) > turnRate)
					image_angle -= turnRate * sign(crossZ)
				else
					image_angle = mouseDir
			}
		}
	}
}

function movement_AI(_objectID, _target, _behavior, _params = {}) {
	with (_objectID) {
		
		switch (_behavior) {
		    case "chase":
				
				var targetDir = point_direction(x, y, _target.x, _target.y)
				var angleDif = angle_difference(targetDir, image_angle)
				movement_rotate(self, turnRate * sign(angleDif))
				
				var chaseSpeed = 3
				var speedDif = _target.velocity.magnitude() - velocity.magnitude() + chaseSpeed
				var sensitivity = 0.1
				throttle_adjust(self, speedDif * sensitivity)

				break
				
			case "followPoint":
				
				var sensitivity = 0.1
				
				var targetDir = point_direction(x, y, _params.x, _params.y)
				var angleDif = angle_difference(targetDir, pointing.direction())
				var crossZ = dcos(targetDir) * dsin(pointing.direction()) - dcos(pointing.direction()) * dsin(targetDir)
				if (abs(angleDif) > 90)
					movement_rotate(self, turnRate * -sign(crossZ))
				else
					movement_rotate(self, turnRate * -crossZ)
					
				var distance = point_distance(x, y, _params.x, _params.y)
				var interceptTime = 30
				var targetSpeed = distance/interceptTime
				throttle_adjust(self, (targetSpeed - velocity.magnitude()) * sensitivity)
								
				break
			
			default: break
		}
	}	
}