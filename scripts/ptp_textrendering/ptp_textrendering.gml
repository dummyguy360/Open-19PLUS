function __ptp_draw_text(arg0, arg1, arg2, arg3 = 1, arg4 = 1, arg5 = 0, arg6 = draw_get_color(), arg7 = draw_get_color(), arg8 = draw_get_color(), arg9 = draw_get_color(), arg10 = draw_get_alpha())
{
    var _prevshader = shader_current();
    var _sdf = font_get_sdf_enabled(draw_get_font());
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(shd_sdf_premultiply);
    
    draw_text_transformed_colour(arg0 - 0.01, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(_prevshader);
}

function __ptp_draw_text_ext(arg0, arg1, arg2, arg3, arg4, arg5 = 1, arg6 = 1, arg7 = 0, arg8 = draw_get_color(), arg9 = draw_get_color(), arg10 = draw_get_color(), arg11 = draw_get_color(), arg12 = draw_get_alpha())
{
    var _prevshader = shader_current();
    var _sdf = font_get_sdf_enabled(draw_get_font());
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(shd_sdf_premultiply);
    
    draw_text_ext_transformed_colour(arg0 - 0.01, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(_prevshader);
}

function __draw_text_hook(arg0, arg1, arg2)
{
    __ptp_draw_text(arg0, arg1, arg2);
}

function __draw_text_ext_hook(arg0, arg1, arg2, arg3, arg4)
{
    __ptp_draw_text_ext(arg0, arg1, arg2, arg3, arg4);
}

function __draw_text_colour_hook(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
{
    __ptp_draw_text(arg0, arg1, arg2, 1, 1, 0, arg3, arg4, arg5, arg6, arg7);
}

function __draw_text_transformed_hook(arg0, arg1, arg2, arg3, arg4, arg5)
{
    __ptp_draw_text(arg0, arg1, arg2, arg3, arg4, arg5);
}

function __draw_text_ext_colour_hook(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
{
    __ptp_draw_text_ext(arg0, arg1, arg2, arg3, arg4, 1, 1, 0, arg5, arg6, arg7, arg8, arg9);
}

function __draw_text_ext_transformed_hook(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
{
    __ptp_draw_text_ext(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
}

function __draw_text_transformed_colour_hook(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
{
    __ptp_draw_text(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
}

function __draw_text_ext_transformed_colour_hook(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
{
    __ptp_draw_text_ext(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
}

function draw_text_fancy(arg0, arg1, arg2, arg3 = 16777215, arg4 = 1, arg5 = true, arg6 = input_profile_get(), arg7 = 0)
{
    var _font = draw_get_font();
    var _halign = draw_get_halign();
    var _valign = draw_get_valign();
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
    var _width = -5;
    var _lines = string_split(arg2, "\n");
    
    for (var l = 0; l < array_length(_lines); l++)
    {
        if (string_width(_lines[l]) > _width)
            _width = string_width_fancy(_lines[l]);
    }
    
    var _startingx = arg0;
    
    if (_halign == 1)
        arg0 -= (_width / 2);
    else if (_halign == 2)
        arg0 -= _width;
    
    var _lineheight = string_height("A") + global.fontextra[_font][7];
    var _height = (string_count("\n", arg2) + 1) * _lineheight;
    
    if (_valign == 1)
        arg1 -= (_height / 2);
    else if (_valign == 2)
        arg1 -= _height;
    
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
    
    for (var i = 1; i < (string_length(arg2) + 1); i++)
    {
        var _char = string_char_at(arg2, i);
        var _input = string_copy(arg2, i, 3);
        var _xoff = 0;
        var _yoff = 0;
        
        if (_char == "\n")
        {
            arg1 += _lineheight;
            var _nextlineendpos = string_pos_ext("\n", arg2, i + 1);
            
            if (_nextlineendpos == 0)
                _nextlineendpos = string_length(arg2);
            
            _nextlineendpos -= i;
            var _nextlinestr = string_copy(arg2, i + 1, _nextlineendpos);
            arg0 = _startingx;
            
            if (_halign == 1)
                arg0 -= (string_width_fancy(_nextlinestr) / 2);
            
            if (_halign == 2)
                arg0 -= string_width_fancy(_nextlinestr);
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
                        _yoff = wave(-2, 2, 1, 0, current_time + arg0);
                    
                    if (!is_undefined(ds_map_find_value(global.inputs, _input)))
                    {
                        var _verb = ds_map_find_value(global.inputs, _input);
                        array_push(_drawinputs, [round(arg0 + global.fontextra[_font][5] + _xoff), round(arg1 + global.fontextra[_font][6] + _yoff), _verb]);
                        arg0 += global.fontextra[_font][4];
                        i += 2;
                        break;
                        break;
                    }
                    
                    draw_text_colour(round(arg0 + _xoff), round(arg1 + _yoff), _char, arg3, arg3, arg3, arg3, arg4);
                    arg0 += string_width(_char);
            }
        }
    }
    
    if (_sdf && _prevshader == shd_premultiply)
        shader_set(_prevshader);
    
    for (var _i = 0; _i < array_length(_drawinputs); _i++)
        draw_input(_drawinputs[_i][0], _drawinputs[_i][1], arg4, _drawinputs[_i][2], arg5, arg6, arg7, global.fontextra[_font][0], global.fontextra[_font][1], global.fontextra[_font][2], global.fontextra[_font][3]);
    
    draw_set_halign(_halign);
    draw_set_valign(_valign);
}
