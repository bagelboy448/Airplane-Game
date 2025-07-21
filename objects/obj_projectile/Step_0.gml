if (place_meeting(x, y, obj_enemyPlane)) {
    instance_place(x, y, obj_enemyPlane).HP -= damage + (speed * speed * damageSpeedMultiplier)
	instance_destroy()
}

if (duration > 0) {
    duration--
}
else {
    instance_destroy()
}

image_angle = direction