function scr_player_noisecrusher()
{
    image_speed = 0.35;
    
    collide_destructibles = function(_h, _v)
    {
        if (_v >= 0)
            scr_destroy_vertical(_v, destroy.metalblock);
    };
    
    if (sprite_index == spr_playerN_noisecrusherland)
    {
        hsp = 0;
        vsp = 0;
        movespeed = 0;
        
        if (floor(image_index) == (image_number - 1))
            state = states.normal;
        
        exit;
    }
    
    if (vsp > 0)
        vsp += 0.5;
    
    hsp = movespeed * xscale;
    move = input_check("right") - input_check("left");
    
    if (move != 0)
        movespeed = Approach(movespeed, move * 8 * xscale, 0.5);
    else
        movespeed = Approach(movespeed, 0, 0.5);
    
    if (sprite_index != spr_playerN_noisecrusherstart && sprite_index != spr_playerN_noisecrusherland && sprite_index != spr_playerN_noisecrusherfall)
    {
        sprite_index = spr_playerN_noisecrusherstart;
        image_index = 0;
    }
    
    if (sprite_index == spr_playerN_noisecrusherstart && floor(image_index) == (image_number - 1))
        sprite_index = spr_playerN_noisecrusherfall;
    
    if (input_buffer_attack < 8 && !grounded)
    {
        image_speed = 0.5;
        
        if (input_buffer_attack < 8)
            input_buffer_attack = 8;
        
        if (move != 0)
            xscale = move;
        
        machhitAnim = 0;
        image_index = 0;
        state = states.mach2;
        vsp = -5;
        movespeed = 12;
        instance_create_depth(x, y, 0, obj_crazyrunothereffect);
        sprite_index = spr_playerN_sidewayspin;
        image_index = 0;
        
        with (instance_create_depth(x, y, obj_player.depth, obj_crazyrunothereffect))
            image_xscale = other.xscale;
        
        return true;
    }
    
    if (grounded && vsp > 0 && !place_meeting(x, y + vsp, obj_destructibles) && !place_meeting(x, y + 15, obj_destructibles) && !place_meeting(x, y + 15, obj_metalblock) && !place_meeting(x, y + vsp + 5, obj_metalblock) && !place_meeting(x, y + 15, obj_grindrail))
    {
        with (instance_create_depth(x - 10, y, obj_player.depth, obj_parryeffect))
        {
            sprite_index = spr_ratdust;
            hspeed = -5;
        }
        
        with (instance_create_depth(x + 10, y, obj_player.depth, obj_parryeffect))
        {
            image_xscale = -1;
            sprite_index = spr_ratdust;
            hspeed = 5;
        }
        
        sprite_index = spr_playerN_noisecrusherland;
        instance_create_depth(x, y, depth + 1, obj_slamcloud);
        scr_fmod_soundeffectONESHOT("event:/sfx/player/groundpound", x, y);
        
        if (instance_exists(obj_baddie))
        {
            with (obj_baddie)
            {
                if (grounded && visible && bbox_in_camera(1, id))
                {
                    vsp = -11;
                    hsp = 0;
                    stunned = 200;
                    state = states.seat;
                }
            }
        }
        
        if (instance_exists(obj_slipnslide))
        {
            with (obj_slipnslide)
            {
                if (grounded && baddieID != noone && bbox_in_camera(1, id))
                {
                    instance_destroy();
                    
                    with (instance_create_depth(x, y, -100, obj_baddiedead))
                        sprite_index = other.sprite_index;
                }
            }
        }
        
        gamepadvibrate(0.7, 0, 15);
        camera_shake(5, 15);
    }
    
    scr_playertaunt();
    
    if (sprite_index != spr_playerN_noisecrusherland)
        blurafterimageeffect(3, 0.05);
}

function scr_player_do_noisecrusher()
{
    input_buffer_jump = 0;
    movespeed = hsp * xscale;
    state = states.noisecrusher;
    sprite_index = spr_playerN_noisecrusherstart;
    scr_fmod_soundeffectONESHOT("event:/sfx/player/noisecrusher", x, y);
    image_index = 0;
    vsp = -16;
}
