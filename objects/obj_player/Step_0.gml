movement_playerInput(self, flightMode)
movement_playerRotation(self, flightMode)

movement_flightModes(self, flightMode, true)

//weapons_update(self, weapons[0])
//gimbals_update_all(self, gimbals)
turrets_update_all(self, turrets)
if (!keyboard_check(ord("N")))
	turrets_turn_all(self, turrets, mouse_x, mouse_y, false)

global.player.position = position