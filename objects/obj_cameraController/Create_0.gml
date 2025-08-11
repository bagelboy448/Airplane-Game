global.playerCamera = {}
global.playerCamera.id = self

viewWidth = 960
viewHeight = 540
scale = 1
smoothness = 0.25

view_enabled = true
view_visible[0] = true

camera = camera_create_view(0, 0, viewWidth, viewHeight)
view_set_camera(0, camera)

window_set_size(viewWidth * scale, viewHeight * scale)
surface_resize(application_surface, viewWidth * scale, viewHeight * scale)

display_set_gui_size(viewWidth, viewHeight)

var displayWidth = display_get_width()
var displayHeight = display_get_height()

var windowWidth = viewWidth * scale
var windowHeight = viewHeight * scale

window_set_position(displayWidth/2 - windowWidth/2, displayHeight/2 - windowHeight/2)