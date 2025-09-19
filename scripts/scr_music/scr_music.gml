function add_music(arg0, arg1, arg2, arg3, arg4 = noone)
{
    var musicstruct = 
    {
        continuous: arg3,
        event: noone,
        eventsecret: noone,
        mumethod: noone
    };
    
    with (musicstruct)
    {
        if (arg4 != noone)
            mumethod = method(self, arg4);
        
        if (arg1 != noone)
        {
            eventname = arg1;
            event = event_instance(arg1);
        }
        
        if (arg2 != noone)
        {
            eventsecretname = arg2;
            eventsecret = event_instance(arg2);
        }
    }
    
    ds_map_set(musicmap, arg0, musicstruct);
}

function stop_music()
{
    with (obj_music)
    {
        if (global.music != noone)
        {
            if (global.music.event != noone)
                event_stop(global.music.event, obj_pause.pause);
            
            if (global.music.eventsecret != noone)
                event_stop(global.music.eventsecret, obj_pause.pause);
        }
        
        event_stop(pillarmusicID, true);
        event_stop(panicmusicID, true);
        event_stop(global.snd_escaperumble, true);
    }
}

function timeline_wrapauto(arg0, arg1, arg2)
{
    var pos = fmod_studio_event_instance_get_timeline_position(arg0);
    var length = fmod_studio_event_description_get_length(fmod_studio_system_get_event(arg1));
    fmod_studio_event_instance_set_timeline_position(arg2, wrap(pos, 1, length - 1));
}
