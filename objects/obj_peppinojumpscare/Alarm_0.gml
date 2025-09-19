if (room == virtualinsanity)
{
    scr_playerreset(1);
    event_stop(obj_virtualinsanity.jumpscaresnd, 1);
    
    with (obj_player)
    {
        targetDoor = "D";
        state = states.titlescreen;
        image_index = 0;
        room_goto(backtohubroom);
        x = backtohubstartx;
        y = backtohubstarty;
    }
}
