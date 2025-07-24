multigraph_full([arr.throttle, arr.RPM, arr.thrust, arr.turbineWork, arr.compressorWork], 
			graphX, graphY, graphW, graphH, 5, c_black, 
			[c_white, c_blue, c_red, c_purple, c_white - c_purple],
			["throttle", "RPM", "thrust", "turbine work", "compressor work"])
			
//draw_set_color(c_white)
//var keys = []
//keys = ds_map_keys_to_array(T, keys)
//var tempArr = []
//for (var i = 0; i < array_length(keys); ++i) {
//	array_push(tempArr, T[? keys[i]])
//}
//var tempArr = [T[?0], T[?2], T[?3], T[?4], T[?5], T[?8]]
//tempGraph(tempArr, graphX, graphY, graphW, graphH, 5, [c_blue, c_purple, c_red, c_orange, c_yellow])

draw_text(0, 0, "throttle " + string(throttle))
draw_text(0, 15, "RPM " + string(RPM))
draw_text(0, 30, "thrust " + string(thrust))
draw_text(0, 45, "Net Work " + string(turbine.workCreated - compressor.workRequired))