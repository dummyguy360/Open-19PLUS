visible = 1;

with (instance_place(x, y - 1, obj_player))
{
    if (!place_meeting(x, y, obj_pipepar))
    {
        if (state != 64 && state != 87)
        {
            state = 64;
            sprite_index = obj_player.spr_Current;
        }
    }
}
