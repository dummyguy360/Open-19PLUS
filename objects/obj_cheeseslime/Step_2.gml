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

if (!snotty)
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

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

scr_enemy_scared();
scr_escapeenemy();

if (bombreset > 0)
    bombreset--;

if (state != states.timesup)
    movespeed = 1;

var __player = instance_nearest(x, y, obj_player);

if (x != __player.x && grounded && bombreset == 0 && global.stylethreshold >= 2 && !snotty)
{
    if (__player.state != states.barrel && __player.state != states.mach3 && !scr_transformationcheck() && __player.x > (x - 400) && __player.x < (x + 400) && y <= (__player.y + 60) && y >= (__player.y - 60) && __player.grounded)
    {
        if (state == states.homingattack && charging == 0)
        {
            charging = 1;
            scr_fmod_soundeffectONESHOT("event:/sfx/enemy/charge", x, y);
            flash = 1;
            state = states.timesup;
            sprite_index = spr_slime_rage;
            
            if (__player.x != x)
                image_xscale = sign(__player.x - x);
            
            hsp = 0;
            movespeed = 0;
            bombreset = 100;
            image_index = 0;
        }
    }
}

if (state != states.seat)
    thrown = 0;

if (boundbox == 0)
{
    with (instance_create_depth(x, y, 0, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index;
        image_xscale = other.image_xscale;
        image_yscale = other.image_yscale;
        mask_index = other.mask_index;
        baddieID = other.id;
        other.boundbox = 1;
    }
}
