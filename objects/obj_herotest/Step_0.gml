if (place_meeting(x, y, obj_player) && obj_player.state != states.heropep)
{
    with (obj_player)
    {
        state = states.heropep;
        sprite_index = spr_heropep_idle;
        image_index = 0;
    }
}
