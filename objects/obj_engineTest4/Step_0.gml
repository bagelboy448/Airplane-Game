var airV = V0
var airP = P0
var airT = T0
var airDensity = airP / (287 * airT)

compressor.swirl = 0.0
var bladeSpeed = RPM * compressor.radius
var RPMreduction = 0
for (var i = 0; i < compressor.stages; ++i) {
	compressor.axialV = airV * cos(compressor.swirl * pi / 2)
    var inflowAngle = (RPM == 0) ? pi/2 : arctan(compressor.axialV/(bladeSpeed - airV * sin(compressor.swirl * pi/2)))
	var attackAngle = (compressor.incidence + compressor.deltaIncidence * i) - inflowAngle * (180/pi)
	if (attackAngle <= compressor.criticalAngle && attackAngle > 0) {
		var deltaP = airP * (compressor.stagePR * attackAngle/compressor.criticalAngle - 1)
		airT = power((airP + deltaP) / airP, gammaP)
		airV += 0.5 * attackAngle/compressor.criticalAngle * sqr(bladeSpeed) * cos(inflowAngle) / airDensity
		airP += deltaP
		airDensity = airP / (287 * airT)
		if (V0 < airV) V0 += (airV - V0) * 0.001
	}
	
	RPMreduction += compressor.dragCoefficient * abs(attackAngle/compressor.criticalAngle) * 0.5 * sqr(bladeSpeed)
	compressor.swirl = (bladeSpeed - airV * tan(inflowAngle)) / airV
	if (compressor.swirl >= 1.0) show_debug_message("swirl at or exceeding 1.0")
}

V3 = airV
P3 = airP
T3 = airT