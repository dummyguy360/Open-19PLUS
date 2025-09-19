if (place_meeting(x, y - 1, obj_player))
{
    with (obj_player)
    {
        if (state == states.knightpep || state == states.knightpepbump)
        {
            state = states.knightpepslopes;
            
            if (movespeed < 13)
                movespeed = 13;
        }
        else if (state != states.knightpepslopes && state != states.slipnslide && state != states.hitstun)
        {
            state = states.slipnslide;
            sprite_index = spr_slipnslide;
            scr_fmod_soundeffectONESHOT("event:/sfx/misc/slip", x, y);
        }
    }
}
