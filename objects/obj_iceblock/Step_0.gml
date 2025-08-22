if (place_meeting(x, y - 1, obj_player))
{
    with (obj_player)
    {
        if (state == 18 || state == 115)
        {
            state = 13;
            
            if (movespeed < 13)
                movespeed = 13;
        }
        else if (state != 13 && state != 38 && state != 87)
        {
            state = 38;
            sprite_index = spr_slipnslide;
            scr_fmod_soundeffectONESHOT("event:/sfx/misc/slip", x, y);
        }
    }
}
