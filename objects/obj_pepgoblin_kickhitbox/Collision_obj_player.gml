with (other.id)
{
    if (instance_exists(other.baddieID) && state != states.tumble && sprite_index != spr_tumbleend && state != states.knightpep && state != states.knightpepslopes && state != states.backbreaker && state != states.parrying && state != states.victory && state != states.door)
    {
        state = states.tumble;
        xscale = other.baddieID.image_xscale;
        movespeed = 12;
        vsp = 0;
        sprite_index = spr_tumble;
        voice_transfo();
        scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/transfo", x, y);
    }
}
