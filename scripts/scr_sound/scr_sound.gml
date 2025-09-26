function destroy_sounds(snd_array)
{
    for (var i = 0; i < array_length(snd_array); i++)
    {
        var b = snd_array[i];
        event_stop(b, true);
        fmod_studio_event_instance_release(b);
    }
}

function scr_sound_multiple(snd_list, xx, yy)
{
    if (global.sound_map[? snd_list] == undefined)
        global.sound_map[? snd_list] = ds_list_create();
    
    var _list = global.sound_map[? snd_list];
    
    for (var i = 0; i < ds_list_size(_list); i++)
    {
        b = _list[| i];
        event_stop(b, false);
        fmod_studio_event_instance_release(b);
    }
    
    ds_list_clear(_list);
    var b = event_instance(snd_list);
    fmod_studio_event_instance_start(b);
    event_set_3d_position(b, xx, yy, 0);
    ds_list_add(_list, b);
}
