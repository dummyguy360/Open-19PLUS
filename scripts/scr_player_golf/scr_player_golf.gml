function scr_player_golf()
{
    if (sprite_index == spr_golfhit && floor(image_index) == (image_number - 1))
        state = states.normal;
    
    movespeed = 0;
    hsp = 0;
    image_speed = 0.35;
    restore_combo();
}
