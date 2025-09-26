function scr_fmod_soundeffect(event_inst, xx, yy)
{
    fmod_studio_event_instance_start(event_inst);
    event_set_3d_position(event_inst, xx, yy, 0);
}

function scr_fmod_soundeffectONESHOT(event_path, xx, yy)
{
    var event_id = event_instance(event_path);
    fmod_studio_event_instance_start(event_id);
    event_set_3d_position(event_id, xx, yy, 0);
    fmod_studio_event_instance_release(event_id);
    return event_id;
}

function event_play_oneshot(event_path)
{
    var event_id = event_instance(event_path);
    fmod_studio_event_instance_start(event_id);
    fmod_studio_event_instance_release(event_id);
    return event_id;
}

function event_isplaying(event_inst)
{
    var _playback = fmod_studio_event_instance_get_playback_state(event_inst);
    return _playback != FMOD_STUDIO_PLAYBACK_STATE.STOPPED && _playback != FMOD_STUDIO_PLAYBACK_STATE.STOPPING;
}

function event_instance(event_path)
{
    return fmod_studio_event_description_create_instance(fmod_studio_system_get_event(event_path));
}

function event_pause_all(pause)
{
    fmod_studio_bus_set_paused(fmod_studio_system_get_bus("bus:/Music/Pausable"), pause);
    fmod_studio_bus_set_paused(fmod_studio_system_get_bus("bus:/SFX/Pausable"), pause);
}

function event_set_3d_position(event_inst, xx, yy, zz = 0)
{
    if (!event_isplaying(event_inst)) { }
    
    var _attr = new Fmod3DAttributes();
    _attr.position.x = xx;
    _attr.position.y = yy;
    _attr.position.z = zz;
    _attr.forward.z = 1;
    _attr.up.y = 1;
    fmod_studio_event_instance_set_3d_attributes(event_inst, _attr);
}

function event_set_3d_position_struct(event_inst, attr_struct)
{
    if (!event_isplaying(event_inst))
        exit;
    
    fmod_studio_event_instance_set_3d_attributes(event_inst, attr_struct);
}

function event_stop(event_inst, mode)
{
    fmod_studio_event_instance_stop(event_inst, mode ? FMOD_STUDIO_STOP_MODE.IMMEDIATE : FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
}

function event_stop_description(event_path, mode)
{
    var _insts = fmod_studio_event_description_get_instance_list(fmod_studio_system_get_event(event_path));
    
    for (var _i = 0; _i < array_length(_insts); _i++)
        event_stop(_insts[_i], mode);
}

function listener_setPosition(index, xx, yy, zz = 0)
{
    var _attr = new Fmod3DAttributes();
    _attr.position.x = xx;
    _attr.position.y = yy;
    _attr.position.z = zz;
    _attr.forward.z = 1;
    _attr.up.y = 1;
    fmod_studio_system_set_listener_attributes(index, _attr);
}
