var camX = camera_get_view_x(camera)
var camY = camera_get_view_y(camera)

var targetX = global.player.position.x - viewWidth/2
var targetY = global.player.position.y - viewHeight/2

//targetX = clamp(targetX, 0, room_width - viewWidth)
//targetY = clamp(targetY, 0, room_height - viewHeight)

camX = lerp(camX, targetX, smoothness)
camY = lerp(camY, targetY, smoothness)

camera_set_view_pos(camera, camX, camY)