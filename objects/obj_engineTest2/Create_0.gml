#region parameters

designRPM = 5200
RPM = 10
I = 10000

P = ds_map_create()
T = ds_map_create()

P[? 0] = 100000
T[? 0] = 288.15

V0 = 0
V8 = 0
thrust = 0

inlet = {
    efficiency: 1
}

compressor = {
	designEfficiency: 0.5,
	a: 0.3,
    stages: 8,
	stagePR: 1.5,
	maxCPR: power(1.5, 8), // power(stagePR, stages)
	n1: 1.8,
	workRequired: undefined,
	maxMAF: 300,
	n2: 1.3,
}

compressor.efficiency = function(_rpm) {
    return 1 - compressor.a * power((_rpm / designRPM / compressor.designEfficiency) - 1, 2)
}

compressor.CPR = function(_rpm) {
	    return compressor.maxCPR * power(_rpm/designRPM, compressor.n1)
}

compressor.MAF = function(_rpm) {
		return compressor.maxMAF * power(_rpm/designRPM, compressor.n2)
}

burner = {
    efficiency: 1
}

turbine = {
    efficiency: 1,
	designTPR: 0.5,
	n: 1,
	workCreated: undefined
}

turbine.TPR = function(_rpm) {
    return power(turbine.designTPR, (_rpm/designRPM) * turbine.n)
}

nozzle = {
    efficiency: 1,
	NPR: undefined
}

gamma = 1.4
gammaP = (gamma - 1) / gamma

throttle = 0
maxFuelFlow = 10
fuelFlow = 0
fuelHeatingValue = 40000000

#endregion

#region graphs

arr = {}
arr.dataPoints = 600
graphW = 512
graphH = 512
graphX = 640
graphY = 128
cushion = 5

arr.thrust = []
arr.RPM = []
arr.throttle = []
arr.turbineWork = []
arr.compressorWork = []

#endregion