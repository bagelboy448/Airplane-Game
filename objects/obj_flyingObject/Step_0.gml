//movement_rotate(self, turnRate)
//movement_setDirection(self, point_direction(x, y, global.player.position.x, global.player.position.y))

acceleration.zero()
velocity.add(acceleration)
position.add(velocity)
x = position.x
y = position.y

if (irandom(60) == 0) velocity.y *= -1