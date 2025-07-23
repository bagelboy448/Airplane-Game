// inlet
P1 = P0
P2 = max(P1 * inlet.efficiency, P1) // add something for spillage drag later (should reduce inlet pressure)
T2 = T0

// compressor
P3 = (mainShaft.RPM == 0) ? P2 : P2 * compressor.CPR
T3 = max(T2 * power(compressor.CPR, (gamma - 1) / gamma), T2)
compressor.workRequired = T2 * (power(compressor.CPR, (gamma - 1) / gamma) - 1) * 0.000001 * sqr(mainShaft.RPM) / compressor.efficiency

// burner
P4 = P3
M3 = 1.225 * inlet.area * 0.000001 * sqrt(mainShaft.RPM) // mass flow
fuelFlowRate = maxFuelFlowRate * throttle / 100
M3 = max(M3, 2 * fuelFlowRate)
if (M3 == 0) T4 = T3
else T4 = T3 * (1 + ((fuelFlowRate / M3) * burner.efficiency * fuelHeatingValue) / (1.005 * T3)) / (1 + (fuelFlowRate / M3))

// turbine
P5 = (mainShaft.RPM == 0) ? P4 : P4 * turbine.TPR
T5 = T4 * power(turbine.TPR, (gamma - 1) / gamma)
turbine.workCreated = turbine.efficiency * 1.005 * T4 * (1 - power(turbine.TPR, (gamma - 1) / gamma))
mainShaft.RPM += (turbine.workCreated - compressor.workRequired)/mainShaft.I
if (mainShaft.RPM < 0) mainShaft.RPM = 0

// nozzle
P8 = P5
T8 = T5
nozzle.NPR = P8 / P0
V8 = sqrt(2 * nozzle.efficiency * 1.005 * T8 * max((1 - power(1 / nozzle.NPR, (gamma - 1) / gamma)), 0))


// thrust
thrust = 1.225 * inlet.area * max(V0, 1) * (V8 - max(V0, 1))