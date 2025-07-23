// inlet
P1 = P0
P2 = max(P1 * inlet.efficiency, P1) // add something for spillage drag later (should reduce inlet pressure)
T2 = T0

MAF = 180 * power(mainShaft.RPM / 15000, 0.9) // mass air flow

// compressor
if (mainShaft.RPM == 0) {
    P3 = P2
	T3 = T2
	compressor.workRequired = 0
}
else {
	var CPR = 1 + (compressor.CPR - 1) * power(mainShaft.RPM / 15000, 2)
	var efficiency = compressor.efficiency - 0.15 * power((mainShaft.RPM / 15000 - compressor.efficiency) / 0.5, 2)
    P3 = P2 * CPR
	T3 = T2 * power(CPR, (gamma - 1) / gamma)
	compressor.workRequired = T2 * (power(CPR, (gamma - 1) / gamma) - 1) / efficiency
}

// burner
P4 = P3
fuelFlowRate = maxFuelFlowRate * power(throttle / 100, 3)

if (MAF == 0) {
    T4 = T3
	T5 = T4
	
	// turbine
	P5 = P4
	turbine.workCreated = 0
}
else {
	T4 = T3 + (burner.efficiency * fuelFlowRate * fuelHeatingValue) / (MAF * 1.005 + fuelFlowRate * 2000)
	
	// turbine
	var TPR = turbine.TPR
	P5 = P4 * TPR
	T5 = T4 * power(TPR, (gamma - 1) / gamma)
	turbine.workCreated = turbine.efficiency * 1.005 * T4 * (1 - power(TPR, (gamma - 1) / gamma))
} 

// turbine continued
mainShaft.RPM += (60 / 6.283) * (turbine.workCreated - compressor.workRequired)/mainShaft.I
if (mainShaft.RPM < 0) mainShaft.RPM = 0

// nozzle
P8 = P5
T8 = T5
nozzle.NPR = P8 / P0
V8 = sqrt(2 * nozzle.efficiency * 1.005 * T8 * max((1 - power(1 / nozzle.NPR, (gamma - 1) / gamma)), 0))


// thrust
thrust = MAF * (V8 - V0)

array_push(thrustARR, thrust)
if (array_length(thrustARR) > 600) array_delete(thrustARR, 0, 1)
array_push(fuelFlowRateARR, fuelFlowRate)
if (array_length(fuelFlowRateARR) > 600) array_delete(fuelFlowRateARR, 0, 1)
array_push(RPMARR, mainShaft.RPM)
if (array_length(RPMARR) > 600) array_delete(RPMARR, 0, 1)
array_push(CWorkARR, compressor.workRequired)
if (array_length(CWorkARR) > 600) array_delete(CWorkARR, 0, 1)
array_push(TWorkARR, turbine.workCreated)
if (array_length(TWorkARR) > 600) array_delete(TWorkARR, 0, 1)
array_push(NetWorkARR, turbine.workCreated - compressor.workRequired)
if (array_length(NetWorkARR) > 600) array_delete(NetWorkARR, 0, 1)