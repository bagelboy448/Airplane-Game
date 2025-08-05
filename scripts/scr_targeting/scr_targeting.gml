function targeting_interceptTime(_attacker, _target, _weapon) {
	var attackerPosition = variable_clone(_attacker.position)
	var targetPosition = variable_clone(_target.position)
	targetPosition.subtract(attackerPosition)
	var distance = variable_clone(targetPosition)
	var projectileVelocity = _weapon.projectileSpeed + _attacker.velocity.magnitude() * dcos(_attacker.image_angle - _attacker.velocity.direction())
	
	var A = sqr(_target.velocity.magnitude()) - sqr(projectileVelocity)
	var B = 2 * distance.dotProduct(_target.velocity)
	var C = sqr(distance.magnitude())
	
	var determinant = B * B - 4 * A * C
	if (determinant < 0) return -1
	
	var t1 = (-B + sqrt(determinant)) / (2 * A)
	var t2 = (-B - sqrt(determinant)) / (2 * A)
	
	if (t1 > 0 && t2 > 0)
		return min(t1, t2)
	else if (t1 > 0)
		return t1
	else if (t2 > 0)
		return t2
	else
		return -1
}

function targeting_predictPosition(_attacker, _target, _weapon) {
    var t = targeting_interceptTime(_attacker, _target, _weapon)
	if (t >= 0) {
		var position = {
		    x: _target.position.x + _target.velocity.x * t,
		    y: _target.position.y + _target.velocity.y * t
		}
		return position
	}
	else
		return undefined
}