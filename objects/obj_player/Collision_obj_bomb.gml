if (!cutscene && other.grounded == 1 && state != states.bombpep && (is_player_grabbing() || (state == states.normal && character == "S")))
{
    bombpeptimer = 100;
    state = states.bombpep;
    image_index = 0;
    sprite_index = spr_bombpepintro;
    bombspawnerid = other.spawner;
    instance_destroy(other.id);
    restore_combo();
    voice_transfo();
    scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/transfo", x, y);
}

if (!cutscene && other.grounded && state != states.bombpep && state == states.freefallland)
{
    instance_create_depth(x, y, 0, obj_bombexplosion);
    instance_destroy(other.id, false);
    scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/bombpepexplode", x, y);
    scr_fmod_soundeffectONESHOT("event:/sfx/player/mach/superjumprelease", x, y);
    instance_create_depth(x, y, 0, obj_bangeffect);
    
    if (character == "N")
        sprite_index = spr_playerN_bombjump;
    else
        sprite_index = spr_player_bombjump;
    
    state = states.sjump;
    vsp = -20;
    cancel_Sjump = false;
}
