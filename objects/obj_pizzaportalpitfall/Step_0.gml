if (sprite_index == spr_pizzaportalstart && floor(image_index) == (image_number - 1))
{
    sprite_index = spr_pizzaportalentrance;
    image_index = 0;
    alarm[0] = 80;
}

if (sprite_index == spr_pizzaportalentrance && floor(image_index) == (image_number - 1))
{
    with (obj_player)
    {
        if (state == states.pitfall)
        {
            if (global.smallpep)
            {
                sprite_index = spr_smallidle;
                state = states.smallpep;
                grav = 0.5;
                hsp = 0;
                movespeed = 0;
                image_alpha = 1;
            }
            else
            {
                state = states.freefall;
                grav = 0.5;
                sprite_index = spr_bodyslamfall;
                hsp = 0;
                movespeed = 0;
                vsp += 14;
                image_alpha = 1;
            }
        }
    }
}
