function destroy_sounds(arg0)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        var b = arg0[i];
        event_stop(b, 1);
        fmod_studio_event_instance_release(b);
    }
}

function scr_sound_multiple(arg0, arg1, arg2)
{
    if (global.sound_map[? arg0] == undefined)
        global.sound_map[? arg0] = ds_list_create();
    
    var _list = global.sound_map[? arg0];
    
    for (var i = 0; i < ds_list_size(_list); i++)
    {
        b = _list[| i];
        event_stop(b, 0);
        fmod_studio_event_instance_release(b);
    }
    
    ds_list_clear(_list);
    var b = event_instance(arg0);
    fmod_studio_event_instance_start(b);
    event_set_3d_position(b, arg1, arg2, 0);
    ds_list_add(_list, b);
}
