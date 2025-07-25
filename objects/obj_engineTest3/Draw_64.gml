draw_text(0, 0, "RPM " + string(RPM * 60 / (2 * pi)))
draw_text(0, 15, "V0 " + string(V0))
draw_text(0, 30, "V3 " + string(V3))
draw_text(0, 45, "P3 " + string(P3))
draw_text(0, 60, "CPR " + string(P3 / P0))
draw_text(0, 75, "CTR " + string(T3 / T0))

for (var i = 0; i < array_length(attackAngles); ++i) {
	draw_set_color(c_white)
	draw_arrow(384, 256 + 20 * i, 384 + 50 * dcos(compressor.incidence), 265  + 20 * i - 50 * dsin(compressor.incidence), 10)
	draw_set_color(c_blue)
	draw_arrow(384, 256 + 20 * i, 384 + 50 * dcos(attackAngles[i]), 265 + 20 * i - 50 * dsin(attackAngles[i]), 10)
	draw_set_color(c_white)
	draw_text(384 + 50 * dcos(attackAngles[i]), 265 + 20 * i - 50 * dsin(attackAngles[i]), string(attackAngles[i]) + " " + string(airVelocities[i]))
}

multigraph_full(arr.attackAngles, 
			graphX, graphY, graphW, graphH, 5, c_black, 
			[c_red, c_orange, c_yellow, c_green],
			["0", "1", "2", "3", "4"])