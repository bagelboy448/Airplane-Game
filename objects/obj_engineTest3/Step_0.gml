
if (V0 > 550) V0 = 550
//V0 = 5000 * compressor.radius * dtan(25)
//RPM = 5000

var airV = V0
var airP = P0
var airT = T0
var RPMreduction = 0
var airDensity = airP/(287 * airT)

for (var i = 0; i < compressor.stages; ++i) {

	airVelocities[i] = airV
	
	var Vo = airV
	var Po = airP
	
	var inflowAngle = (RPM == 0) ? pi/2 : arctan(Vo/(RPM * compressor.radius))
	var attackAngle = (compressor.incidence + compressor.deltaI * i) - inflowAngle * (180/pi) // attack angle is measured in degrees
	var lift = compressor.CL(attackAngle) * airDensity * sqr(RPM * compressor.radius) * 0.01 / 2
	var thrust = lift * cos(inflowAngle)
	
	//if (V0 == 0) V0 += sqrt(thrust/(2*airDensity))
	//else if (V0 > 0) V0 += sqrt(thrust/(2*V0))
	
	var MAF0 = airDensity * Vo
	var Ve = sqrt((thrust + MAF0 * Vo) / airDensity)
	airV = Ve
	airP = Po + airDensity * sqr(Ve) / 2
	airT *= power(airP/Po, 0.4/1.4)
	
	//airV *= 0.9
	airP /= 0.9
	
	airDensity = airP/(287 * airT)
	
	//if (i == 0 && V0 == 0) V0 = sqrt(airP / (2 * airDensity))
	////else if (i == 0 && V0 > 0) V0 += airT / (2 * airDensity * airV)

	//var attackAngle = undefined
	//if (RPM != 0) attackAngle = (compressor.incidence) - (180 / pi) * arctan(airV/(RPM * compressor.radius))
	//else attackAngle = (compressor.incidence)
	attackAngles[i] = attackAngle
	
	//var minDeltaP = 0.001 * airDensity * sqr(RPM * compressor.radius)
	//var deltaP = minDeltaP + (0.5 * compressor.CL(attackAngle) * airDensity * sqr(RPM * compressor.radius))
	
	//RPMreduction += 0.5 * airDensity * compressor.CD(attackAngle) * sqr(RPM * compressor.radius) * 0.0001
	
	//airT *= power((airP + deltaP) / airP, (0.4 / 1.4))
	//airP += deltaP
	
	//airV += airP / (2 * airDensity * airV) // rotor speed multiplier
	//airP *= 1.1 // stator pressure multiplier
	////V0 = min(V0, 343)
		
	array_push(arr.attackAngles[i], attackAngles[i])
	if (array_length(arr.attackAngles[i]) > dataPoints) array_delete(arr.attackAngles[i], 0, 1)
	
}

//V0 = 0

//var MAF = airDensity * airV
////show_debug_message("MAF " + string(MAF))

//RPM -= RPMreduction
//RPM = max(RPM, 0)

//var CPR = P3/P0
//compressor.workRequired = (1.005 * T0 * (power(CPR, 0.4 / 1.4) - 1)) / compressor.efficiency

V3 = airV
P3 = airP
T3 = airT

//fuelFlow = maxFuelFlow * throttle / 100
//var FAR = fuelFlow/MAF
//T4 = T3 * (1 + (FAR * burner.efficiency *  fuel.efficiency(1/FAR) * fuel.energyValue / (1.005 * T3))) / (1 + FAR)
////show_debug_message("AFR " + string(1/FAR))

//P4 = P3
//P5 = P4 * turbine.TPR(RPM)

//turbine.workCreated = turbine.efficiency * 1.005 * T4 * (1 - power(turbine.TPR(RPM), 0.4/1.4))

//netWork = turbine.workCreated - compressor.workRequired
//RPM += netWork / mainShaft.I