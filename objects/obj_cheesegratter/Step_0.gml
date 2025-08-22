if (obj_player.state == 78)
{
    if (place_meeting(x, y, obj_player))
        image_alpha = 0.5;
    else if (!place_meeting(x, y, obj_player))
        image_alpha = 1;
    
    mask_index = spr_masknull;
}
else if (obj_player.state != 78)
{
    image_alpha = 1;
    mask_index = spr_cheesegratter;
}
