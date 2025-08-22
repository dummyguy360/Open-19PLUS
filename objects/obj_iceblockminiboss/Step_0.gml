if (visible == 1 && obj_player.state != 3)
{
    if (place_meeting(x, y - 1, obj_player))
    {
        with (obj_player)
        {
            if (state == 18)
            {
                state = 13;
                
                if (movespeed < 13)
                    movespeed = 13;
            }
            else if (state != 13)
            {
                state = 38;
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
