function camera_zoom(arg0, arg1 = noone)
{
    with (obj_drawcontroller)
    {
        targetzoom = arg0;
        targetzoom = clamp(targetzoom, 0, max_zoom);
        
        if (arg1 != noone)
            zoomspd = abs(arg1);
    }
}

function camera_set_zoom(arg0)
{
    with (obj_drawcontroller)
        zoom = arg0;
}

function bbox_in_camera(arg0, arg1, arg2 = 0)
{
    var camx = camera_get_view_x(view_camera[arg0]);
    var camy = camera_get_view_y(view_camera[arg0]);
    var camw = camera_get_view_width(view_camera[arg0]);
    var camh = camera_get_view_height(view_camera[arg0]);
    return rectangle_in_rectangle(arg1.bbox_left, arg1.bbox_top, arg1.bbox_right, arg1.bbox_bottom, camx - arg2, camy - arg2, camx + camw + arg2, camy + camh + arg2);
}

function camera_shake(arg0, arg1)
{
    with (obj_drawcontroller)
    {
        if (global.camerashake)
        {
            shake_mag = arg0;
            shake_mag_acc = arg1 / room_speed;
        }
    }
}
