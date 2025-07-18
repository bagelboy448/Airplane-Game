draw_self()

if (HP) {
	draw_set_color(c_green)
	var i = 0
	repeat (HP) {
	    draw_point(x + i, y - sprite_height/2)
		i++
	}
}
