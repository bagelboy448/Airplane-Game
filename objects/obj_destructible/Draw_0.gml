if (!surface_exists(spriteRenderingSurface)) {
    spriteRenderingSurface = surface_create(sprite_width, sprite_height)
}
if (!surface_exists(spriteInternalSurface)) {
    spriteInternalSurface = surface_create(sprite_width, sprite_height)
	surface_set_target(spriteInternalSurface)
	draw_sprite(spr_box, 1, 0, 0)
	surface_reset_target()
}

surface_set_target(spriteRenderingSurface)
draw_sprite_ext(sprite_index, 0, 0, 0, 1, 1, image_angle, c_white, 1)

gpu_set_blendmode(bm_subtract)
draw_set_color(c_white)
draw_circle(mouse_x - x, mouse_y - y, 15, false)
gpu_set_blendmode(bm_normal)

surface_reset_target()
draw_surface(spriteInternalSurface, x, y)
draw_surface(spriteRenderingSurface, x, y)

if (sprite_exists(destructibleSprite)) sprite_delete(destructibleSprite)
destructibleSprite = sprite_create_from_surface(spriteRenderingSurface, 0, 0, 100, 100, false, false, 0, 0)
sprite_collision_mask(destructibleSprite, true, 0, 0, 0, 100, 100, 0, bboxkind_precise)
sprite_index = destructibleSprite