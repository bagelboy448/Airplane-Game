if (place_meeting(x, y, [obj_flyingObject, obj_destructible])) {
	var target = instance_place(x, y, [obj_flyingObject, obj_destructible])
	var point = findCollisionPoint(self, target)

	takeDamage(target, point.x + sprite_width * dcos(image_angle), point.y + sprite_width * -dsin(image_angle), damage)
	instance_destroy()
}

if (duration > 0) {
    duration--
}
else {
    instance_destroy()
}

image_angle = direction