function scr_player_fireass()
{
    collide_destructibles = function(_h, _v)
    {
        scr_destroy_vertical(_v, destroy.ratblock);
        scr_destroy_horizontal(_h, destroy.ratblock | destroy.whitelist_destructibles | destroy.whitelist_onewaybigblock | destroy.whitelist_smbitembox);
    };
    
    hit_vertical = function(_v)
    {
        if (_v >= 0)
        {
            if (sprite_index == spr_fireass)
            {
                movespeed = 6;
                sprite_index = spr_fireassground;
                image_index = 0;
            }
            else if (sprite_index != spr_fireassground)
            {
                if (sprite_index == spr_player_sewerjumpstart || sprite_index == spr_player_sewerjump)
                {
                    with (instance_create_depth(x, y, -100, obj_baddiedead))
                        sprite_index = spr_slimespin;
                }
                
                state = states.normal;
                hsp = 0;
                movespeed = 0;
                image_index = 0;
                alarm[5] = 2;
                alarm[7] = 60;
                hurted = 1;
                landAnim = 0;
            }
        }
    };
    
    move = input_check_opposing("left", "right");
    
    if (sprite_index == spr_fireass || sprite_index == spr_scaredjumpstart || sprite_index == spr_scaredjump || sprite_index == spr_player_sewerjumpstart || sprite_index == spr_player_sewerjump)
    {
        if (floor(image_index) == (image_number - 1))
        {
            with (instance_create_depth(x, y + 25, 0, obj_balloonpop))
                sprite_index = spr_shotgunimpact;
        }
        
        if (move != 0)
        {
            xscale = move;
            
            if (sprite_index == spr_fireass)
            {
                if ((hsp * move) < 10)
                    hsp += (0.4 * move);
            }
            else
            {
                if ((hsp * move) < 6)
                    hsp += (0.4 * move);
                
                if ((hsp * move) > 6)
                    hsp -= (0.1 * move);
            }
        }
        else
        {
            if (hsp < 0)
                hsp += 0.2;
            
            if (hsp > 0)
                hsp -= 0.2;
        }
    }
    
    if (sprite_index == spr_fireassground)
    {
        hsp = xscale * movespeed;
        
        if (movespeed > 0)
            movespeed -= 0.25;
        
        if (floor(image_index) == (image_number - 1))
        {
            scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/fireasssizzle", x, y);
            state = states.normal;
            hsp = 0;
            movespeed = 0;
            image_index = 0;
            alarm[5] = 2;
            alarm[7] = 60;
            hurted = 1;
            landAnim = 0;
        }
    }
    
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_scaredjumpstart)
        sprite_index = spr_scaredjump;
    
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_sewerjumpstart)
        sprite_index = spr_player_sewerjump;
    
    image_speed = 0.35;
}
