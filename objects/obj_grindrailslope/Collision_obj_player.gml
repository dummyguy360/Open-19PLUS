if (other.y > other.yprevious && other.state != states.backbreaker && other.state != states.grind && other.state != states.bump && other.y < y && !scr_transformationcheck())
{
    with (other)
    {
        while (check_slope_player(obj_grindrailslope))
            y--;
    }
    
    if (other.movespeed < 10)
        other.movespeed = 10;
    
    other.state = states.grind;
    other.sprite_index = other.spr_grind;
}
