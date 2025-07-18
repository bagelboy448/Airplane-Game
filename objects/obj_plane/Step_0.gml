image_angle = direction

if (speed > maxSpeed) {
    speed -= drag * speed / (maxSpeed * maxSpeed)
}

if (HP <= 0) {
    instance_destroy()
}