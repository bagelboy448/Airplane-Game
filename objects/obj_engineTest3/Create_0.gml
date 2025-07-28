throttle = 0
maxFuelFlow = 1000
fuelFlow = maxFuelFlow * throttle / 100

designRPM = 5000

RPM = 0
V0 = 0.01
P0 = 101000
T0 = 288

P3 = P0
V3 = 0
T3 = T0

compressor = {
	stages: 4,
	incidence: 45,
	deltaI: -30/3,
    radius: 0.3,
	width: 0.1,
	CD: function(_a) {
	    return 0.00025 * _a * _a
	},
	CL: function(_a) {
	    if (_a <= 20) return max(0.055 * _a, 0.01)
		else return max(-0.22 * (_a - 20) + 1.1, 0.00)
	},
	efficiency: 1.0,
	workRequired: undefined
}

burner = {
    efficiency: 1.0
}

fuel = {
    energyValue: 30000000
}
fuel.efficiency = function(_AFR) {
    if (_AFR == 0) return 0
	else return max(1 - power(1.2, _AFR - 120) / 15, 0)
}

turbine = {
    efficiency: 1.0,
	workCreated: undefined
}

turbine.TPR = function(_RPM) {
    return max(1 - power(0.4, 3.5 * (_RPM/designRPM)), 0.01)
}

mainShaft = {
    I: 1000
}

attackAngles = []
airVelocities = []

graphW = 512
graphH = 256
graphX = 640
graphY = 128
cushion = 5

dataPoints = 180
arr = {}
arr.RPM = []
arr.attackAngles = [[], [], [], []]