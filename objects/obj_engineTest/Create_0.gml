throttle = 0

P0 = 100000
T0 = 288.15
V0 = 0

gamma = 1.4
maxFuelFlowRate = 4
fuelHeatingValue = 10000

inlet = {
    efficiency: 1,
	// add inlet spillage drag information later
	area: 0.6
}

compressor = {
	efficiency: 1,
    stages: 8,
	stagePR: 1.5,
	CPR: power(1.5, 8), // power(stagePR, stages)
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
    I: 100,
	RPM: 0,
	slowingFactor: 0.0001
}

gradientSurface = undefined
maskSurface = undefined

