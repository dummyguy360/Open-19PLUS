if (state == states.hurt)
{
    if (global.smallpep)
        state = states.smallpep;
    else if (mask_index == spr_crouchmask)
        state = states.crouch;
    else
        state = states.normal;
    
    movespeed = 0;
}
