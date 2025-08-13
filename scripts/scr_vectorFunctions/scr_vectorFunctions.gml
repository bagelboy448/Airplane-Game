function Vector2(_x = 0, _y = 0) constructor {
    x = _x
	y = _y
	
	zero = function() {
	    x = 0
	    y = 0
	}
	
	magnitude = function() {
	    return sqrt(x * x + y * y)
	}
	
	direction = function() {
	    return point_direction(0, 0, x, y)
	}
	
	add = function(_vec2) {
	    x += _vec2.x
	    y += _vec2.y
	}
	
	subtract = function(_vec2) {
		x -= _vec2.x
	    y -= _vec2.y		
	}
	
	rotate = function(_angle) {
	    var length = magnitude()
		if (length) {
		    var dir = point_direction(0, 0, x, y)
			dir += _angle
			x = length * dcos(dir)
			y = length * -dsin(dir)
		}
	}
	
	dotProduct = function(_vec2) {
	    return x * _vec2.x + y * _vec2.y
	}
	
	toString = function() {
	    return "<" + string(x) + " " + string(y) + ">"
	}
}

function Vector3(_x = 0, _y = 0, _z = 0) constructor {
    x = _x
	y = _y
	z = _z
}