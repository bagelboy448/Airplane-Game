speed = 0
thrustCurve = global.squareRoot

global.player = self

mousePressY = mouse_y
middleMouseDown = false
currentThrottle = throttle

timers = ds_map_create()
timers[? "vtolTransitionTime"] = {
    timer: -1,
	effect: function(_id) {
	    if (_id.flightMode != "vtol") {
		    _id.flightMode = "vtol"
		}
		else {
		    _id.flightMode = "standard"
		}
	}
}