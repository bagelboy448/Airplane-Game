draw_text(0, 0, "throttle " + string(throttle))
draw_text(0, 15, "thrust " + string(thrustCurve[throttle]))
draw_text(0, 30, "drag " + string(drag * sqr(speed)))
draw_text(0, 45, "speed " + string(speed)) 