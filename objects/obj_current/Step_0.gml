visible = 1;

with (instance_place(x, y - 1, obj_player))
{
    if (!place_meeting(x, y, obj_pipepar))
    {
        if (state != states.current && state != states.hitstun)
        {
            state = states.current;
            sprite_index = obj_player.spr_Current;
        }
    }
}
