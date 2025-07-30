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
	    var w = sprite_width
		var h = sprite_height
		var offsetX = sprite_xoffset
		var offsetY = sprite_yoffset
		
		var pointX = _x - x + offsetX
	    var pointY = _y - y + offsetY
		

		if (!surface_exists(spriteRenderingSurface)) {
		    spriteRenderingSurface = surface_create(w, h)
		}
		
        var rotatedX = (pointX - offsetX) * dcos(image_angle) - (pointY - offsetY) * dsin(image_angle)
        var rotatedY = (pointX - offsetX) * dsin(image_angle) + (pointY - offsetY) * dcos(image_angle)
		
		surface_set_target(spriteRenderingSurface)
		draw_sprite_ext(sprite_index, 0, offsetX, offsetY, 1, 1, 0, c_white, 1)

		gpu_set_blendmode(bm_subtract)
		draw_set_color(c_white)
		draw_circle(rotatedX + offsetX, rotatedY + offsetY, 3, false)
		gpu_set_blendmode(bm_normal)
		
		surface_reset_target()
		
		if (sprite_exists(destructibleSprite)) sprite_delete(destructibleSprite)
		destructibleSprite = sprite_create_from_surface(spriteRenderingSurface, 0, 0, w, h, false, false, 0, 0)
		sprite_collision_mask(destructibleSprite, false, 0, 0, 0, w, h, bboxkind_precise, 1)
		sprite_set_offset(destructibleSprite, offsetX, offsetY)
		sprite_index = destructibleSprite
	}
}