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