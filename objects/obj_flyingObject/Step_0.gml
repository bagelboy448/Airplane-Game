//movement_rotate(self, turnRate)
//movement_setDirection(self, point_direction(x, y, global.player.position.x, global.player.position.y))

//pointing.x = global.player.position.x - x
//pointing.y = global.player.position.y - y
movement_AI(self, global.player, "followPoint", {
	x: global.player.position.x, 
	y: global.player.position.y
})
movement_flightModes(self, "jet", true)