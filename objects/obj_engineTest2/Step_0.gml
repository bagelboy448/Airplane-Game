P[? 1] = P[? 0]
P[? 2] = P[? 1]
T[? 2] = T[? 0]

var MAF = compressor.MAF(RPM)

#region compressor

if (RPM == 0) {
    P[? 3] = P[? 2]
	T[? 3] = T[? 2]
	compressor.workRequired = 0
}
else {
    var CPR = compressor.CPR(RPM)
	var efficiency = compressor.efficiency
	P[? 3] = P[? 2] * CPR
	T[? 3] = T[? 2] * power(CPR, gammaP)
	compressor.workRequired = T[? 2] * (power(CPR, gammaP) - 1) / efficiency
}

#endregion

#region burner & turbine

P[? 4] = P[? 3]
fuelFlow = maxFuelFlow * throttle / 100

if (MAF == 0) {
    T[? 4] = T[? 3]
	T[? 5] = T[? 4]
	
	P[? 5] = P[? 4]
	turbine.workCreated = 0
}
else {
    T[? 4] = T[? 3] + (burner.efficiency * fuelFlow * fuelHeatingValue) / (MAF * 1.005 + fuelFlow * 2000)
	var TPR = turbine.TPR(RPM)
	P[? 5] = P[? 4] * TPR
	T[? 5] = T[? 4] * power(TPR, gammaP)
	turbine.workCreated = turbine.efficiency * 1.005 * T[? 4] * (1 - power(TPR, gammaP))
}

RPM += (60/6.283) * (turbine.workCreated - compressor.workRequired) / I

#endregion

#region nozzle

P[? 8] = P[? 5]
T[? 8] = T[? 5]
nozzle.NPR = P[? 8] / P[? 0]
if (nozzle.NPR > 1)
	V8 = sqrt(2 * 1.005 * T[? 8] * nozzle.efficiency * (1 - power(1/nozzle.NPR, gammaP)))
else
	V8 = 0

#endregion

thrust = MAF * (V8 - V0)

#region graphing

array_push(arr.thrust, thrust)
array_push(arr.RPM, RPM)
array_push(arr.throttle, throttle)

if (array_length(arr.thrust) > arr.dataPoints) array_delete(arr.thrust, 0, 1)
if (array_length(arr.RPM) > arr.dataPoints) array_delete(arr.RPM, 0, 1)
if (array_length(arr.throttle) > arr.dataPoints) array_delete(arr.throttle, 0, 1)

#endregion