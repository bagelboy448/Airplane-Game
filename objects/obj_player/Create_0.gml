position = new Vector2(x, y)
velocity = new Vector2()
acceleration = new Vector2()
input = new Vector2()
pointDirection = 0

global.player = self

// flightModes = "jet", "hover"

weapons = []
array_push(weapons, new weapon(global.gatlingGun))
weapons_initialize(self)

turrets = []
array_push(turrets, new turret(151, 65, spr_turret14, 10, global.cannon, 300))
array_push(turrets, new turret(156, 93, spr_turret18, 10, global.cannon, 450))
array_push(turrets, new turret(156, 141, spr_turret18, 10, global.cannon, 450))
array_push(turrets, new turret(151, 169, spr_turret14, 10, global.cannon, 300))

turrets_initialize(self)