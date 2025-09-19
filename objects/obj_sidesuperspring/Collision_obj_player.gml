with (other.id)
{
    if (state == states.mach2 || state == states.mach3 || state == states.tumble || state == states.current || state == states.machroll || state == states.slipnslide || state == states.barrel || (state == states.knightpep && knightsliding == 1) || state == states.knightpepslopes || state == states.cheeseball)
    {
        other.sprite_index = spr_sidespring_bounce;
        other.image_index = 0;
        
        if (xscale != other.image_xscale)
            xscale = other.image_xscale;
        
        if (movespeed < 10)
            movespeed = 10;
    }
}
