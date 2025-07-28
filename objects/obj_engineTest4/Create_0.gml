#macro k * 1000
#macro M * 1000000

RPM = 0

gamma = 1.4
gammaP = (gamma - 1)/gamma

V0 = 0
T0 = 300
P0 = 100 k

compressor = {
    heatEfficiency: 1.0,
	bladeEfficiency: 1.0,
	stages: 4,
	stagePR: 1.5,
	incidence: 45,
	deltaIncidence: -10,
	criticalAngle: 15,
	dragCoefficient: 0.1,
	radius: 0.5,
	swirl: 0.0, 
	axialV: 0.0
}