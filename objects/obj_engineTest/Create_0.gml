throttle = 0

P0 = 100000
T0 = 288.15
V0 = 1

gamma = 1.4
maxFuelFlowRate = 0.5
fuelHeatingValue = 43000000

inlet = {
    efficiency: 1,
	// add inlet spillage drag information later
	area: 0.6
}

compressor = {
	efficiency: function(_rpm) {
	    return -0.000001 * sqr(_rpm - 1000) + 1
	},
    stages: 8,
	stagePR: 1.5,
	CPR: function(_rpm) {
	    return power(1.5, 8) * sqrt(_rpm) / sqrt(1000)
	}, // power(stagePR, stages)
	workRequired: undefined
}

burner = {
    efficiency: 1
}

turbine = {
    efficiency: 1,
	TPR: 0.9,
	workCreated: undefined
}

nozzle = {
    efficiency: 1,
	NPR: undefined
}

mainShaft = {
    I: 100000,
	RPM: 0,
	slowingFactor: 0.01
}

gradientSurface = undefined
maskSurface = undefined

