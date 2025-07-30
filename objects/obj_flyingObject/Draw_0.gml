draw_self()

var localX = turret.x - sprite_xoffset
var localY = turret.y - sprite_yoffset

var rotatedX = x + localX * dcos(image_angle) - localY * -dsin(image_angle)
var rotatedY = y + localX * -dsin(image_angle) + localY * dcos(image_angle)

var turretDirection = point_direction(rotatedX, rotatedY, global.player.position.x, global.player.position.y)



if (!sprite_exists(sprite_index)) sprite_index = spr_planeTest

if (!surface_exists(spriteRenderingSurface)) {
    spriteRenderingSurface = surface_create(sprite_width, sprite_height)
}
if (!surface_exists(spriteInternalSurface)) {
    spriteInternalSurface = surface_create(sprite_width, sprite_height)
	surface_set_target(spriteInternalSurface)
	draw_sprite(spr_planeTest, 1, 0, 0)
	surface_reset_target()
}

draw_sprite_ext(internalSprite, 0, x, y, 1, 1, image_angle, c_white, 1)
draw_sprite_ext(sprite_index, 0, x, y, 1, 1, image_angle, c_white, 1)
draw_sprite_ext(turret.sprite, 0, rotatedX, rotatedY, 1, 1, turretDirection, c_white, 1)


//if (altitude != global.player.position.z) {
    
//	var spr = sprite_index
//	var w = sprite_get_width(spr)
//	var h = sprite_get_height(spr)

//	var dz = altitude - global.player.position.z
//	var parallax_factor = max(1 + dz * 0.0005, 0)
//	var draw_x = x - (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2 - x) * dz * 0.0001
//	var draw_y = y - (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2 - y) * dz * 0.0001
	
//	if (altitude < global.player.position.z) {
//		depth = 1
//	    draw_sprite_ext(spr, 0, draw_x, draw_y, parallax_factor, parallax_factor, image_angle, c_white, 1)
//	}
//	else {
//		depth = -1
//		var blurriness = floor(parallax_factor)
//	    var tempSurface = surface_create(w, h)
//		surface_set_target(tempSurface)
//		draw_clear_alpha(c_black, 0)

//		shader_set(shd_blur_h)
//		shader_set_uniform_f(shader_get_uniform(shd_blur_h, "textureSize"), w, h)
//		shader_set_uniform_f(shader_get_uniform(shd_blur_h, "blurRadius"), blurriness)
//		draw_sprite(spr, 0, w/2, h/2)
//		shader_reset()

//		surface_reset_target()

//		shader_set(shd_blur_v)
//		shader_set_uniform_f(shader_get_uniform(shd_blur_v, "textureSize"), w, h)
//		shader_set_uniform_f(shader_get_uniform(shd_blur_v, "blurRadius"), blurriness)
//		draw_surface_ext(tempSurface, 
//			draw_x - w/2 * dcos(image_angle) - h/2 * dsin(image_angle), 
//			draw_y - h/2 * dcos(image_angle) + w/2 * dsin(image_angle),
//			parallax_factor, parallax_factor, image_angle, c_white, 1)
//		shader_reset()

//		surface_free(tempSurface)
//	}
	
//}
//else {
//    draw_self()
//}

////if (altitude > global.player.position.z + 1000) {
////	var blurriness = 1
////	var spr = sprite_index
////	var w = sprite_get_width(spr)
////	var h = sprite_get_height(spr)

////	var dz = altitude - global.player.position.z
////	var parallax_factor = 1 + dz * 0.05
////	var draw_x = x - (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2 - x) * dz * 0.01
////	var draw_y = y - (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2 - y) * dz * 0.01

////	var tempSurface = surface_create(w, h)
////	surface_set_target(tempSurface)
////	draw_clear_alpha(c_black, 0)

////	shader_set(shd_blur_h)
////	shader_set_uniform_f(shader_get_uniform(shd_blur_h, "textureSize"), w, h)
////	shader_set_uniform_f(shader_get_uniform(shd_blur_h, "blurRadius"), blurriness)
////	draw_sprite(spr, 0, w/2, h/2)
////	shader_reset()

////	surface_reset_target()

////	shader_set(shd_blur_v)
////	shader_set_uniform_f(shader_get_uniform(shd_blur_v, "textureSize"), w, h)
////	shader_set_uniform_f(shader_get_uniform(shd_blur_v, "blurRadius"), blurriness)
////	draw_surface_ext(tempSurface, 
////		draw_x - w/2 * dcos(image_angle) - h/2 * dsin(image_angle), 
////		draw_y - h/2 * dcos(image_angle) + w/2 * dsin(image_angle),
////		parallax_factor, parallax_factor, image_angle, c_white, 1)
////	shader_reset()

////	surface_free(tempSurface)
////}
////else {
////    draw_self()
////}