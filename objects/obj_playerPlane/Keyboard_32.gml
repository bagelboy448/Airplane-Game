instance_create_depth(x, y, depth + 1, obj_projectile, {
	direction: direction + random(1) * (irandom(1) ? 1 : -1), 
	speed: speed + 2
	})