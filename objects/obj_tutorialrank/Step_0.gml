var _xdiff, _ydiff;

with (obj_player)
{
    var _prevx = x;
    var _prevy = y;
    x = lerp(x, room_width / 2, 0.1);
    y = lerp(y, room_height / 2, 0.1);
    _xdiff = x - _prevx;
    _ydiff = y - _prevy;
}

with (obj_pizzaface)
{
    x += _xdiff;
    y += _ydiff;
}
