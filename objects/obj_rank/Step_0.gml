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

if (floor(image_index) == (image_number - 1))
    image_speed = 0;

if (global.timetrial)
{
    switch (global.timetrialrank)
    {
        case tt_rank.purple:
            sprite_index = spr_TTrankPURPLE;
            break;
        
        case tt_rank.gold:
            sprite_index = spr_TTrankGOLD;
            break;
        
        case tt_rank.silver:
            sprite_index = spr_TTrankSILVER;
            break;
        
        case tt_rank.bronze:
            sprite_index = spr_TTrankBRONZE;
            break;
    }
}
else
{
    switch (global.rank)
    {
        case rank.P:
            sprite_index = obj_player.spr_prank;
            break;
        
        case rank.S:
            sprite_index = obj_player.spr_srank;
            break;
        
        case rank.A:
            sprite_index = obj_player.spr_arank;
            break;
        
        case rank.B:
            sprite_index = obj_player.spr_brank;
            break;
        
        case rank.C:
            sprite_index = obj_player.spr_crank;
            break;
        
        case rank.D:
            sprite_index = obj_player.spr_drank;
            break;
    }
}
