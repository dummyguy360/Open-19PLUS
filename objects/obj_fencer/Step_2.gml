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

if (state != states.seat)
    birdcreated = 0;

if (state == states.enemyhitstun)
    exit;

scr_enemy_scared();
scr_escapeenemy();
hurttype = 1;

if (state != states.timesup)
    movespeed = 0;

var __player = instance_nearest(x, y, obj_player);

if (x != __player.x && grounded)
{
    if (__player.x > (x - 300) && __player.x < (x + 300) && y <= (__player.y + 60) && y >= (__player.y - 60))
    {
        if ((global.stylethreshold < 2 && state == states.homingattack && !charging) || (global.stylethreshold >= 2 && heatcharging == 0 && state != states.seat && state != states.smallpepdash && state != states.tackleold && !scr_transformationcheck()))
        {
            scr_fmod_soundeffectONESHOT("event:/sfx/enemy/charge", x, y);
            
            if (global.stylethreshold >= 2)
            {
                if (!heatcharging)
                {
                    with (instance_create_depth(x, y, 0, obj_forkhitbox))
                        ID = other.id;
                    
                    heatcharging = 60;
                    charging = 1;
                    state = states.timesup;
                    movespeed = 0;
                    sprite_index = spr_fencer_rage;
                    image_index = 0;
                    image_xscale = sign(__player.x - x);
                    
                    if (image_xscale == 0)
                        image_xscale = 1;
                }
            }
            else if (global.stylethreshold < 2)
            {
                with (instance_create_depth(x, y, 0, obj_forkhitbox))
                {
                    ID = other.id;
                    hurttype = 1;
                }
                
                charging = 1;
                state = states.timesup;
                movespeed = 5;
                vsp = -6;
                sprite_index = spr_fencer_chargestart;
            }
        }
    }
}

if (state == states.seat || state == states.homingattack)
{
    heatcharging = 0;
    charging = 0;
    movespeed = 0;
}

if (heatcharging && sprite_index != spr_fencer_rage)
    heatcharging--;

if (sprite_index == spr_fencer_chargestart && floor(image_index) == (image_number - 1))
    sprite_index = spr_fencer_charge;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (hitboxcreate == 0 && (state == states.homingattack || state == states.timesup))
{
    hitboxcreate = 1;
    
    with (instance_create_depth(x, y, 0, obj_forkhitbox))
    {
        ID = other.id;
        hurttype = 1;
    }
}

if (state != states.seat)
    thrown = 0;

if (boundbox == 0)
{
    with (instance_create_depth(x, y, 0, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index;
        baddieID = other.id;
        other.boundbox = 1;
    }
}
