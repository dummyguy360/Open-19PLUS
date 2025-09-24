function scr_player_suplexgrab()
{
    collide_destructibles = function(_h, _v)
    {
        scr_destroy_horizontal(_h, destroy.create_bangeffect);
    };
    
    hit_vertical = function(_v) { };
    
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
            grounded = false;
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
    
    landAnim = 0;
    hsp = xscale * movespeed;
    move = input_check_opposing("left", "right");
    dir = xscale;
    
    if (!inmach)
    {
        if (movespeed < 10 && grounded)
            movespeed += 0.5;
        else if (!grounded)
            movespeed = 10;
    }
    
    if (!input_check("jump") && !jumpstop && vsp < 0.5 && !stompAnim)
    {
        vsp /= 10;
        jumpstop = 1;
    }
    
    if (move != xscale && move != 0 && sprite_index != spr_longjumpstart && sprite_index != spr_longjump)
    {
        state = states.jump;
        sprite_index = spr_suplexgrabcancel;
        image_index = 0;
        jumpAnim = 1;
        movespeed = 1;
        momemtum = 1;
        scr_fmod_soundeffectONESHOT("event:/sfx/player/grabcancel", x, y);
    }
    
    if ((floor(image_index) == (image_number - 1) || sprite_index == spr_suplexgrabjump || (sprite_index == spr_suplexgrabjumpstart && floor(image_index) == (image_number - 1))) && grounded && !input_check("dash") && vsp > 0)
    {
        image_speed = 0.35;
        state = states.normal;
        grav = 0.5;
        inmach = 0;
    }
    
    if ((floor(image_index) == (image_number - 1) || sprite_index == spr_suplexgrabjump || (sprite_index == spr_suplexgrabjumpstart && floor(image_index) == (image_number - 1))) && grounded && input_check("dash"))
    {
        image_speed = 0.35;
        
        if (movespeed < 12)
        {
            state = states.mach2;
            sprite_index = spr_mach;
        }
        
        if (movespeed >= 12)
        {
            state = states.mach3;
            sprite_index = spr_mach4;
        }
        
        grav = 0.5;
    }
    
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_suplexgrabjumpstart)
        sprite_index = spr_suplexgrabjump;
    
    if (input_buffer_attack < 8 && character != "N" && !input_check("down"))
    {
        input_buffer_attack = 8;
        suplexmove = 1;
        fmod_studio_event_instance_start(suplexdashsnd);
        image_index = 0;
        
        if (global.stylethreshold < 2)
        {
            state = states.shoulderbash;
            
            if (grounded)
                sprite_index = spr_shoulderbash;
            else
            {
                vsp = -5;
                sprite_index = spr_airshoulderbashstart;
            }
        }
        else
        {
            state = states.lunge;
            sprite_index = spr_player_ragelunge;
            
            if (!lunge)
                vsp = 0;
            
            if (movespeed < 11)
                movespeed = 11;
        }
        
        inmach = 1;
        momemtum = 1;
    }
    
    if (input_check("down") && grounded)
    {
        grav = 0.5;
        sprite_index = spr_crouchslip;
        machhitAnim = 0;
        state = states.crouchslide;
        
        if (movespeed < 12)
            movespeed = 12;
        
        rollbuffer = 20;
        fmod_studio_event_instance_start(divesnd);
    }
    
    if (!grounded && (sprite_index == spr_suplexdash || sprite_index == spr_shotgun_suplexdash))
    {
        image_index = 0;
        sprite_index = spr_suplexgrabjumpstart;
    }
    
    if (input_buffer_jump < 8 && (grounded || coyotetime > 0) && state != states.jump && !input_check("down"))
    {
        input_buffer_jump = 8;
        coyotetime = 0;
        grounded = false;
        jumpstop = 0;
        image_index = 0;
        longjumping = 1;
        longjumpspd = movespeed * xscale;
        vsp = -10;
        scr_fmod_soundeffect(longjumpsnd, x, y);
        instance_create_depth(x, y, 0, obj_highjumpcloud2);
        state = states.mach2;
        sprite_index = spr_longjumpstart;
    }
    
    if (!instance_exists(obj_slidecloud) && grounded && movespeed > 5)
    {
        with (instance_create_depth(x, y, 0, obj_slidecloud))
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
    
    image_speed = 0.35;
}
