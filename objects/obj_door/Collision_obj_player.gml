function doorcheck()
{
    if (input_check("up") && grounded && other.sprite_index != spr_blockeddoor && state != 54 && state != 39 && (state == 0 || state == 47 || state == 66 || state == 42) && !instance_exists(obj_fadeout))
        enterdoor();
}

if (!place_meeting(x, y, obj_doorblocked))
{
    with (obj_player)
        doorcheck();
}
