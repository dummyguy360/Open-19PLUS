scr_textureload();

if (room != rank_room && room != rank_roomtutorial)
{
    if (targetDoor != "HUB")
    {
        var _warp = asset_get_index("obj_door" + targetDoor);
        
        if (instance_exists(_warp))
        {
            if (hallway)
                x = _warp.x + (hallwaydirection * 100);
            else if (box)
                x = _warp.x + 32;
            else if (verticalhallway)
                x = _warp.x + (verticalhallwayposition * verticalhallwayside);
            else
                x = _warp.x + 16;
            
            if (verticalhallway)
                y = _warp.y + (-verticalflip * 100);
            else
                y = _warp.y - 14;
            
            if (room != rank_room && room != rank_roomtutorial)
            {
                if (box || elevator)
                {
                    if (sprite_index == spr_downpizzabox)
                    {
                        y += 14;
                        grounded = false;
                    }
                    else if (sprite_index == spr_uppizzabox)
                        grounded = true;
                    
                    state = grounded ? states.normal : states.jump;
                    
                    if (state != states.normal)
                    {
                        sprite_index = spr_fall;
                        image_index = 0;
                    }
                }
                else if (state == states.door || state == states.victory)
                {
                    if (place_meeting(x, y, obj_exitgate))
                        scr_unrevokeprank();
                    
                    state = states.comingoutdoor;
                    sprite_index = spr_walkfront;
                    image_index = 0;
                    doorblend = 0;
                }
            }
            
            hallway = false;
            box = false;
            verticalhallway = false;
            elevator = false;
        }
    }
    
    if (targetDoor == "YOM")
    {
        x = pizzatalex;
        y = pizzataley;
    }
    
    if (room == virtualinsanity)
    {
        x = obj_doorA.x + 16;
        y = obj_doorA.y - 14;
        state = states.titlescreen;
    }
    
    if (room == hub_forcedtutorial && targetDoor == "C")
    {
        state = states.slipbanan;
        sprite_index = spr_slipbananimpact;
        slipbounce = true;
        xscale = 1;
        movespeed = 7;
    }
}

if (global.currentpowerup == powerup.mort)
    instance_create_depth(x, y, 0, obj_mortfollow);

roomstartx = x;
roomstarty = y;
portalcheckpointid = noone;
global.battle = 0;
update_object_coordinates();
