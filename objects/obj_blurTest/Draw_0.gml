if (keyboard_check_pressed(vk_up)) blurriness++
if (keyboard_check_pressed(vk_down)) blurriness = max(1, --blurriness)

var spr = sprite_index

var tempSurface = surface_create(sprite_get_width(spr), sprite_get_height(spr))
surface_set_target(tempSurface)
draw_clear(c_black)

shader_set(shd_blur_h)
var u_tex_size = shader_get_uniform(shd_blur_h, "textureSize")
shader_set_uniform_f(u_tex_size, sprite_get_width(spr), sprite_get_height(spr))
var u_kernel_size = shader_get_uniform(shd_blur_h, "blurRadius")
shader_set_uniform_f(u_kernel_size, blurriness)
draw_sprite(spr, 0, 0, 0)
shader_reset()

surface_reset_target()

shader_set(shd_blur_v)
u_tex_size = shader_get_uniform(shd_blur_v, "textureSize")
shader_set_uniform_f(u_tex_size, sprite_get_width(spr), sprite_get_height(spr))
u_kernel_size = shader_get_uniform(shd_blur_v, "blurRadius")
shader_set_uniform_f(u_kernel_size, blurriness)
draw_surface(tempSurface, 0, 0)

surface_free(tempSurface)