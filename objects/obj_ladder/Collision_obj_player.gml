with (other.id)
{
    if (input_check("up") && ladderbuffer == 0 && (state == 0 || state == 36 || sprite_index == spr_shoryuken || sprite_index == spr_scaredjumpstart || sprite_index == spr_scaredjump || sprite_index == spr_player_sewerjumpstart || sprite_index == spr_player_sewerjump || state == 47 || (state == 66 && sprite_index != spr_rocketdashstart && sprite_index != spr_rocketdash) || state == 120) && state != 50 && state != 48 && state != 51 && state != 53)
    {
        mach2 = 0;
        state = 37;
        x = other.x + 16;
        y = floor(y);
        
        if ((y % 2) == 1)
            y -= 1;
    }
}
