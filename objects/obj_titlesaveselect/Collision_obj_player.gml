with (obj_player)
{
    if (input_check("up") && grounded && state != 54 && state != 39 && (state == 0 || state == 47 || state == 66 || state == 42) && !instance_exists(obj_fadeout) && get_savestate() == 0)
    {
        event_play_oneshot("event:/sfx/player/doorenter");
        obj_drawcontroller.chargecamera = 0;
        sprite_index = spr_lookdoor;
        image_index = 0;
        state = 54;
        enteredDoor = other.id;
        targetDoor = "D";
        targetRoom = Scootertransition;
        instance_create_depth(x, y, -9999, obj_titleloadfade);
    }
}
