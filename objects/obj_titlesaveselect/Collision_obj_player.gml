with (obj_player)
{
    if (input_check("up") && grounded && state != states.door && state != states.comingoutdoor && (state == states.normal || state == states.mach2 || state == states.mach3 || state == states.sjumpprep) && !instance_exists(obj_fadeout) && get_savestate() == 0)
    {
        event_play_oneshot("event:/sfx/player/doorenter");
        obj_drawcontroller.chargecamera = 0;
        sprite_index = spr_lookdoor;
        image_index = 0;
        state = states.door;
        enteredDoor = other.id;
        targetDoor = "D";
        targetRoom = Scootertransition;
        instance_create_depth(x, y, -9999, obj_titleloadfade);
    }
}
