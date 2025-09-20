if (global.currentpowerup != powerup.shotgun && is_player_grabbing(other.id))
{
    global.currentpowerup = powerup.shotgun;
    other.state = states.shotgun;
    other.image_index = 0;
    other.sprite_index = other.spr_shotgunpullout;
    scr_fmod_soundeffectONESHOT("event:/sfx/player/collect/shotgun", x, y);
    instance_destroy();
}
