with (other.id)
{
    if (instance_exists(other.baddieID) && state != 1 && sprite_index != spr_tumbleend && state != 18 && state != 13 && state != 31 && state != 70 && state != 41 && state != 54)
    {
        state = 1;
        xscale = other.baddieID.image_xscale;
        movespeed = 12;
        vsp = 0;
        sprite_index = spr_tumble;
        voice_transfo();
        scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/transfo", x, y);
    }
}
