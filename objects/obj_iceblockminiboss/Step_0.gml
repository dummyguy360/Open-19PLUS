if (visible == 1 && obj_player.state != states.ejected)
{
    if (place_meeting(x, y - 1, obj_player))
    {
        with (obj_player)
        {
            if (state == states.knightpep)
            {
                state = states.knightpepslopes;
                
                if (movespeed < 13)
                    movespeed = 13;
            }
            else if (state != states.knightpepslopes)
            {
                state = states.slipnslide;
                sprite_index = spr_slipnslide;
            }
        }
    }
}

if (visible == 0 && global.boxhp <= 5)
{
    visible = 1;
    
    repeat (4)
        instance_create_depth(x, y, -1, obj_debris);
    
    scr_sound_multiple("event:/sfx/misc/breakblock", x, y);
    mask_index = sprite_index;
}
