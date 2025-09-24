function scr_player_climbwall()
{
    collide_destructibles = function(_h, _v)
    {
        if (_v < 0)
            scr_destroy_vertical(_v);
    };
    
    step_vertical = function(_v)
    {
        if (state != states.mach2 && wallspeed > 0 && !scr_solid_player(x + xscale, y))
        {
            instance_create_depth(x, y, 0, obj_jumpdust);
            vsp = 0;
            wallspeed = max(wallspeed, 6);
            
            if (wallspeed >= 6 && wallspeed < 12)
            {
                state = states.mach2;
                movespeed = wallspeed;
            }
            else
            {
                if (character != "S")
                {
                    state = states.mach3;
                    sprite_index = spr_mach4;
                }
                else if (!snickmach3mode)
                {
                    state = states.mach2;
                    sprite_index = spr_mach;
                }
                else
                {
                    state = states.mach3;
                    sprite_index = spr_mach4;
                }
                
                movespeed = wallspeed;
            }
            
            hsp = movespeed * xscale;
            return false;
        }
        
        return true;
    };
    
    hit_vertical = function(_v)
    {
        sprite_index = spr_superjumpland;
        scr_fmod_soundeffectONESHOT("event:/sfx/player/groundpound", x, y);
        image_index = 0;
        state = states.sjumpland;
        machhitAnim = 0;
        wallclimbtime = 0;
        gamepadvibrate(0.4, 0, 7);
    };
    
    if (character == "N")
    {
        with (instance_create_depth(x, y, obj_player.depth, obj_balloonpop))
            sprite_index = spr_noisewalljumpeffect;
        
        state = states.nwalljump;
        savedmove = xscale;
        vsp = -(17 * (1 - (noisewalljump * 0.15)));
        noisewalljump++;
        hsp = 0;
        movespeed = 0;
        image_index = 0;
        sprite_index = spr_playerN_wallbounce;
        exit;
    }
    
    sprite_index = (character == "P") ? spr_player_climbwallmax : spr_machclimbwall;
    
    if (windingAnim < 200)
        windingAnim++;
    
    move = input_check_opposing("left", "right");
    suplexmove = 0;
    
    if (input_check_pressed("jump"))
        input_buffer_jump = 0;
    
    vsp = -wallspeed;
    
    if (wallspeed < 20)
        wallspeed += 0.15;
    
    if (movespeed >= 18)
        movespeed += 0.4;
    else if (movespeed < 18)
        movespeed += 0.2;
    
    crouchslideAnim = 1;
    cangrab = 1;
    
    if (wallclimbtime > 0)
        wallclimbtime--;
    
    if (!input_check("dash") && wallclimbtime == 0)
    {
        state = states.normal;
        movespeed = 0;
        additionalhsp = -8 * xscale;
    }
    
    if (wallspeed < 0)
    {
        if (!scr_solid(x + xscale, y + 50))
            vsp = 0;
    }
    
    if (wallspeed < 0 && scr_solid(x, y + 12))
        wallspeed = 0;
    
    if (input_buffer_jump < 8)
    {
        input_buffer_jump = 8;
        wallclimbtime = 10;
        image_index = 0;
        jumpstop = 0;
        scr_fmod_soundeffect(char_jumpsnd, x, y);
        state = states.mach2;
        sprite_index = spr_walljumpstart;
        movespeed = 10;
        vsp = -11;
        xscale *= -1;
    }
    
    if (grounded && wallspeed <= 0)
    {
        state = states.normal;
        jumpstop = 1;
    }
    
    image_speed = wallspeed / 20;
    
    if (steppy > 0)
        steppy--;
    else
    {
        steppy = 10;
        instance_create_depth(x, y + 43, 0, obj_cloudeffect);
    }
}
