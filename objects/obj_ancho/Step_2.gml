prevy = y;
event_inherited();

switch (state)
{
    case states.tackleold:
        scr_enemy_idle();
        break;
    
    case states.timesup:
        scr_enemy_charge();
        break;
    
    case states.weeniemount:
        scr_enemy_turn();
        break;
    
    case states.homingattack:
        scr_enemy_walk();
        break;
    
    case states.start:
        scr_enemy_land();
        break;
    
    case states.swingdingfinish:
        scr_enemy_hit();
        break;
    
    case states.seat:
        scr_enemy_stun();
        break;
    
    case states.ramp:
        scr_enemy_throw();
        break;
    
    case states.smallpepdash:
        scr_enemy_grabbed();
        break;
    
    case states.enemyhitstun:
        scr_enemy_hitstun();
        break;
}

enemy_palettepoof();

if (state == states.seat && stunned > 100 && birdcreated == 0)
{
    birdcreated = 1;
    
    with (instance_create_depth(x, y, 0, obj_enemybird))
        ID = other.id;
}

if (state == states.enemyhitstun)
    exit;

if (state != states.seat)
    birdcreated = 0;

if (state == states.homingattack)
{
    if (y != attackpos && y == prevy)
    {
        var _raycheck = fire_ray(x, y, x, attackpos, 1, noone, noone, mask_index);
        
        if (!_raycheck.clear)
            attackpos = _raycheck.y;
    }
    
    if (y > attackpos || !scr_solid(x, y + 1))
        y = Approach(y, attackpos, 1);
}

if (state == states.seat)
    grav = 0.5;
else
    grav = 0;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

scr_escapeenemy();
var __player = instance_nearest(x, y, obj_player);

if (__player.x > (x - 400) && __player.x < (x + 400) && y <= (__player.y + 60) && y >= (__player.y - 60))
{
    if (state != states.tackleold && state != states.timesup && __player.state == states.mach3)
    {
        state = states.tackleold;
        sprite_index = scaredspr;
        
        if (x != __player.x)
            image_xscale = -sign(x - __player.x);
    }
}

if (sprite_index == spr_ancho_chargestart && floor(image_index) == (image_number - 1))
{
    if (hitboxcreate == 0 && visible == 1 && state == states.timesup)
    {
        hitboxcreate = 1;
        
        with (instance_create_depth(x, y, 0, obj_forkhitbox))
            ID = other.id;
    }
    
    sprite_index = spr_ancho_charge;
    movespeed = 10;
}

var _cancharge = y == attackpos;

if (x != __player.x && _cancharge && visible)
{
    if (__player.x > (x - 200) && __player.x < (x + 200) && y <= (__player.y + 50) && y >= (__player.y - 50))
    {
        if (state == states.homingattack)
        {
            image_index = 0;
            image_xscale = -sign(x - __player.x);
            state = states.timesup;
            sprite_index = spr_ancho_chargestart;
            scr_fmod_soundeffectONESHOT("event:/sfx/enemy/charge", x, y);
        }
    }
    
    if (__player.x > (x - 200) && __player.x < (x + 200) && y <= (__player.y + 200) && y >= (__player.y - 200))
    {
        if (state != states.timesup && state != states.tackleold && global.stylethreshold >= 2 && __player.state != states.sjump && !scr_transformationcheck())
        {
            for (var i = 0; i < 4; i++)
            {
                with (instance_create_depth(x, y, 0, obj_baddiemach3effect))
                {
                    baddieid = other.id;
                    image_index = other.image_index;
                    image_xscale = other.image_xscale;
                    sprite_index = other.sprite_index;
                    alpha = 0.5;
                    alarm[0] = 8;
                    
                    if (i <= 1)
                        hspeed = 4 - (8 * (i == 1));
                    else
                        vspeed = 4 - (8 * (i == 3));
                }
            }
            
            charging = true;
            scr_fmod_soundeffectONESHOT("event:/sfx/enemy/charge", x, y);
            state = states.timesup;
            movespeed = 0;
            sprite_index = spr_ancho_rage1;
            image_index = 0;
            
            if (sign(__player.x - x) != 0)
                image_xscale = sign(__player.x - x);
        }
    }
}

if (state == states.seat || state == states.homingattack)
    movespeed = 0;

if (state != states.seat)
    thrown = 0;

if (boundbox == 0)
{
    with (instance_create_depth(x, y, 0, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index;
        mask_index = other.mask_index;
        baddieID = other.id;
        other.boundbox = 1;
    }
}
