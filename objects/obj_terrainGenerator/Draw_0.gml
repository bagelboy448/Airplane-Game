var tile_size = 32;
var scale = 0.01; // Larger = more zoomed out terrain features

var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);
var cam_w = camera_get_view_width(view_camera[0]);
var cam_h = camera_get_view_height(view_camera[0]);

var start_x = floor(cam_x / tile_size) - 1;
var start_y = floor(cam_y / tile_size) - 1;
var end_x = ceil((cam_x + cam_w) / tile_size) + 1;
var end_y = ceil((cam_y + cam_h) / tile_size) + 1;

for (var tx = start_x; tx < end_x; tx++) {
    for (var ty = start_y; ty < end_y; ty++) {
        var world_x = tx * tile_size;
        var world_y = ty * tile_size;

        var noise_val = noise2d(tx * scale, ty * scale);

        var spr;
        if (noise_val < -0.5) {
            spr = spr_deep_ocean;
        } else if (noise_val < -0.1) {
            spr = spr_water;
        } else if (noise_val < 0.3) {
            spr = spr_grass;
        } else if (noise_val < 0.6) {
            spr = spr_forest;
        } else {
            spr = spr_mountain;
        }

        draw_sprite(spr, 0, world_x, world_y);
    }
}
