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
    
    case states.retrodeath:
        scr_enemy_chase();
        break;
    
    case states.enemyhitstun:
        scr_enemy_hitstun();
        break;
}

enemy_palettepoof();

if (state == states.seat && stunned > 100 && birdcreated == 0)
{
    birdcreated = 1;
    
    with (instance_create_depth(x, y, -1, obj_enemybird))
        ID = other.id;
}

if (state != states.seat)
    birdcreated = 0;

if (state == states.enemyhitstun)
    exit;

scr_escapeenemy();

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

hurttype = 0;

if (state != states.timesup)
    movespeed = 1;

var __player = instance_nearest(x, y, obj_player);

if (state == states.tackleold || state == states.homingattack)
{
    movespeed = 4;
    
    if (__player.x != x)
        image_xscale = -sign(x - __player.x);
    
    state = states.retrodeath;
}

if (hitboxcreate == 0 && state == states.retrodeath && __player.state != states.mach3)
{
    hitboxcreate = 1;
    
    with (instance_create_depth(x, y, 0, obj_minijohn_hitbox))
    {
        ID = other.id;
        hurttype = other.hurttype;
    }
}

if (x != __player.x && grounded && bombreset == 0 && global.stylethreshold >= 2)
{
    if (__player.state != states.barrel && __player.state != states.mach3 && !scr_transformationcheck() && __player.x > (x - 250) && __player.x < (x + 250) && y <= (__player.y + 60) && y >= (__player.y - 60))
    {
        if (state == states.retrodeath && charging == 0)
        {
            image_xscale = -sign(x - __player.x);
            sprite_index = spr_minijohn_rage1;
            image_index = 0;
            movespeed = 0;
            charging = 1;
            flash = 1;
            state = states.timesup;
            hsp = 0;
            bombreset = 100;
            
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
        }
    }
}

if (bombreset > 0)
    bombreset--;

if (state != states.seat)
    thrown = 0;

if (boundbox == 0)
{
    with (instance_create_depth(x, y, 0, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index;
        mask_index = spr_player_mask;
        baddieID = other.id;
        other.boundbox = 1;
    }
}
