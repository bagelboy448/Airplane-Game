global.playerCamera.w = camera_get_view_width(view_camera[0])
global.playerCamera.h = camera_get_view_height(view_camera[0])

if (instance_exists(global.player)) {
	var target_x = global.player.x - global.playerCamera.w / 2
	var target_y = global.player.y - global.playerCamera.h / 2

	camera_set_view_pos(view_camera[0], target_x, target_y)
	
	global.playerCamera.viewX = global.player.x
	global.playerCamera.viewY = global.player.y
	
	global.playerCamera.origin = {
	    x: target_x - global.playerCamera.w / 2,
	    y: target_y - global.playerCamera.h / 2,
	}
}