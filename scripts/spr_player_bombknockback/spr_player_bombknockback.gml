function scr_player_bombknockback()
{
    hsp = -xscale * movespeed;
    
    if (grounded)
    {
        sprite_index = spr_land;
        image_index = 0;
        landAnim = true;
        state = states.normal;
    }
    
    sprite_index = spr_rockethitwall;
    image_speed = 0.35;
}
