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

scr_escapeenemy();
hurttype = 1;
var __player = instance_nearest(x, y, obj_player);

if (x != __player.x && grounded)
{
    if (__player.x > (x - 400) && __player.x < (x + 400) && y <= (__player.y + 20) && y >= (__player.y - 20))
    {
        if (state == states.homingattack && !charging)
        {
            with (instance_create_depth(x, y, 0, obj_forkhitbox))
                ID = other.id;
            
            charging = true;
            state = states.timesup;
            vsp = -7;
            movespeed = 1;
            scr_fmod_soundeffectONESHOT("event:/sfx/enemy/charge", x, y);
        }
    }
}

if (state == states.seat || state == states.homingattack)
{
    charging = 0;
    movespeed = 0;
}

if (flash && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (!hitboxcreate && visible && state == states.homingattack)
{
    hitboxcreate = true;
    
    with (instance_create_depth(x, y, 0, obj_forkhitbox))
    {
        sprite_index = spr_weeniesquire_hitbox;
        ID = other.id;
        hurttype = other.hurttype;
    }
}

if (state != states.seat)
    thrown = 0;

if (!boundbox)
{
    boundbox = true;
    
    with (instance_create_depth(x, y, 0, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index;
        baddieID = other.id;
    }
}
