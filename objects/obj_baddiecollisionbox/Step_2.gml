if (!instance_exists(baddieID))
{
    instance_destroy();
    exit;
}

x = baddieID.x;
y = baddieID.y;
image_xscale = baddieID.image_xscale;
image_yscale = baddieID.image_yscale;
persistent = baddieID.persistent;
var __player = instance_nearest(x, y, obj_player);

if (__player.character == "C")
    exit;

if (!place_meeting(x, y, __player) || __player.cutscene)
    exit;

if (__player.state == states.lunge)
{
    with (__player)
    {
        player_pummelhit();
        exit;
    }
}

if (baddieID.state != states.smallpepdash && baddieID.state != states.enemyhitstun)
{
    with (__player)
    {
        var _bid = other.baddieID;
        
        if (character == "S" && _bid.stuntouchbuffer <= 0 && (state == states.mach2 || state == states.mach3) && sprite_index != spr_jump)
        {
            instance_create_depth(_bid.x, _bid.y, 0, obj_bangeffect);
            _bid.stuntouchbuffer = 15;
            _bid.image_xscale = -xscale;
            _bid.state = states.seat;
            _bid.stompscale = 1.3;
            
            if (_bid.stunned < 100)
                _bid.stunned = 100;
            
            _bid.image_index = 0;
            _bid.hsp = -_bid.image_xscale * movespeed * 2;
            
            repeat (2)
            {
                with (instance_create_depth(x, y, 0, obj_slapstar))
                    vsp = irandom_range(-6, -11);
            }
        }
    }
}

if (__player.state != states.kungfu && __player.state != states.hurt)
{
    if (baddieID.state != states.smallpepdash && baddieID.state != states.enemyhitstun)
    {
        with (__player)
        {
            playerattacked = other.object_index;
            var _bid = other.baddieID;
            
            if (instakillmove && state != states.hitstun && !_bid.ishurt)
            {
                if ((state == states.mach3 && (character != "S" || character == "S")) || (state == states.machslide && character != "S" && (sprite_index == spr_machslideboost3 || sprite_index == spr_machslideboost3end)) || state == states.knightpep || state == states.knightpepslopes || (state == states.barrel && (sprite_index == spr_barrelroll || sprite_index == spr_barrelslipnslide)) || state == states.tumble || state == states.weeniemount || state == states.cheeseball || state == states.fireass)
                {
                    with (_bid)
                    {
                        if (hp <= 0)
                            instance_create_depth(x, y, -1, obj_genericpoofeffect);
                        
                        instance_create_depth(x, y, 1, obj_bangeffect);
                        instance_create_depth(x, y, 1, obj_parryeffect);
                        hp = 0;
                        scr_enemygibs();
                        alarm[3] = 3;
                        alarm[1] = 5;
                        image_index = 0;
                        thrown = true;
                        scr_fmod_soundeffectONESHOT("event:/sfx/enemy/punched", x, y);
                    }
                    
                    machpunchAnim = 1;
                    
                    if (!grounded && input_check("jump") && !rocket)
                        vsp = -11;
                    
                    if (state == states.mach3 && sprite_index != spr_mach3hit && sprite_index != spr_crazyrun && !rocket && sprite_index != spr_player_sjumpcancel)
                    {
                        sprite_index = spr_mach3hit;
                        image_index = 0;
                    }
                    
                    if (state == states.knightpepslopes)
                        _bid.killedbyknightslide = true;
                    
                    if (hitstunstoredstate == states.fireass)
                        _bid.killedbyfireassstoredsprite = hitstunstoredsprite;
                    
                    gamepadvibrate(1, 0, 15);
                    do_hitstun(global.mach3hitstun);
                    instance_destroy(_bid);
                    exit;
                }
                else
                {
                    _bid.sprite_index = _bid.stunfallspr;
                    _bid.flash = 1;
                    _bid.hp -= 1;
                    
                    with (_bid)
                        scr_enemygibs();
                    
                    scr_fmod_soundeffectONESHOT("event:/sfx/enemy/punched", x, y);
                    instance_create_depth(_bid.x, _bid.y, -1, obj_parryeffect);
                    
                    if (state == states.mach3 && sprite_index != spr_mach3hit && !rocket && sprite_index != spr_player_sjumpcancel)
                    {
                        sprite_index = spr_mach3hit;
                        image_index = 0;
                    }
                    
                    camera_shake(3, 3);
                    machpunchAnim = true;
                    _bid.thrown = true;
                    _bid.state = states.seat;
                    _bid.stunned = 100;
                    _bid.image_xscale = -xscale;
                    
                    if (state != states.shoulderbash)
                    {
                        _bid.vsp = -4;
                        _bid.hsp = -_bid.image_xscale * 10;
                        
                        if (_bid.hitfactor < 12)
                            _bid.hitfactor += 4;
                    }
                    
                    if (input_check("jump"))
                    {
                        if (!grounded && state != states.freefall && state != states.superslam && !rocket && sprite_index != spr_freefall && sprite_index != spr_facestomp)
                            vsp = -11;
                    }
                    else if (!grounded && vsp > 0 && state != states.nwalljump && state != states.superslam && state != states.freefall && state != states.firemouth && sprite_index != spr_freefall && sprite_index != spr_facestomp)
                        vsp = 0;
                    
                    do_hitstun(global.mach2hitstun);
                    gamepadvibrate(0.7, 0, 7);
                    restore_combo();
                    _bid.ishurt = true;
                    
                    if (_bid.hp <= 0)
                    {
                        if (hitstunstoredstate == states.superslam)
                        {
                            var _grabbedind = noone;
                            
                            with (obj_baddie)
                            {
                                if (grabbedby == other.id)
                                    _grabbedind = object_index;
                            }
                            
                            _bid.killedwithbypiledrive = _grabbedind;
                        }
                    }
                    
                    if (state == states.freefall || sprite_index == spr_freefall || sprite_index == spr_facestomp)
                        other.alarm[0] = 60;
                    else
                        other.alarm[0] = global.mach2hitstun + 8;
                    
                    if (character == "S" || _bid.hp <= 0 || hitstunstoredstate == states.freefall || hitstunstoredstate == states.shoryuken || hitstunstoredstate == states.superslam || hitstunstoredstate == states.firemouth || hitstunstoredstate == states.slipbanan || hitstunstoredstate == states.nwalljump || hitstunstoredstate == states.noisecrusher || hitstunstoredsprite != spr_freefall || hitstunstoredsprite != spr_facestomp)
                    {
                        instance_create_depth(_bid.x, _bid.y, 1, obj_bangeffect);
                        instance_destroy(_bid);
                        instance_destroy(other.id);
                        exit;
                    }
                }
            }
            
            if ((_bid.state == states.seat || _bid.state == states.tackleold) && state == states.normal && global.currentbadge == badge.kungfu && !_bid.thrown && !_bid.ishurt)
            {
                _bid.state = states.smallpepdash;
                _bid.grabbedby = id;
                state = states.kungfugrab;
                scr_fmod_soundeffectONESHOT("event:/sfx/player/grabthing", x, y);
            }
            
            if (!grounded && y < _bid.y && !attacking && vsp > 0 && _bid.vsp >= 0 && sprite_index != spr_mach2jump && sprite_index != spr_swingding && sprite_index != spr_swingdingend && sprite_index != spr_stompprep && (state == states.jump || state == states.pogo || state == states.smallpep || state == states.grab))
            {
                if (x != _bid.x)
                    _bid.image_xscale = -sign(_bid.x - x);
                
                _bid.state = states.seat;
                
                if (_bid.stunned < 100)
                    _bid.stunned = 100;
                
                _bid.image_index = 0;
                _bid.stompscale = 0.5;
                instance_create_depth(x, y + 50, 0, obj_stompeffect);
                stompAnim = true;
                
                if (state != states.pogo)
                    vsp = -9 - (5 * input_check("jump"));
                else
                    vsp = 0;
                
                if (state != states.grab && state != states.pogo)
                {
                    image_index = 0;
                    
                    if (global.smallpep)
                        sprite_index = spr_smallstompprep;
                    else
                        sprite_index = spr_stompprep;
                }
                
                scr_fmod_soundeffectONESHOT("event:/sfx/player/stomp", x, y);
            }
            
            if (_bid.state != states.smallpepdash && (state == states.superslam || state == states.freefall))
            {
                _bid.sprite_index = _bid.stunfallspr;
                _bid.flash = 1;
                
                with (_bid)
                    scr_enemygibs();
                
                camera_shake(4, 2);
                add_combo();
                _bid.thrown = true;
                _bid.state = states.seat;
                scr_fmod_soundeffectONESHOT("event:/sfx/enemy/punched", x, y);
                _bid.hp -= 1;
                
                if (_bid.stunned < 100)
                    _bid.stunned = 100;
                
                instance_create_depth(x, y, 0, obj_bumpeffect);
                instance_create_depth(_bid.x, _bid.y, 0, obj_bangeffect);
                _bid.vsp = -8;
                _bid.hsp = xscale * 10;
                do_hitstun(global.mach2hitstun);
            }
            
            if (sprite_index == spr_swingding && _bid.state != states.smallpepdash)
            {
                if (state != states.parrying)
                {
                    if (vsp > 0)
                        vsp = 0;
                    
                    instance_create_depth(x, y, 1, obj_parryeffect);
                    camera_shake(3, 3);
                    do_hitstun(global.mach2hitstun);
                }
                
                var _bbx = other.id;
                
                with (_bid)
                {
                    sprite_index = stunfallspr;
                    scr_enemygibs();
                    camera_shake(3, 3);
                    instance_destroy(_bid);
                    instance_destroy(_bbx);
                }
            }
        }
    }
}
