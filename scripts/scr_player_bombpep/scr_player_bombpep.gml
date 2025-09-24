function scr_player_bombpep()
{
    collide_destructibles = function(_h, _v)
    {
        if (state != states.bombpep)
            exit;
        
        if (scr_destroy_horizontal(_h, destroy.ratblock | destroy.whitelist_destructibles | destroy.whitelist_onewaybigblock | destroy.whitelist_smbitembox))
        {
            instance_create_depth(x, y, 0, obj_bombexplosion2);
            movespeed = 4;
            vsp = -10;
            grounded = false;
            state = states.bombknockback;
            bombpeptimer = 0;
        }
    };
    
    hit_horizontal = function(_h)
    {
        if (sign(_h) == xscale && state == states.bombpep)
        {
            instance_create_depth(x + 10, y + 10, 0, obj_bumpeffect);
            xscale *= -1;
        }
    };
    
    if (input_check_pressed("jump"))
        input_buffer_jump = 0;
    
    if (!input_check("jump") && !jumpstop && vsp < 0.5 && !stompAnim)
    {
        vsp /= 2;
        jumpstop = 1;
    }
    
    if (grounded && vsp > 0)
        jumpstop = 0;
    
    mach2 = 0;
    landAnim = 0;
    
    if (sprite_index == spr_bombpepintro && floor(image_index) == (image_number - 1))
    {
        scr_tiptext(string_get("tips/transfo/bombpep"), "bombtip");
        sprite_index = spr_bombpeprun;
    }
    
    if (sprite_index == spr_bombpeprun || sprite_index == spr_bombpeprunabouttoexplode)
    {
        if (movespeed <= 8)
            movespeed += 0.2;
        
        move = input_check_opposing("left", "right");
        
        if (grounded)
        {
            if (move != 0 && !instance_exists(obj_bumpeffect))
                xscale = move;
        }
        
        hsp = floor(xscale * movespeed);
    }
    else
    {
        hsp = 0;
        movespeed = 0;
    }
    
    if (bombpeptimer < 20 && bombpeptimer != 0)
        sprite_index = spr_bombpeprunabouttoexplode;
    
    if (sprite_index == spr_bombpepend && floor(image_index) == (image_number - 1))
    {
        alarm[5] = 2;
        alarm[7] = 60;
        hurted = 1;
        state = states.normal;
        sprite_index = spr_idle;
        image_index = 0;
    }
    
    if (bombpeptimer == 0 && sprite_index == spr_bombpeprunabouttoexplode)
    {
        scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/bombpepexplode", x, y);
        instance_create_depth(x, y, 0, obj_bombexplosion);
        sprite_index = spr_bombpepend;
    }
    
    if (bombpeptimer > 0)
        bombpeptimer -= 0.5;
    
    if (input_buffer_jump < 8 && grounded && hsp != 0)
        vsp = -10.2;
    
    if (movespeed < 4)
        image_speed = 0.35;
    else if (movespeed > 4 && movespeed < 8)
        image_speed = 0.45;
    else
        image_speed = 0.6;
    
    if (hsp != 0 && (floor(image_index) == 0 || floor(image_index) == 2) && steppy == 0 && grounded)
        steppy = 1;
    
    if (floor(image_index) != 0 && floor(image_index) != 2)
        steppy = 0;
    
    if (character != "N")
    {
        if (input_buffer_attack < 8 && sprite_index != spr_bombpepend && state == states.bombpep)
        {
            input_buffer_attack = 8;
            move = input_check_opposing("left", "right");
            
            if (sprite_index == spr_bombpepintro && move != 0)
                xscale = move;
            
            if (input_check("up"))
            {
                image_index = 6;
                sprite_index = spr_uppercutfinishingblow;
                scr_fmod_soundeffectONESHOT("event:/sfx/player/killingblow", x, y);
            }
            else
            {
                image_index = 0;
                sprite_index = spr_throw;
                scr_fmod_soundeffectONESHOT("event:/sfx/player/mach/rollgetup", x, y);
            }
            
            state = states.stunned;
            
            with (instance_create_depth(x - 3, y, 0, obj_bomb))
            {
                drop = 1;
                
                if (!input_check("up"))
                {
                    hsp = other.xscale * 10;
                    vsp = -10;
                }
                else
                    vsp = -22;
                
                countdown = 100;
                spawner = other.bombspawnerid;
            }
        }
    }
    
    if (character == "N")
    {
        if (input_buffer_attack < 8 && sprite_index != spr_bombpepend && state == states.bombpep)
        {
            input_buffer_attack = 8;
            move = input_check_opposing("left", "right");
            
            if (sprite_index == spr_bombpepintro && move != 0)
                xscale = move;
            
            if (input_check("up"))
            {
                image_index = 6;
                sprite_index = spr_uppercutfinishingblow;
                scr_fmod_soundeffectONESHOT("event:/sfx/player/killingblow", x, y);
            }
            else
            {
                image_index = 1;
                sprite_index = spr_playerN_noisebombkick;
                scr_fmod_soundeffectONESHOT("event:/sfx/enemy/punched", x, y);
            }
            
            state = states.stunned;
            
            with (instance_create_depth(x - 3, y, 0, obj_bomb))
            {
                drop = 1;
                
                if (!input_check("up"))
                {
                    hsp = other.xscale * 20;
                    vsp = -5;
                }
                else
                    vsp = -22;
                
                countdown = 100;
                spawner = other.bombspawnerid;
            }
        }
    }
    
    if (!instance_exists(obj_dashcloud) && grounded && hsp != 0)
    {
        with (instance_create_depth(x, y, 0, obj_dashcloud))
            image_xscale = other.xscale;
    }
}
