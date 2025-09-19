visible = 1;

with (obj_player)
{
    if (place_meeting(x + hsp, y, other) && state == states.firemove)
        instance_destroy(other);
}

with (obj_player)
{
    if (place_meeting(x, y + vsp, other) && state == states.firemove)
        instance_destroy(other);
}
