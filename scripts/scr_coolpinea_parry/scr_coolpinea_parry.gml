function scr_coolpinea_parry()
{
    hsp = 0;
    
    if (floor(image_index) == (image_number - 1))
    {
        sprite_index = walkspr;
        state = states.homingattack;
    }
    
    image_speed = 0.35;
}
