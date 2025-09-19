if (instance_exists(obj_player))
{
    if (obj_player.state == states.nothing && room == TitlescreenRoom)
    {
        obj_player.state = states.normal;
        input_clear_momentary(true);
    }
}
