function scr_player_shoulderbash()
{
    collide_destructibles = function(_h, _v)
    {
        scr_destroy_horizontal(_h, destroy.create_bangeffect);
    };
    
    hit_horizontal = function(_h)
    {
        if (sign(_h) != xscale)
            exit;
        
        if (grounded)
        {
            if (scr_bump_rat(_h))
                exit;
            
            scr_fmod_soundeffectONESHOT("event:/sfx/player/bump", x, y);
            jumpstop = 1;
            state = states.jump;
            vsp = -4;
            image_index = 0;
            instance_create_depth(x + (xscale * 10), y + 10, 0, obj_bumpeffect);
            sprite_index = spr_wallbump;
            gamepadvibrate(0.4, 0, 7);
            bumped = 1;
        }
        else
        {
            sprite_index = spr_player_climbwall;
            
            if (movespeed <= 10)
                wallspeed = 6;
            else
                wallspeed = movespeed;
            
            wallclimbtime = 10;
            state = states.climbwall;
        }
    };
    
    hsp = xscale * movespeed;
    move = input_check_opposing("left", "right");
    landAnim = 0;
    
    if (!inmach)
    {
        if (movespeed < 10 && grounded)
            movespeed += 0.5;
        else if (!grounded)
            movespeed = 10;
    }
    
    if (input_check_pressed("jump"))
        input_buffer_jump = 0;
    
    if (!input_check("jump") && !jumpstop && vsp < 0.5 && !stompAnim)
    {
        vsp /= 10;
        jumpstop = 1;
    }
    
    if (sprite_index == spr_airshoulderbashstart && floor(image_index) == (image_number - 1))
    {
        image_index = 0;
        sprite_index = spr_airshoulderbash;
    }
    
    if ((floor(image_index) == (image_number - 1) && sprite_index == spr_shoulderbash && grounded && input_check("dash")) || (grounded && vsp > 0 && sprite_index == spr_airshoulderbash))
    {
        image_speed = 0.35;
        
        if (character != "N" || (character == "N" && !pogo))
            state = states.mach2;
        
        if (character == "N" && pogo)
            state = states.normal;
    }
    
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_shoulderbash && grounded && !input_check("dash"))
    {
        image_speed = 0.35;
        state = states.normal;
        grav = 0.5;
        inmach = 0;
    }
    
    if (input_buffer_jump < 8 && (can_jump || coyotetime > 0) && !input_check("down"))
    {
        input_buffer_jump = 8;
        coyotetime = 0;
        grounded = false;
        jumpstop = 0;
        image_index = 0;
        vsp = -11;
        instance_create_depth(x, y, 0, obj_highjumpcloud2);
    }
    
    if (!grounded && sprite_index == spr_shoulderbash)
    {
        image_index = 0;
        sprite_index = spr_airshoulderbashstart;
    }
    
    if (input_check("down") && grounded)
    {
        suplexmove = 0;
        grav = 0.5;
        instance_create_depth(x, y, 0, obj_jumpdust);
        flash = 0;
        state = states.machroll;
        vsp = 10;
    }
    
    if (move != xscale && move != 0)
    {
        state = states.jump;
        sprite_index = spr_suplexgrabcancel;
        image_index = 0;
        jumpAnim = 1;
        movespeed = 0;
        hsp = 0;
        momemtum = 0;
        scr_fmod_soundeffectONESHOT("event:/sfx/player/grabcancel", x, y);
    }
    
    image_speed = 0.35;
    
    if (!instance_exists(obj_dashcloud) && grounded)
    {
        with (instance_create_depth(x, y, 0, obj_dashcloud))
            image_xscale = other.xscale;
    }
    
    blurafterimageeffect(3, 0.05);
    
    if (!instance_exists(obj_grabhitbox))
    {
        with (instance_create_depth(x, y, 0, obj_grabhitbox))
        {
            playerid = other.id;
            image_xscale = other.id.xscale;
        }
    }
}
