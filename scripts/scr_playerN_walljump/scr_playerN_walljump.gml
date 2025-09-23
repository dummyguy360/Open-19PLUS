function scr_playerN_walljump()
{
    collide_destructibles = function(_v, _h)
    {
        scr_destroy_vertical(_v);
        scr_destroy_horizontal(_h);
    };
    
    noisemachcancelbuffer = 10;
    hsp = movespeed;
    move = input_check("right") - input_check("left");
    
    if (move != 0)
        savedmove = move;
    
    if (sprite_index == spr_playerN_divebomb || sprite_index == spr_playerN_divebombland || sprite_index == spr_playerN_divebombfall)
    {
        if (move != 0)
        {
            if (abs(movespeed) < 12)
                movespeed = Approach(movespeed, move * 12, 1);
            else
                movespeed = Approach(movespeed, move * abs(movespeed), 1);
        }
        else
            movespeed = Approach(movespeed, 0, 0.25);
        
        var xx = movespeed;
        
        if (xx == 0)
            xx = xscale;
        
        if (grounded && vsp > 0 && place_meeting(x + xx, y, obj_solid))
        {
            mask_index = spr_crouchmask;
            
            if (!place_meeting(x + xx, y, obj_solid) || place_meeting(x + xx, y, obj_destructibles))
            {
                state = states.crouchslide;
                sprite_index = spr_machroll;
                image_index = 0;
                instance_destroy(instance_place(x + xx, y, obj_destructibles));
                
                if (movespeed != 0)
                    xscale = sign(movespeed);
                
                movespeed = abs(movespeed);
                
                if (movespeed < 6)
                    movespeed = 6;
            }
            
            mask_index = spr_player_mask;
        }
    }
    else if (move != 0)
        movespeed = Approach(movespeed, move * 8, 1);
    else
        movespeed = Approach(movespeed, 0, 0.5);
    
    if (input_check("down") && !grounded && sprite_index != spr_playerN_divebombfall && !grounded)
    {
        sprite_index = spr_playerN_divebombfall;
        vsp = 20;
        input_buffer_attack = 0;
        image_index = 0;
        exit;
    }
    
    if (grounded && sprite_index == spr_playerN_divebombfall)
    {
        image_index = 0;
        sprite_index = spr_playerN_divebombland;
    }
    
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_playerN_divebombland)
    {
        image_index = 0;
        sprite_index = spr_playerN_divebomb;
    }
    
    if (grounded && !input_check("down") && vsp >= 0 && sprite_index != spr_playerN_wallbounce)
    {
        vsp = -7;
        
        if (move != 0)
            xscale = move;
        
        with (instance_create_depth(x, y + 20, obj_player.depth, obj_balloonpop))
            sprite_index = spr_noisewalljumpeffect;
        
        sprite_index = spr_playerN_wallbounce;
        gamepad_set_vibration(0, 0.5, 0.5);
    }
    
    if (grounded && input_check("dash") && vsp >= 0 && sprite_index == spr_playerN_wallbounce)
    {
        if (move != 0)
            xscale = move;
        else if (savedmove != 0)
            xscale = savedmove;
        
        jumpstop = true;
        state = states.mach3;
        movespeed = 12;
        sprite_index = spr_mach4;
        scr_fmod_soundeffectONESHOT("event:/sfx/player/wallbounceland", x, y);
        
        with (instance_create_depth(x, y, obj_player.depth, obj_balloonpop))
        {
            sprite_index = spr_noisegrounddasheffect;
            image_xscale = other.xscale;
        }
        
        flash = true;
        image_index = 0;
        
        with (instance_create_depth(x, y, obj_player.depth, obj_crazyrunothereffect))
            image_xscale = other.xscale;
    }
    
    noisedoublejump = true;
    
    if (input_buffer_attack < 8 && input_check("up") && character == "N")
    {
        input_buffer_attack = 8;
        state = states.shoryuken;
        sprite_index = spr_shoryukenstart;
        image_index = 0;
        movespeed = abs(hsp);
        shoryukenvsp = -20;
        canuppercut = 0;
        scr_fmod_soundeffectONESHOT("event:/sfx/player/uppercut", x, y);
        
        with (instance_create_depth(x, y, 0, obj_highjumpcloud2))
            image_xscale = other.xscale;
        
        jumpAnim = 1;
        facehurt = 0;
        armhurt = 0;
        introscared = 0;
        
        repeat (4)
        {
            with (instance_create_depth(x + irandom_range(-40, 40), y + irandom_range(-40, 40), obj_player.depth, obj_balloonpop))
            {
                sprite_index = spr_shineeffect;
                image_speed = 0.35;
            }
        }
    }
    
    if (character == "N" && input_check("up") && input_buffer_jump < 8 && !input_check("down"))
    {
        freefallstart = 0;
        input_buffer_jump = 8;
        railmomentum = false;
        
        if (place_meeting(x, y + 1, obj_grindrail))
            railmomentum = true;
        
        scr_player_do_noisecrusher();
    }
    
    if (grounded && !input_check("dash") && vsp >= 0 && sprite_index == spr_playerN_wallbounce)
    {
        state = states.normal;
        movespeed = abs(hsp);
        scr_fmod_soundeffectONESHOT("event:/sfx/player/wallbounceland", x, y);
    }
    
    if (sprite_index == spr_playerN_divebomb || sprite_index == spr_playerN_divebombland || sprite_index == spr_playerN_divebombfall)
    {
        if (!instance_exists(dashcloudid) && grounded)
        {
            with (instance_create_depth(x, y, obj_player.depth, obj_dashcloud))
            {
                image_xscale = other.move;
                other.dashcloudid = id;
            }
        }
        
        image_speed = (abs(movespeed) / 40) + 0.4;
    }
    else
        image_speed = 0.5;
    
    if (punch_afterimage > 0)
        punch_afterimage--;
    else
    {
        punch_afterimage = 5;
        
        if (grounded && (sprite_index == spr_playerN_divebomb || sprite_index == spr_playerN_divebombland || sprite_index == spr_playerN_divebombfall))
        {
            repeat (2)
            {
                with (instance_create_depth(x + random_range(3, -3), y + 45, obj_player.depth, obj_debris))
                    sprite_index = spr_noisedrilldebris;
            }
        }
    }
    
    scr_noise_sidewayspin();
    scr_playertaunt();
}

function scr_noise_sidewayspin()
{
    if (input_buffer_attack < 8 && sprite_index == spr_playerN_wallbounce)
    {
        if (move != 0)
            xscale = move;
        
        input_buffer_attack = 8;
        machhitAnim = 0;
        image_index = 0;
        state = states.mach2;
        vsp = -5;
        movespeed = 12;
        instance_create_depth(x, y, 0, obj_crazyrunothereffect);
        sprite_index = spr_playerN_sidewayspin;
        image_index = 0;
    }
}
