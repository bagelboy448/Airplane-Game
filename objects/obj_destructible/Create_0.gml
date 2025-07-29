spriteRenderingSurface = surface_create(sprite_width, sprite_height)
spriteInternalSurface = surface_create(sprite_width, sprite_height)
surface_set_target(spriteInternalSurface)
draw_sprite(sprite_index, 1, 0, 0)
surface_reset_target()

destructibleSprite = sprite_index
internalSprite = spr_box_internal
image_speed = 0