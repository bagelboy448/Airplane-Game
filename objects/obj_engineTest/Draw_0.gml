draw_self()

if (!surface_exists(gradientSurface)) {
    gradientSurface = surface_create(room_width, room_height)
}

surface_set_target(gradientSurface)
draw_set_alpha(1)

#region gradient regions

var minColor = c_blue
var midColor = c_red
var maxColor = c_yellow

var startColor = undefined
var endColor = undefined
var tNorm = undefined

//var TMaxX = 137
//draw_rectangle_color(x, y, x + TMaxX, y + sprite_height, minColor, maxColor, maxColor, minColor, false)
//draw_rectangle_color(x + TMaxX, y, x + sprite_width, y + sprite_height, maxColor, minColor, minColor, maxColor, false)

var minTemp = min(T0, T2, T3, T4, T5, T8)
var maxTemp = max(T0, T2, T3, T4, T5, T8)


tNorm = clamp((T0 - minTemp) / (maxTemp - minTemp), 0, 1)
if (tNorm < 0.5) startColor = merge_color(minColor, midColor, tNorm)
else startColor = merge_color(midColor, maxColor, tNorm)
	
tNorm = clamp((T2 - minTemp) / (maxTemp - minTemp), 0, 1)
if (tNorm < 0.5) endColor = merge_color(minColor, midColor, tNorm)
else endColor = merge_color(midColor, maxColor, tNorm)

draw_rectangle_color(x, y, x + 52, y + sprite_height, startColor, endColor, endColor, startColor, false)

tNorm = clamp((T2 - minTemp) / (maxTemp - minTemp), 0, 1)
if (tNorm < 0.5) startColor = merge_color(minColor, midColor, tNorm)
else startColor = merge_color(midColor, maxColor, tNorm)
	
tNorm = clamp((T3 - minTemp) / (maxTemp - minTemp), 0, 1)
if (tNorm < 0.5) endColor = merge_color(minColor, midColor, tNorm)
else endColor = merge_color(midColor, maxColor, tNorm)

draw_rectangle_color(x + 53, y, x + 123, y + sprite_height, startColor, endColor, endColor, startColor, false)

tNorm = clamp((T3 - minTemp) / (maxTemp - minTemp), 0, 1)
if (tNorm < 0.5) startColor = merge_color(minColor, midColor, tNorm)
else startColor = merge_color(midColor, maxColor, tNorm)
	
tNorm = clamp((T4 - minTemp) / (maxTemp - minTemp), 0, 1)
if (tNorm < 0.5) endColor = merge_color(minColor, midColor, tNorm)
else endColor = merge_color(midColor, maxColor, tNorm)

draw_rectangle_color(x + 124, y, x + 151, y + sprite_height, startColor, endColor, endColor, startColor, false)

tNorm = clamp((T4 - minTemp) / (maxTemp - minTemp), 0, 1)
if (tNorm < 0.5) startColor = merge_color(minColor, midColor, tNorm)
else startColor = merge_color(midColor, maxColor, tNorm)
	
tNorm = clamp((T5 - minTemp) / (maxTemp - minTemp), 0, 1)
if (tNorm < 0.5) endColor = merge_color(minColor, midColor, tNorm)
else endColor = merge_color(midColor, maxColor, tNorm)

draw_rectangle_color(x + 152, y, x + 177, y + sprite_height, startColor, endColor, endColor, startColor, false)

tNorm = clamp((T5 - minTemp) / (maxTemp - minTemp), 0, 1)
if (tNorm < 0.5) startColor = merge_color(minColor, midColor, tNorm)
else startColor = merge_color(midColor, maxColor, tNorm)
	
tNorm = clamp((T8 - minTemp) / (maxTemp - minTemp), 0, 1)
if (tNorm < 0.5) endColor = merge_color(minColor, midColor, tNorm)
else endColor = merge_color(midColor, maxColor, tNorm)

draw_rectangle_color(x + 178, y, x + sprite_width, y + sprite_height, startColor, endColor, endColor, startColor, false)

#endregion

if (!surface_exists(maskSurface)) {
    maskSurface = surface_create(room_width, room_height)
}

surface_reset_target()
surface_set_target(maskSurface)
draw_set_alpha(1.0)

draw_set_color(c_white)
draw_rectangle(x, y, x + sprite_width, y + sprite_height, false)
gpu_set_blendmode(bm_subtract)
draw_sprite(spr_engineDiagram, -1, x, y)

surface_reset_target()
surface_set_target(gradientSurface)
draw_surface(maskSurface, 0, 0)

gpu_set_blendmode(bm_normal)
surface_reset_target()
draw_surface(gradientSurface, 0, 0)