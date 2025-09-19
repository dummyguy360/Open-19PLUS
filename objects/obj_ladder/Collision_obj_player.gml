with (other.id)
{
    if (input_check("up") && ladderbuffer == 0 && (state == states.normal || state == states.jump || sprite_index == spr_shoryuken || sprite_index == spr_scaredjumpstart || sprite_index == spr_scaredjump || sprite_index == spr_player_sewerjumpstart || sprite_index == spr_player_sewerjump || state == states.mach2 || (state == states.mach3 && sprite_index != spr_rocketdashstart && sprite_index != spr_rocketdash) || state == states.nwalljump) && state != states.hurt && state != states.machslide && state != states.freefall && state != states.freefallland)
    {
        mach2 = 0;
        state = states.ladder;
        x = other.x + 16;
        y = floor(y);
        
        if ((y % 2) == 1)
            y -= 1;
    }
}
