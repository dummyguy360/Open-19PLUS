with (other.id)
{
    if (state != states.mach3 && state != states.ghost && sprite_index != spr_player_catched)
    {
        if (state == states.knightpep || state == states.knightpepslopes)
        {
            for (var i = 0; i < 5; i += 1)
            {
                with (instance_create_depth(x, y, -1, obj_knightdebris))
                    image_index = i;
            }
            
            scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/detransfo", x, y);
        }
        
        if (state == states.bombpep)
            instance_create_depth(x, y, 0, obj_bombexplosion);
        
        if (state == states.boxxedpep)
        {
            scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/detransfo", x, y);
            
            for (var i = 0; i < 4; i++)
            {
                with (instance_create_depth(x, y, -1, obj_boxxeddebris))
                    image_index = i;
            }
        }
        
        xscale = other.image_xscale;
        machhitAnim = 0;
        state = states.mach3;
        
        if (sprite_index != spr_Dashpad)
        {
            sprite_index = spr_Dashpad;
            instance_create_depth(x, y, 0, obj_jumpdust);
        }
        
        image_index = 0;
        movespeed = 12;
        y = other.y - 15;
        vsp = 0;
        dashpadbuffer = 15;
        scr_fmod_soundeffectONESHOT("event:/sfx/player/dashpad", x, y);
    }
    
    if (state == states.mach3 || state == states.machroll || state == states.sjump || state == states.climbwall)
    {
        if (state != states.mach3)
            state = states.mach3;
        
        if (sprite_index != spr_Dashpad && sprite_index != spr_crazyrun)
        {
            sprite_index = spr_Dashpad;
            image_index = 0;
            instance_create_depth(x, y, 0, obj_jumpdust);
        }
        
        xscale = other.image_xscale;
        
        if (dashpadbuffer == 0)
        {
            dashpadbuffer = 15;
            scr_fmod_soundeffectONESHOT("event:/sfx/player/dashpad", x, y);
            movespeed += 1;
            y = other.y - 15;
            vsp = 0;
        }
    }
}
