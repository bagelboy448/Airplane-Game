position = new Vector2(x, y)
velocity = new Vector2()
acceleration = new Vector2()

spriteRenderingSurface = -1
spriteInternalSurface = -1
destructibleSprite = sprite_index
internalSprite = spr_planeTest_internal
//turret = {
//    x: 151,
//	y: 65,
//	sprite: spr_turret14
//}

turrets = []
array_push(turrets, new turret(151, 65, spr_turret14, 1, global.gatlingGun, 100))

turrets_initialize(self)