multigraph_full([arr.throttle, arr.RPM, arr.thrust], 
			graphX, graphY, graphW, graphH, 5, c_black, 
			[c_white, c_blue, c_red])
draw_set_color(c_white)

draw_text(0, 0, "throttle " + string(throttle))
draw_text(0, 15, "RPM " + string(RPM))
draw_text(0, 30, "thrust " + string(thrust))