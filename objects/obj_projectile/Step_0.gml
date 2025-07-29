if (place_meeting(x, y, [obj_flyingObject, obj_destructible])) {
	
	var target = instance_place(x, y, [obj_flyingObject, obj_destructible])
	var targetSprite = target.sprite_index
	target.sprite_index = target.internalSprite
	
	if (place_meeting(x - speed * dcos(direction), y - speed * -dsin(direction), [obj_flyingObject, obj_destructible])) {
		show_debug_message("critical hit")
		target.sprite_index = targetSprite
	}
	else {
		target.sprite_index = targetSprite
		var point = findCollisionPoint(self, target)
		takeDamage(target, point.x + sprite_width * dcos(image_angle), point.y + sprite_width * -dsin(image_angle), damage)
	}

	instance_destroy()
}

if (duration > 0) {
    duration--
}
else {
    instance_destroy()
}

image_angle = direction