RPM = 0
V0 = 0
P0 = 101000
T0 = 288

P3 = P0
V3 = 0
T3 = T0

compressor = {
	stages: 4,
	incidence: 45,
    radius: 0.3,
	width: 0.1,
	CD: function(_a) {
	    return 0.00025 * _a * _a
	},
	CL: function(_a) {
	    if (_a <= 20) return max(0.055 * _a, 0.01)
		else return max(-0.22 * (_a - 20) + 1.1, 0)
	}
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