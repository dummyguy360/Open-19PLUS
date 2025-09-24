function scr_player_jump()
{
    var _analogue = input_value("left") + input_value("right");
    
    collide_destructibles = function(_h, _v)
    {
        if ((sprite_index == spr_freefall || sprite_index == spr_facestomp) && _v >= 0)
            scr_destroy_vertical(_v);
    };
    
    hit_vertical = function(_v)
    {
        if (_v < 0)
            scr_destroy_vertical(_v);
    };
    
    hit_horizontal = function(_h)
    {
        if (sign(_h) != xscale || state != states.jump)
            exit;
        
        if (character == "S")
        {
            if (momemtum && snickmach2mode && input_check("dash"))
            {
                sprite_index = spr_machclimbwall;
                wallspeed = movespeed;
                state = states.climbwall;
            }
            else
            {
                movespeed = 0;
                momemtum = 0;
            }
        }
        else
        {
            movespeed = 0;
            mach2 = 0;
            momemtum = 0;
        }
    };
    
    var _suplexanim = spr_suplexgrabjumpstart;
    
    if (global.currentpowerup == powerup.shotgun)
        _suplexanim = spr_shotgunsuplexdash;
    
    if (!momemtum)
        hsp = (move * (movespeed * _analogue)) + additionalhsp;
    else
        hsp = (xscale * movespeed) + additionalhsp;
    
    if (dir != xscale && !momemtum)
    {
        dir = xscale;
        movespeed = 2;
    }
    
    if (move != xscale && !momemtum)
        movespeed = 2;
    
    move = input_check_opposing("left", "right");
    snickmach3mode = 0;
    
    if (move == -xscale)
    {
        momemtum = 0;
        snickmach2mode = 0;
    }
    
    if (!momemtum)
    {
        if (move != 0 && movespeed < 8)
            movespeed += 0.5;
        
        if (movespeed > 8)
            movespeed -= 0.1;
    }
    
    if (dir != xscale)
        dir = xscale;
    
    landAnim = 1;
    
    if (!input_check("jump") && !jumpstop && vsp < 0.5 && !stompAnim && bumped != 1)
    {
        vsp /= 10;
        jumpstop = 1;
    }
    
    if (ladderbuffer > 0)
        ladderbuffer--;
    
    if (scr_solid(x, y - 1) && !jumpstop && jumpAnim && bumped != 1)
    {
        vsp = grav;
        jumpstop = 1;
    }
    
    if (bumped != 1 && grounded && input_buffer_jump < 8 && !input_check("down") && !input_check("dash") && vsp > 0 && !(sprite_index == spr_player_facestomp || sprite_index == spr_player_freefall))
    {
        scr_fmod_soundeffect(char_jumpsnd, x, y);
        sprite_index = spr_jump;
        
        if (global.currentpowerup == powerup.shotgun)
            sprite_index = spr_shotgunjump;
        
        instance_create_depth(x, y, 0, obj_highjumpcloud2);
        stompAnim = 0;
        
        if (character != "N")
            vsp = -11;
        else
            vsp = -10;
        
        state = states.jump;
        noisedoublejumped = 0;
        jumpAnim = 1;
        jumpstop = 0;
        image_index = 0;
        freefallstart = 0;
    }
    
    if (input_check_pressed("jump") && bumped != 1)
        input_buffer_jump = 0;
    
    if (vsp > 5)
        fallinganimation++;
    
    if (fallinganimation >= 40 && fallinganimation < 80)
        sprite_index = spr_facestomp;
    
    if (fallinganimation >= 80)
        sprite_index = spr_freefall;
    
    if (!stompAnim)
    {
        if (jumpAnim)
        {
            if (floor(image_index) == (image_number - 1))
                jumpAnim = 0;
        }
        
        if (!jumpAnim)
        {
            if (sprite_index == spr_airdash1)
                sprite_index = spr_airdash2;
            
            if (sprite_index == spr_shotgunjump)
                sprite_index = spr_shotgunfall;
            
            if (sprite_index == spr_jump)
                sprite_index = spr_fall;
            
            if (sprite_index == spr_shotgunjump1)
                sprite_index = spr_shotgunjump2;
            
            if (sprite_index == spr_shotgun_shootair)
                sprite_index = spr_shotgunfall;
            
            if (sprite_index == spr_suplexgrabcancel)
                sprite_index = spr_fall;
            
            if (sprite_index == spr_airjugglestart)
                sprite_index = spr_airjuggle;
            
            if (sprite_index == spr_bodyslamjump)
                sprite_index = spr_fall;
            
            if (sprite_index == spr_player_pistoljump)
                sprite_index = spr_player_pistolfall;
            
            if (sprite_index == spr_player_mortdoublejump)
            {
                sprite_index = spr_fall;
                instance_create_depth(x, y, -50, obj_mortfollow);
            }
        }
    }
    
    if (stompAnim)
    {
        if (sprite_index == spr_stompprep && floor(image_index) == (image_number - 1))
            sprite_index = spr_stomp;
    }
    
    if (sprite_index == spr_bodyslamjump)
    {
        if (steppy > 0)
            steppy--;
        else
        {
            instance_create_depth(x + irandom_range(-25, 25), y + irandom_range(-10, 35), 1, obj_cloudeffect);
            steppy = 8;
        }
    }
    
    if (global.currentpowerup == powerup.mort && !mortjump && input_check_pressed("jump") && sprite_index != spr_player_mortdoublejump && sprite_index != spr_player_mortjump)
    {
        mortjump = 1;
        stompAnim = 0;
        sprite_index = spr_player_mortdoublejump;
        image_index = 0;
        vsp = -11;
        jumpstop = 0;
        jumpAnim = 1;
        instance_destroy(obj_mortfollow);
    }
    
    if (sprite_index == spr_player_jugglestart && floor(image_index) == (image_number - 1))
    {
        sprite_index = spr_player_juggle;
        jumpAnim = 0;
        stompAnim = 0;
        image_index = 0;
    }
    
    if (sprite_index == spr_player_backattack && floor(image_index) == (image_number - 1))
    {
        sprite_index = spr_fall;
        jumpAnim = 0;
        stompAnim = 0;
        image_index = 0;
    }
    
    if (input_check("groundpound"))
    {
        if (global.currentpowerup != powerup.shotgun)
        {
            movespeed *= _analogue;
            image_index = 0;
            state = states.freefallprep;
            sprite_index = spr_bodyslamstart;
            vsp = -6;
            fmod_studio_event_instance_start(groundpoundfallsnd);
        }
        else
        {
            scr_fmod_soundeffectONESHOT("event:/sfx/player/killingblow", x, y);
            image_index = 0;
            state = states.freefallprep;
            sprite_index = spr_shotgunjump1;
            vsp = -5;
            
            with (instance_create_depth(x, y, 0, obj_shotgunblast))
                sprite_index = spr_shotgunblastdown;
            
            for (var i = 0; i < 2; i += 1)
            {
                with (instance_create_depth(x + (xscale * 30), y + 60, 0, obj_shotgunbullet))
                {
                    var e = 0;
                    sprite_index = spr_shotgunbulletdown;
                    spdh = -10;
                    
                    switch (i)
                    {
                        case 0:
                            e = 0;
                            break;
                        
                        case 1:
                            e = 5;
                            break;
                        
                        case 2:
                            e = -5;
                            break;
                    }
                    
                    spd = e;
                }
            }
        }
    }
    
    if (move != 0)
        xscale = move;
    
    image_speed = (sprite_index != spr_suplexgrabcancel) ? 0.35 : 0.5;
    
    if (grounded && (sprite_index == spr_facestomp || sprite_index == spr_freefall))
    {
        if (instance_exists(obj_baddie))
        {
            with (obj_baddie)
            {
                if (bbox_in_camera(1, id) && grounded)
                {
                    vsp = -7;
                    hsp = 0;
                    stunned = 200;
                    state = states.seat;
                }
            }
        }
        
        camera_shake(10, 30);
        gamepadvibrate(0.7, 0, 15);
        scr_fmod_soundeffectONESHOT("event:/sfx/player/groundpound", x, y);
        image_index = 0;
        sprite_index = spr_freefallland;
        state = states.freefallland;
    }
    
    if (input_buffer_attack < 8 && character != "S" && bumped != 1 && !input_check("up"))
    {
        input_buffer_attack = 8;
        
        if (global.currentbadge == badge.kungfu)
        {
            if (!kungfumove)
            {
                kungfumove = true;
                state = states.kungfu;
                scr_fmod_soundeffectONESHOT("event:/sfx/player/kungfu", x, y);
                
                if (movespeed < 10)
                    movespeed = 10;
                
                if (vsp > 0)
                    vsp = 0;
                
                if (grounded)
                    sprite_index = choose(spr_kungfu1, spr_kungfu2, spr_kungfu3);
                else
                    sprite_index = choose(spr_kungfuair1start, spr_kungfuair2start, spr_kungfuair3start);
                
                image_index = 0;
            }
        }
        else
        {
            suplexmove = 1;
            fmod_studio_event_instance_start(suplexdashsnd);
            state = states.suplexgrab;
            image_index = 0;
            sprite_index = _suplexanim;
            movespeed = 6;
            momemtum = 1;
        }
    }
    
    if ((character == "P" || character == "N") && input_check("up") && canuppercut && input_buffer_attack < 8)
    {
        input_buffer_attack = 8;
        state = states.shoryuken;
        sprite_index = spr_shoryukenstart;
        image_index = 0;
        
        if (hsp > 0)
            hsp = movespeed;
        
        if (hsp < 0)
            hsp = -movespeed;
        
        if (character == "N")
            shoryukenvsp = -21;
        else
            shoryukenvsp = -10;
        
        if (character == "N")
        {
            repeat (4)
            {
                with (instance_create_depth(x + irandom_range(-40, 40), y + irandom_range(-40, 40), obj_player.depth, obj_balloonpop))
                {
                    sprite_index = spr_shineeffect;
                    image_speed = 0.35;
                }
            }
        }
        
        canuppercut = 0;
        scr_fmod_soundeffectONESHOT("event:/sfx/player/uppercut", x, y);
        
        with (instance_create_depth(x, y, 0, obj_highjumpcloud2))
            image_xscale = other.xscale;
        
        jumpAnim = 1;
        facehurt = 0;
        armhurt = 0;
        introscared = 0;
    }
    
    if (!input_check("dash") || move != xscale)
        mach2 = 0;
    
    if (grounded && fallinganimation < 40)
    {
        if (input_check("dash") && !place_meeting(x + xscale, y, obj_solid))
        {
            if (movespeed < 6)
                movespeed = 6;
            
            sprite_index = spr_mach1;
            state = states.mach2;
            image_index = 0;
            jumpAnim = 1;
            facehurt = 0;
            armhurt = 0;
            introscared = 0;
        }
        else if (vsp > 0)
        {
            movespeed *= _analogue;
            scr_fmod_soundeffectONESHOT("event:/sfx/player/step", x, y);
            state = states.normal;
            jumpAnim = 1;
            jumpstop = 0;
            image_index = 0;
            freefallstart = 0;
        }
    }
    
    scr_playertaunt();
    
    if (input_check_pressed("shoot") && global.currentpowerup == powerup.pistol)
    {
        state = states.gunshoot;
        sprite_index = spr_player_gunshoot;
        image_index = 0;
        
        with (instance_create_depth(x, y + 7, 0, obj_pistolgunbullet))
        {
            if (!input_check("up"))
            {
                dir = xscale_angle(other.xscale);
                x += (10 * other.xscale);
            }
            else
            {
                dir = 90;
                y -= 17;
                other.sprite_index = spr_player_gunshootup;
            }
            
            if (other.object_index == obj_player)
                playerid = 1;
        }
        
        camera_shake(3, 3);
        scr_fmod_soundeffect(revolversnd, x, y);
    }
    
    if (character == "N" && input_check("up") && input_check_pressed("jump") && !input_check("down"))
        scr_player_do_noisecrusher();
    
    throwmort();
}
