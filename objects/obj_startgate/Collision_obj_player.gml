if (unlockedanim >= 1 && unlocked)
{
    with (obj_player)
    {
        if (input_check_pressed("up") && grounded && (state == states.normal || state == states.mach2 || (state == states.mach3 && !rocket)) && !instance_exists(obj_fadeout) && state != states.victory && state != states.comingoutdoor)
        {
            enteredDoor = other.id;
            mach2 = 0;
            obj_drawcontroller.chargecamera = 0;
            image_index = 0;
            state = states.victory;
            
            if (global.music != noone)
                event_stop(global.music.event, false);
            
            with (obj_drawcontroller)
            {
                image_index = 0;
                sprite_index = spr_hud_start;
                thintextfade = 1;
                wavetext = 0;
            }
        }
    }
    
    if (floor(obj_player.image_index) == (obj_player.image_number - 1) && obj_player.state == states.victory)
    {
        with (obj_player)
        {
            targetDoor = other.targetDoor;
            targetRoom = other.targetRoom;
            backtohubstartx = x;
            backtohubstarty = y;
            backtohubroom = room;
            global.levelname = other.level;
            
            if (!instance_exists(obj_badgeselector) && !instance_exists(obj_fadeout))
                instance_create_depth(x, y, -8888, obj_badgeselector);
        }
    }
}
