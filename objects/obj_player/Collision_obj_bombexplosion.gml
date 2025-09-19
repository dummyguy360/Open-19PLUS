if (!hurted && !cutscene && state != states.bombpep && sprite_index != spr_bombpepend && state != states.sjump && state != states.sjumpprep && state != states.boxxedpep && !rocket)
{
    if (state == states.knightpep)
    {
        scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/detransfo", x, y);
        
        for (var i = 0; i < 5; i++)
        {
            with (instance_create_depth(x, y, -1, obj_knightdebris))
                image_index = i;
        }
        
        if (x != other.x)
            obj_player.hsp = sign(x - other.x) * 5;
    }
    
    image_index = 0;
    vsp = -4;
    sprite_index = spr_bombpepend;
    state = states.bombpep;
    bombpeptimer = 0;
    restore_combo();
}
