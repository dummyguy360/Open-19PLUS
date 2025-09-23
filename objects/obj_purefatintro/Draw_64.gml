introstate = fmod_studio_event_instance_get_parameter_by_name(introaudio, "purefat").final_value;
var _yoff = (get_game_height() - 540) / 2;
var _c = c_white;

if (introstate == 6 || introstate == 7)
    _c = #000000;

draw_rectangle_colour(0, 0, get_game_width(), get_game_height(), _c, _c, _c, _c, false);

switch (introstate)
{
    case 0:
        frontind += 0.16666666666666666;
        
        if (frontind > 3)
            frontind = 3;
        
        draw_sprite(spr_purefat_peppinofront, 0, frontx, _yoff + fronty);
        draw_sprite(spr_purefat_peppinomouthopen, frontind, frontx, _yoff + fronty);
        break;
    
    case 1:
        draw_sprite(spr_purefat_peppinocliner, 0, sidex, _yoff + sidey);
        break;
    
    case 2:
        var _ms = 833.3333333333334;
        var _s = _ms / 1000;
        sidezoom = Approach(sidezoom, sidezoomtarget, _s / 60);
        draw_sprite_ext(spr_purefat_peppinocliner, 0, sidex, _yoff + sidey, sidezoom, sidezoom, 0, c_white, 1);
        break;
    
    case 3:
        sidezoom = sidezoomtarget;
        
        if (truckx > trucktargetx)
        {
            truckreachedmax++;
            
            if (truckreachedmax == 4)
            {
                truckreachedmax = true;
                truckx = trucktargetx;
            }
        }
        
        if (truckreachedmax == 0)
        {
            truckx += truckspeed;
            truckspeed -= 0.05;
        }
        
        draw_sprite_ext(spr_purefat_peppinocliner, 0, sidex, _yoff + sidey, sidezoom, sidezoom, 0, c_white, 1);
        draw_sprite(spr_purefat_truck, 0, truckx, _yoff + trucky);
        draw_sprite(spr_purefat_door, 0, truckx, _yoff + trucky);
        draw_sprite_ext(spr_purefat_tyre, 0, truckx + 204, _yoff + trucky + 402, 1, 1, -truckx, c_white, 1);
        draw_sprite(spr_purefat_tyrecover, 0, truckx + 86, _yoff + trucky + 282);
        break;
    
    case 4:
        truckx = trucktargetx;
        draw_sprite_ext(spr_purefat_peppinocliner, 0, sidex, _yoff + sidey, sidezoom, sidezoom, 0, c_white, 1);
        draw_sprite(spr_purefat_truck, 0, truckx, _yoff + trucky);
        draw_sprite(spr_purefat_door, 0, truckx, _yoff + trucky);
        draw_sprite_ext(spr_purefat_tyre, 0, truckx + 204, _yoff + trucky + 402, 1, 1, -truckx, c_white, 1);
        draw_sprite(spr_purefat_tyrecover, 0, truckx + 86, _yoff + trucky + 282);
        break;
    
    case 5:
        truckdoorspeed = Approach(truckdoorspeed, truckdoorspeedtarget, 0.2);
        truckdoory += truckdoorspeed;
        draw_sprite_ext(spr_purefat_peppinocliner, 0, sidex, _yoff + sidey, sidezoom, sidezoom, 0, c_white, 1);
        draw_sprite(spr_purefat_truck, 0, truckx, _yoff + trucky);
        draw_sprite(spr_purefat_door, 0, truckx, (_yoff + trucky) - truckdoory);
        draw_sprite_ext(spr_purefat_tyre, 0, truckx + 204, _yoff + trucky + 402, 1, 1, -truckx, c_white, 1);
        draw_sprite(spr_purefat_tyrecover, 0, truckx + 86, _yoff + trucky + 282);
        break;
    
    case 6:
        draw_sprite_ext(spr_ptpteamjr, 0, get_game_width() / 2, get_game_height() / 2, 1, 1, 0, c_white, 1);
        break;
    
    case 7:
        logofade -= 0.025;
        draw_sprite_ext(spr_ptpteamjr, 0, get_game_width() / 2, get_game_height() / 2, 1, 1, 0, c_white, logofade);
        break;
}
