spriteRenderingSurface = surface_create(sprite_width, sprite_height)
spriteInternalSurface = surface_create(sprite_width, sprite_height)
surface_set_target(spriteInternalSurface)
draw_sprite(sprite_index, 1, 0, 0)
surface_reset_target()

destructibleSprite = image_index
image_speed = 0