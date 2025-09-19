function doorcheck()
{
    if (input_check("up") && grounded && other.sprite_index != spr_blockeddoor && state != states.door && state != states.comingoutdoor && (state == states.normal || state == states.mach2 || state == states.mach3 || state == states.sjumpprep) && !instance_exists(obj_fadeout))
        enterdoor();
}

if (!place_meeting(x, y, obj_doorblocked))
{
    with (obj_player)
        doorcheck();
}
