if (place_meeting(x, y, obj_enemyPlane)) {
    instance_place(x, y, obj_enemyPlane).HP -= damage
	instance_destroy()
}

if (lifetime > 0) {
    lifetime--
}
else {
    instance_destroy()
}

image_angle = direction