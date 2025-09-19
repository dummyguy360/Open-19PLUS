if (place_meeting(x, y, other) && other.state != states.backbreaker && other.state != states.bump && other.y > other.yprevious && other.y < y && !scr_transformationcheck())
{
    other.y = y - 49;
    
    if (other.movespeed < 10)
        other.movespeed = 10;
    
    other.state = states.grind;
    other.sprite_index = other.spr_grind;
}
