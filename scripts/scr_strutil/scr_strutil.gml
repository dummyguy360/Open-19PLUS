function string_lpad(_str, _pad, _padstr = " ")
{
    var padsize = string_length(_padstr);
    var padding = _pad - string_length(_str);
    
    if (padding <= 0)
        return _str;
    
    var out = string_repeat(_padstr, padding div padsize);
    out += string_copy(_padstr, 1, padding % padsize);
    out += _str;
    out = string_copy(out, 1, _pad);
    return out;
}

function string_padzeros(_val, _pad = 2)
{
    return string_lpad(string(_val), _pad, "0");
}
