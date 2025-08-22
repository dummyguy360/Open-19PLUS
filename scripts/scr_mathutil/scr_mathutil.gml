function wrap(arg0, arg1, arg2)
{
    arg0 = floor(arg0);
    var _min = floor(min(arg1, arg2));
    var _max = floor(max(arg1, arg2));
    var range = (_max - _min) + 1;
    return ((((arg0 - _min) % range) + range) % range) + _min;
}

function wrap_angle(arg0)
{
    while (arg0 < 0)
        arg0 += 360;
    
    while (arg0 > 359)
        arg0 -= 360;
    
    return arg0;
}

function wave(arg0, arg1, arg2, arg3, arg4 = current_time)
{
    var a4 = (arg1 - arg0) * 0.5;
    return arg0 + a4 + (sin((((arg4 * 0.001) + (arg2 * arg3)) / arg2) * (2 * pi)) * a4);
}

function Approach(arg0, arg1, arg2)
{
    return arg0 + clamp(arg1 - arg0, -abs(arg2), abs(arg2));
}

function xscale_angle(arg0)
{
    return point_direction(0, 0, arg0, 0);
}
