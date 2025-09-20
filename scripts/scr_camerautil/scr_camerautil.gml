function camera_zoom(_zoom, _zoomSpd = noone)
{
    with (obj_drawcontroller)
    {
        targetzoom = _zoom;
        targetzoom = clamp(targetzoom, 0, max_zoom);
        
        if (_zoomSpd != noone)
            zoomspd = abs(_zoomSpd);
    }
}

function camera_set_zoom(_zoom)
{
    with (obj_drawcontroller)
        zoom = _zoom;
}

function bbox_in_camera(_cam, _rm, _offset = 0)
{
    var camx = camera_get_view_x(view_camera[_cam]);
    var camy = camera_get_view_y(view_camera[_cam]);
    var camw = camera_get_view_width(view_camera[_cam]);
    var camh = camera_get_view_height(view_camera[_cam]);
    return rectangle_in_rectangle(_rm.bbox_left, _rm.bbox_top, _rm.bbox_right, _rm.bbox_bottom, camx - _offset, camy - _offset, camx + camw + _offset, camy + camh + _offset);
}

function camera_shake(_shake, _shake_acc)
{
    with (obj_drawcontroller)
    {
        if (global.camerashake)
        {
            shake_mag = _shake;
            shake_mag_acc = _shake_acc / room_speed;
        }
    }
}
