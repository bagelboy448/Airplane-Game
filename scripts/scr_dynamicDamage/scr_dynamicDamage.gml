function findCollisionPoint(_object, _target) {
	with (_object) {
	    static steps = 15
		var x0 = x - speed * dcos(direction)
		var y0 = y - speed * -dsin(direction)
		var x1 = x
		var y1 = y

		var cx = x1
		var cy = y1

		for (var i = 0; i < steps; i++) {
			var mx = (x0 + x1) * 0.5
			var my = (y0 + y1) * 0.5

			if (position_meeting(mx, my, _target)) {
				cx = mx
				cy = my
				x1 = mx
				y1 = my
			} 
			else {
				x0 = mx
				y0 = my
			}
		}
		return { x: cx, y:cy }
	}
}

function takeDamage(_objectID, _x, _y, _howMuch) {
    with (_objectID) {
	    var pointX = _x - x
	    var pointY = _y - y
		
		if (!surface_exists(spriteRenderingSurface)) {
		    spriteRenderingSurface = surface_create(sprite_width, sprite_height)
		}
		
		surface_set_target(spriteRenderingSurface)
		draw_sprite_ext(sprite_index, 0, 0, 0, 1, 1, image_angle, c_white, 1)

		gpu_set_blendmode(bm_subtract)
		draw_set_color(c_white)
		draw_circle(pointX, pointY, 3, false)
		gpu_set_blendmode(bm_normal)
		
		surface_reset_target()
		
		if (sprite_exists(destructibleSprite)) sprite_delete(destructibleSprite)
		destructibleSprite = sprite_create_from_surface(spriteRenderingSurface, 0, 0, 100, 100, false, false, 0, 0)
		sprite_collision_mask(destructibleSprite, false, 0, 0, 0, 100, 100, bboxkind_precise, 0)
		sprite_index = destructibleSprite
	}
}