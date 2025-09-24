#region PTP System Draw Functions
function __ptp_draw_text(_x, _y, _str, _xscale = 1, _yscale = 1, _angle = 0, _c1 = draw_get_color(), _c2 = draw_get_color(), _c3 = draw_get_color(), _c4 = draw_get_color(), _alpha = draw_get_alpha())
{
    var _prevshader = shader_current();
    var _sdf = font_get_sdf_enabled(draw_get_font());
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(shd_sdf_premultiply);
    
    draw_text_transformed_colour(_x - 0.01, _y, _str, _xscale, _yscale, _angle, _c1, _c2, _c3, _c4, _alpha);
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(_prevshader);
}

function __ptp_draw_text_ext(_x, _y, _str, _sep, _w, _xscale = 1, _yscale = 1, _angle = 0, _c1 = draw_get_color(), _c2 = draw_get_color(), _c3 = draw_get_color(), _c4 = draw_get_color(), _alpha = draw_get_alpha())
{
    var _prevshader = shader_current();
    var _sdf = font_get_sdf_enabled(draw_get_font());
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(shd_sdf_premultiply);
    
    draw_text_ext_transformed_colour(_x - 0.01, _y, _str, _sep, _w, _xscale, _yscale, _angle, _c1, _c2, _c3, _c4, _alpha);
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(_prevshader);
}
#endregion

function __draw_text_hook(_x, _y, _str)
{
    __ptp_draw_text(_x, _y, _str);
}

function __draw_text_ext_hook(_x, _y, _str, _sep, _w)
{
    __ptp_draw_text_ext(_x, _y, _str, _sep, _w);
}

function __draw_text_colour_hook(_x, _y, _str, _c1, _c2, _c3, _c4, _alpha)
{
    __ptp_draw_text(_x, _y, _str, 1, 1, 0, _c1, _c2, _c3, _c4, _alpha);
}

function __draw_text_transformed_hook(_x, _y, _str, _xscale, _yscale, _angle)
{
    __ptp_draw_text(_x, _y, _str, _xscale, _yscale, _angle);
}

function __draw_text_ext_colour_hook(_x, _y, _str, _sep, _w, _c1, _c2, _c3, _c4, _alpha)
{
    __ptp_draw_text_ext(_x, _y, _str, _sep, _w, 1, 1, 0, _c1, _c2, _c3, _c4, _alpha);
}

function __draw_text_ext_transformed_hook(_x, _y, _str, _sep, _w, _xscale, _yscale, _angle)
{
    __ptp_draw_text_ext(_x, _y, _str, _sep, _w, _xscale, _yscale, _angle);
}

function __draw_text_transformed_colour_hook(_x, _y, _str, _xscale, _yscale, _angle, _c1, _c2, _c3, _c4, _alpha)
{
    __ptp_draw_text(_x, _y, _str, _xscale, _yscale, _angle, _c1, _c2, _c3, _c4, _alpha);
}

function __draw_text_ext_transformed_colour_hook(_x, _y, _str, _sep, _w, _xscale, _yscale, _angle, _c1, _c2, _c3, _c4, _alpha)
{
    __ptp_draw_text_ext(_x, _y, _str, _sep, _w, _xscale, _yscale, _angle, _c1, _c2, _c3, _c4, _alpha);
}

function draw_text_fancy(_x, _y, _str, _color = c_white, _alpha = 1, _remapkeys = true, _profile = input_profile_get(), _alternate = 0)
{
    var _font = draw_get_font();
    var _halign = draw_get_halign();
    var _valign = draw_get_valign();
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
    var _width = -5;
    var _lines = string_split(_str, "\n");
    
    for (var l = 0; l < array_length(_lines); l++)
    {
        if (string_width(_lines[l]) > _width)
            _width = string_width_fancy(_lines[l]);
    }
    
    var _startingx = _x;
    
    if (_halign == 1)
        _x -= (_width / 2);
    else if (_halign == 2)
        _x -= _width;
    
    var _lineheight = string_height("A") + global.fontextra[_font][7];
    var _height = (string_count("\n", _str) + 1) * _lineheight;
    
    if (_valign == 1)
        _y -= (_height / 2);
    else if (_valign == 2)
        _y -= _height;
    
    var _frame = floor(current_time / 16.666666666666668);
    var _shake = false;
    var _vertshake = false;
    var _wave = false;
    var _vertshakedir = floor(_frame / 2) % 2;
    var _drawinputs = [];
    var _prevshader = shader_current();
    var _sdf = font_get_sdf_enabled(draw_get_font());
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(shd_sdf_premultiply);
    
    for (var i = 1; i < (string_length(_str) + 1); i++)
    {
        var _char = string_char_at(_str, i);
        var _input = string_copy(_str, i, 3);
        var _xoff = 0;
        var _yoff = 0;
        
        if (_char == "\n")
        {
            _y += _lineheight;
            var _nextlineendpos = string_pos_ext("\n", _str, i + 1);
            
            if (_nextlineendpos == 0)
                _nextlineendpos = string_length(_str);
            
            _nextlineendpos -= i;
            var _nextlinestr = string_copy(_str, i + 1, _nextlineendpos);
            _x = _startingx;
            
            if (_halign == 1)
                _x -= (string_width_fancy(_nextlinestr) / 2);
            
            if (_halign == 2)
                _x -= string_width_fancy(_nextlinestr);
        }
        else
        {
            switch (_input)
            {
                case "{S}":
                    _shake = true;
                    i += 2;
                    break;
                
                case "{V}":
                    _vertshake = true;
                    i += 2;
                    break;
                
                case "{W}":
                    _wave = true;
                    i += 2;
                    break;
                
                case "{/}":
                    _shake = false;
                    _wave = false;
                    i += 2;
                    break;
                
                default:
                    if (_shake)
                    {
                        _xoff = irandom_range(-1, 1);
                        _yoff = irandom_range(-1, 1);
                    }
                    
                    _vertshakedir = !_vertshakedir;
                    
                    if (_vertshake)
                        _yoff = _vertshakedir;
                    
                    if (_wave)
                        _yoff = wave(-2, 2, 1, 0, current_time + _x);
                    
                    if (!is_undefined(global.inputs[? _input]))
                    {
                        var _verb = global.inputs[? _input];
                        array_push(_drawinputs, [round(_x + global.fontextra[_font][5] + _xoff), round(_y + global.fontextra[_font][6] + _yoff), _verb]);
                        _x += global.fontextra[_font][4];
                        i += 2;
                        break;
                        break;
                    }
                    
                    draw_text_colour(round(_x + _xoff), round(_y + _yoff), _char, _color, _color, _color, _color, _alpha);
                    _x += string_width(_char);
            }
        }
    }
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(_prevshader);
    
    for (var _i = 0; _i < array_length(_drawinputs); _i++)
        draw_input(_drawinputs[_i][0], _drawinputs[_i][1], _alpha, _drawinputs[_i][2], _remapkeys, _profile, _alternate, global.fontextra[_font][0], global.fontextra[_font][1], global.fontextra[_font][2], global.fontextra[_font][3]);
    
    draw_set_halign(_halign);
    draw_set_valign(_valign);
}
