if (place_meeting(x, y, other) && other.state != 31 && other.state != 49 && other.y > other.yprevious && other.y < y && !scr_transformationcheck())
{
    other.y = y - 49;
    
    if (other.movespeed < 10)
        other.movespeed = 10;
    
    other.state = 27;
    other.sprite_index = other.spr_grind;
}
