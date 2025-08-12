var targetPosition = targeting_predictPosition(self, global.clickedObject, global.gatlingGun)
//if (targetPosition != undefined) turrets_turn_all(self, turrets, targetPosition.x, targetPosition.y, false)
if (targetPosition != undefined) {
	
	var aimDir = angle_difference(point_direction(x, y, targetPosition.x, targetPosition.y), image_angle)
	gimbals_fire_all(self, gimbals, aimDir)
	
}