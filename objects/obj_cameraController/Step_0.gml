var view_width = camera_get_view_width(view_camera[0]);
var view_height = camera_get_view_height(view_camera[0]);

if (instance_exists(obj_playerPlane)) {
	var target_x = obj_playerPlane.x - view_width / 2;
	var target_y = obj_playerPlane.y - view_height / 2;

	camera_set_view_pos(view_camera[0], target_x, target_y);
}