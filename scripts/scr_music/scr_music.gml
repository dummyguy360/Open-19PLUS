function add_music(_rm, _music, _secret_music, _is_continuous, _func = noone)
{
    var musicstruct = 
    {
        continuous: _is_continuous,
        event: noone,
        eventsecret: noone,
        mumethod: noone
    };
    
    with (musicstruct)
    {
        if (_func != noone)
            mumethod = method(self, _func);
        
        if (_music != noone)
        {
            eventname = _music;
            event = event_instance(_music);
        }
        
        if (_secret_music != noone)
        {
            eventsecretname = _secret_music;
            eventsecret = event_instance(_secret_music);
        }
    }
    
    musicmap[? _rm] = musicstruct;
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

function timeline_wrapauto(_pos, _length, event_inst)
{
    var pos = fmod_studio_event_instance_get_timeline_position(_pos);
    var length = fmod_studio_event_description_get_length(fmod_studio_system_get_event(_length));
    fmod_studio_event_instance_set_timeline_position(event_inst, wrap(pos, 1, length - 1));
}
