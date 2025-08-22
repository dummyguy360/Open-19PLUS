if (global.unfocusedmute && !window_has_focus())
    fmod_studio_system_set_parameter_by_name("mastervol", 0, false);
else
    fmod_studio_system_set_parameter_by_name("mastervol", global.mastervolume, false);

fmod_studio_system_set_parameter_by_name("musicvol", global.musicvolume, false);
fmod_studio_system_set_parameter_by_name("sfxvol", global.sfxvolume, false);
fmod_studio_system_update();
