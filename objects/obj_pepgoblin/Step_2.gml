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

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != states.seat)
    thrown = 0;

scr_enemy_scared();
scr_escapeenemy();

if (bombreset > 0)
    bombreset--;

var __player = instance_nearest(x, y, obj_player);

if (x != __player.x && state != states.ramp && __player.state != states.tumble && __player.state != states.hitstun && !scr_transformationcheck() && bombreset == 0 && grounded)
{
    if (__player.x > (x - 80) && __player.x < (x + 80) && y <= (__player.y + 100) && y >= (__player.y - 100))
    {
        if (state == states.homingattack)
        {
            image_index = 0;
            sprite_index = spr_pepgoblin_kick;
            image_xscale = -sign(x - __player.x);
            state = states.ramp;
        }
    }
}

if (grounded && state == states.ramp && floor(image_index) == 3)
    vsp = -5;

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
