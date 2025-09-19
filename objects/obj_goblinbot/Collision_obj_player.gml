with (other.id)
{
    if (state != states.knightpep && state != states.knightpepslopes && state != states.ghost)
    {
        if (state != states.tumble)
        {
            state = states.tumble;
            voice_transfo();
            scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/transfo", x, y);
        }
        
        if (movespeed < 14 || xscale != other.image_xscale)
            movespeed = 14;
        
        xscale = other.image_xscale;
        vsp = 0;
        sprite_index = spr_tumble;
        y = other.y;
        
        if (other.sprite_index != spr_goblinbot_kick)
        {
            other.sprite_index = spr_goblinbot_kick;
            other.image_index = 0;
            scr_fmod_soundeffectONESHOT("event:/sfx/player/spring", other.x, other.y);
        }
    }
}
