draw_self()

draw_text(x, y - 35, behavior)

draw_text(x, y + 15, "distance " + string(point_distance(x, y, target.x, target.y)))
draw_text(x, y + 30, "throttle " + string(throttle))
draw_text(x, y + 45, "speed " + string(speed))

if (behavior == "flanker") {
	var px = chaseDistance * dcos(target.direction + 135) + target.x
	var py = chaseDistance * -dsin(target.direction + 135) + target.y
	draw_circle(px, py, 5, false)
	draw_line(x, y, px, py)
	draw_text((x + px) / 2, (y + py) / 2 + 15, string(point_distance(x, y, px, py)))
}