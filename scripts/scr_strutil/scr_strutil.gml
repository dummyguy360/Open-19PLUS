function string_lpad(arg0, arg1, arg2 = " ")
{
    var padsize = string_length(arg2);
    var padding = arg1 - string_length(arg0);
    
    if (padding <= 0)
        return arg0;
    
    var out = string_repeat(arg2, padding div padsize);
    out += string_copy(arg2, 1, padding % padsize);
    out += arg0;
    out = string_copy(out, 1, arg1);
    return out;
}

function string_padzeros(arg0, arg1 = 2)
{
    return string_lpad(string(arg0), arg1, "0");
}
