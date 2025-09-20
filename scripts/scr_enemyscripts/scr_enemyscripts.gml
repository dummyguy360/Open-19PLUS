function scr_enemygibs(_repeat = 3, _x = x, _y = y)
{
    repeat (_repeat)
    {
        instance_create_depth(x, y, -1, obj_slapstar);
        instance_create_depth(x, y, -1, obj_baddiegibs);
    }
}

function scr_enemycorpse(_spr = spr_dead, _palspr = enemypalette, _pal = global.enemypalette, _x = x, _y = y)
{
    with (instance_create_depth(x, y, 0, obj_baddiedead))
    {
        sprite_index = _spr;
        palettespr = _palspr;
        pal = _pal;
    }
}

function scr_enemy_create()
{
    x_start = x;
    y_start = y;
    killed = 0;
    escape = 0;
    active = 1;
    toomuchalarm1 = 0;
    palette = 0;
    ishurt = 0;
    parried = 0;
    hitfactor = 0;
    hurttype = 0;
    stompscale = 0;
    hitboxID = noone;
    insupertaunt = 0;
    superhurt = 0;
    escapespawnID = noone;
    escapestun = true;
    stuntouchbuffer = 0;
    hitboxcreate = 0;
    enemypalette = -1;
    chargeeffectID = noone;
    throwhsp = 0;
    throwvsp = 0;
    pummelled = noone;
    scaredbuffer = 100;
    darkalpha = 1;
    killedbyfireassstoredsprite = noone;
    killedbyknightslide = false;
    killedwithbypiledrive = noone;
    playkillsound = true;
}

function scr_escapeenemy()
{
    if (killed == 1)
        instance_destroy();
    
    if (place_meeting(x, y, obj_swordhitbox) && visible)
    {
        if (hp > 0)
        {
            var __player = instance_place(x, y, obj_swordhitbox).playerid;
            
            if (hitfactor < 12)
                hitfactor += 4;
            
            hp = 0;
            scr_enemygibs();
            camera_shake(3, 3);
            image_xscale = -__player.xscale;
            alarm[3] = 3;
            restore_combo();
            alarm[1] = 5;
            grav = 0;
            thrown = 1;
            stunned = 10000;
            state = states.seat;
            parried = 1;
            
            with (__player)
            {
                if (sprite_index == spr_uppercutfinishingblow)
                {
                    other.throwhsp = 0;
                    other.throwvsp = -25;
                }
                else
                {
                    other.throwhsp = -other.image_xscale * 25;
                    other.throwvsp = 0;
                    other.y = y - 4;
                }
            }
            
            var _ray = fire_ray(x, y, __player.x, __player.y, 1, noone, noone, mask_index);
            
            if (!_ray.clear)
            {
                x = _ray.x;
                y = _ray.y;
            }
            
            if (scr_solid(x, y))
            {
                x = __player.x;
                y = __player.y;
            }
        }
    }
    
    if (insupertaunt)
    {
        hsp = 0;
        movespeed = 0;
        vsp = 0;
    }
    
    var targetplayer = instance_nearest(x, y, obj_player);
    var _x = targetplayer.x;
    var _y = targetplayer.y;
    var range = 400;
}

function scr_enemy_scared()
{
    if (state == states.enemyhitstun)
        exit;
    
    var p = instance_nearest(x, y, obj_player);
    
    if (p.x > (x - 400) && p.x < (x + 400) && y <= (p.y + 60) && y >= (p.y - 60))
    {
        if (state != states.tackleold && state != states.seat && (p.state == states.mach3 || p.state == states.knightpepslopes || p.state == states.lunge))
        {
            scaredbuffer = 100;
            hsp = 0;
            state = states.tackleold;
            image_index = 0;
            sprite_index = scaredspr;
            
            if (x != p.x)
                image_xscale = -sign(x - p.x);
            
            if (grounded)
                vsp = -3;
            
            if (irandom(8) == 2)
                scr_fmod_soundeffectONESHOT("event:/sfx/enemy/scream", x, y);
        }
    }
}

function enemy_palettepoof()
{
    if (!global.enemypalette && global.stylethreshold >= 2)
    {
        global.enemypalette = 1;
        
        with (obj_baddie)
            instance_create_depth(x, y, -1, obj_genericpoofeffect);
    }
    else if (global.enemypalette && global.stylethreshold < 2)
    {
        global.enemypalette = 0;
        
        with (obj_baddie)
            instance_create_depth(x, y, -1, obj_genericpoofeffect);
    }
}
