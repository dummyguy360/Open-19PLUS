function scr_coolpinea_taunt()
{
    hsp = 0;
    vsp = 0;
    taunttimer--;
    
    if (taunttimer <= 0)
        state = states.homingattack;
    
    image_speed = 0;
}
