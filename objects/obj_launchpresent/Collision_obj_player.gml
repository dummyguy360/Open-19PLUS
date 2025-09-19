if (image_yscale >= 1)
{
    with (obj_player)
    {
        if (sprite_index != spr_player_catched && sprite_index != spr_presentjump)
        {
            if (state == states.knightpep || state == states.knightpepslopes)
            {
                scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/detransfo", x, y);
                
                for (var i = 0; i < 5; i++)
                {
                    with (instance_create_depth(x, y, -1, obj_knightdebris))
                        image_index = i;
                }
            }
            
            if (state == states.bombpep)
                instance_create_depth(x, y, 0, obj_bombexplosion);
            
            if (state == states.cheeseball)
            {
                repeat (8)
                    instance_create_depth(x, y, -1, obj_slimedebris);
                
                scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/detransfo", x, y);
            }
            
            if (state == states.boxxedpep)
            {
                scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/detransfo", x, y);
                
                for (var i = 0; i < 4; i++)
                {
                    with (instance_create_depth(x, y, -1, obj_boxxeddebris))
                        image_index = i;
                }
            }
            
            grounded = false;
            instance_create_depth(x, y, 0, obj_bangeffect);
            x = other.x;
            hsp = 0;
            sprite_index = spr_presentjump;
            
            if (state != states.sjump)
            {
                state = states.sjump;
                vsp = -10;
                cancel_Sjump = false;
                scr_fmod_soundeffectONESHOT("event:/sfx/player/spring", x, y);
            }
            
            other.sprite_index = spr_launchpresent_hit;
            other.image_index = 0;
        }
    }
}
else if (image_yscale <= -1)
{
    with (obj_player)
    {
        if (sprite_index != spr_player_catched && sprite_index != spr_rockethitwall)
        {
            x = other.x;
            y = other.y + (16 * other.image_yscale);
            hsp = 0;
            grounded = false;
            
            if (state != states.freefall)
            {
                state = states.freefall;
                sprite_index = spr_rockethitwall;
                vsp = 12;
                freefallsmash = 10;
                scr_fmod_soundeffectONESHOT("event:/sfx/player/spring", x, y);
            }
            
            if (state == states.knightpep || state == states.knightpepslopes)
            {
                scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/detransfo", x, y);
                
                for (var i = 0; i < 5; i++)
                {
                    with (instance_create_depth(x, y, -1, obj_knightdebris))
                        image_index = i;
                }
            }
            
            if (state == states.bombpep)
                instance_create_depth(x, y, 0, obj_bombexplosion);
            
            instance_create_depth(x, y, 0, obj_bangeffect);
            
            if (other.sprite_index != spr_launchpresent_hit)
            {
                other.sprite_index = spr_launchpresent_hit;
                other.image_index = 0;
            }
        }
    }
}
