if (!sprite_exists(sprite_index)) sprite_index = spr_box

if (!surface_exists(spriteRenderingSurface)) {
    spriteRenderingSurface = surface_create(sprite_width, sprite_height)
}
if (!surface_exists(spriteInternalSurface)) {
    spriteInternalSurface = surface_create(sprite_width, sprite_height)
	surface_set_target(spriteInternalSurface)
	draw_sprite(spr_box, 1, 0, 0)
	surface_reset_target()
}

draw_sprite_ext(internalSprite, 0, x, y, 1, 1, image_angle, c_white, 1)
draw_sprite_ext(sprite_index, 0, x, y, 1, 1, image_angle, c_white, 1)