function scr_player_start()
{
    if (keyboard_check_pressed(vk_enter) || input_check("jump"))
    {
        state = states.normal;
        
        with (obj_drawcontroller)
            thintextfade = 1;
    }
    
    if (sprite_index == spr_player_startintro && floor(image_index) == (image_number - 1))
    {
        sprite_index = spr_player_startidle;
        image_index = 0;
    }
    
    hsp = 0;
}
