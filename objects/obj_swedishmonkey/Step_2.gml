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
    
    with (instance_create_depth(x, y, -1, obj_enemybird))
        ID = other.id;
}

if (state != states.seat)
    birdcreated = 0;

if (state != states.timesup)
    playedsnd = false;

if (state == states.enemyhitstun)
    exit;

scr_enemy_scared();
scr_escapeenemy();

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (bombreset > 0)
    bombreset--;

if (state != states.seat)
    thrown = 0;

if (bombreset == 0 && grounded && visible)
{
    if (state == states.homingattack)
    {
        if (global.stylethreshold < 2)
        {
            image_index = 0;
            sprite_index = spr_swedishmonkey_eat;
            state = states.ramp;
        }
        
        if (global.stylethreshold >= 2)
        {
            var __player = instance_nearest(x, y, obj_player);
            
            if (__player.state != states.mach3 && !scr_transformationcheck() && __player.x > (x - 400) && __player.x < (x + 400) && y <= (__player.y + 30) && y >= (__player.y - 30))
            {
                image_xscale = -sign(x - __player.x);
                sprite_index = spr_swedishmonkey_rage1;
                image_index = 0;
                flash = 1;
                state = states.timesup;
                bombreset = 100;
            }
        }
    }
}

if (boundbox == 0 && visible == 1)
{
    with (instance_create_depth(x, y, 0, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index;
        mask_index = spr_player_mask;
        baddieID = other.id;
        other.boundbox = 1;
    }
}
