draw_set_color(c_white)
draw_arrow(x, y, x + 200 * dcos(pointDirection), y - 200 * dsin(pointDirection), 10)

draw_set_color(c_blue)
draw_arrow(x, y, x + 150 * dcos(acceleration.direction()), y - 150 * dsin(acceleration.direction()), 10)

draw_set_color(c_yellow)
draw_arrow(x, y, x + 100 * dcos(velocity.direction()), y - 100 * dsin(velocity.direction()), 10)

draw_set_color(c_white)

draw_self()
turrets_draw_all(self, turrets)