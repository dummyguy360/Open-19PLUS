if (state == 50)
{
    if (global.smallpep)
        state = 106;
    else if (mask_index == spr_crouchmask)
        state = 43;
    else
        state = 0;
    
    movespeed = 0;
}
