draw_text(0, 0, "throttle " + string(throttle))
draw_text(0, 15, "thrust " + string(thrust))
draw_text(0, 30, "V0 " + string(V0))
draw_text(0, 45, "compressor work " + string(-compressor.workRequired))
draw_text(0, 60, "turbine work " + string(turbine.workCreated))
draw_text(0, 75, "net work " + string(turbine.workCreated - compressor.workRequired))
draw_text(0, 90, "RPM " + string(mainShaft.RPM))
draw_text(0, 105, "MAF " + string(MAF))
draw_text(0, 120, "V8 " + string(V8))

// T 0, 2, 3, 4, 5, 8
var positionBump = 120
draw_text(0, positionBump + 15, "T0 " + string(T0))
draw_text(0, positionBump + 30, "T2 " + string(T2))
draw_text(0, positionBump + 45, "T3 " + string(T3))
draw_text(0, positionBump + 60, "T4 " + string(T4))
draw_text(0, positionBump + 75, "T5 " + string(T5))
draw_text(0, positionBump + 90, "T8 " + string(T8))