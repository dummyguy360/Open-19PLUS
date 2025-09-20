function raycast(_x, _y, _dir, _range, _objToCollide)
{
    var _list = ds_map_create();
    ds_map_add(_list, "distance", _range);
    ds_map_add(_list, "x", _x + lengthdir_x(_range, _dir));
    ds_map_add(_list, "y", _y + lengthdir_y(_range, _dir));
    ds_map_add(_list, "x_origin", _x);
    ds_map_add(_list, "y_origin", _y);
    var _col = collision_line(_x, _y, _x + lengthdir_x(_range, _dir), _y + lengthdir_y(_range, _dir), _objToCollide, true, true);
    
    if (_col)
    {
        var _xA = 0;
        var _yA = 0;
        var _rangeCount;
        
        for (_rangeCount = 1; !collision_line(_x, _y, _x + _xA, _y + _yA, _objToCollide, true, true) && _rangeCount < _range; _rangeCount++)
        {
            _xA = lengthdir_x(_rangeCount, _dir);
            _yA = lengthdir_y(_rangeCount, _dir);
        }
        
        _list[? "distance"] = _rangeCount;
        _list[? "x"] = _x + _xA;
        _list[? "y"] = _y + _yA;
        _list[? "x_origin"] = _x;
        _list[? "y_origin"] = _y;
        _col = collision_line(_x, _y, _x + _xA, _y + _yA, _objToCollide, true, true);
    }
    
    switch (_col)
    {
        case noone:
            ds_map_add(_list, "obj", noone);
            break;
        
        default:
            var _obj = _col;
            ds_map_add(_list, "obj", _obj);
            break;
    }
    
    return _list;
}
