with (other.id)
{
    if (state == 47 || state == 66 || state == 1 || state == 64 || state == 23 || state == 38 || state == 105 || (state == 18 && knightsliding == 1) || state == 13 || state == 8)
    {
        other.sprite_index = spr_sidespring_bounce;
        other.image_index = 0;
        
        if (xscale != other.image_xscale)
            xscale = other.image_xscale;
        
        if (movespeed < 10)
            movespeed = 10;
    }
}
