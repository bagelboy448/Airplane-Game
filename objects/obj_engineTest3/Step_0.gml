var airDensity = 1.225
var airV = V0
var airP = P0
var airT = T0
var RPMreduction = 0

for (var i = 0; i < compressor.stages; ++i) {

	airVelocities[i] = airV

	airDensity = airP/(287 * airT)

	var attackAngle = undefined
	if (RPM != 0) attackAngle = (compressor.incidence) - (180 / pi) * arctan(airV/(RPM * compressor.radius))
	else attackAngle = (compressor.incidence)
	attackAngles[i] = attackAngle
	
	var minDeltaP = 0.001 * airDensity * sqr(RPM * compressor.radius)
	var deltaP = minDeltaP + (0.5 * compressor.CL(attackAngle) * airDensity * sqr(RPM * compressor.radius))
	
	RPMreduction += 0.5 * airDensity * compressor.CD(attackAngle) * sqr(RPM * compressor.radius) * 0.0001
	
	airT *= power((airP + deltaP) / airP, (0.4 / 1.4))
	airP += deltaP
	
	if (i == 0 && V0 <= airV) V0 += (sqrt(sqr(airV) + (2 * deltaP / airDensity)) - V0) * 0.01
	airV *= 1.05 // rotor speed multiplier
	airP *= 1.1 // stator pressure multiplier
	//V0 = min(V0, 343)
		
	array_push(arr.attackAngles[i], attackAngles[i])
	if (array_length(arr.attackAngles[i]) > dataPoints) array_delete(arr.attackAngles[i], 0, 1)
	
}

var MAF = airDensity * airV
show_debug_message("MAF " + string(MAF))

RPM -= RPMreduction
RPM = max(RPM, 0)

V3 = airV
P3 = airP
T3 = airT

fuelFlow = maxFuelFlow * throttle / 100
var FAR = fuelFlow/MAF
T4 = T3 * (1 + (FAR * fuel.efficiency(1/FAR) * fuel.energyValue / (1.005 * T3))) / (1 + FAR)

show_debug_message("AFR " + string(1/FAR))