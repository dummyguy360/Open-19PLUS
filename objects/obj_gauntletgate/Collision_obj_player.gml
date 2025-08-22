if (!metrequirement)
    exit;

with (other.id)
{
    if (input_check_pressed("up") && grounded && (state == 0 || state == 47 || (state == 66 && !rocket)) && !instance_exists(obj_fadeout) && state != 41 && state != 39)
    {
        state = 127;
        sprite_index = spr_bump;
        scr_fmod_soundeffectONESHOT("event:/sfx/misc/purchase", x, y);
        scr_fmod_soundeffectONESHOT("event:/sfx/player/bump", x, y);
        gamepadvibrate(0.4, 0, 7);
        hsp = -5 * xscale;
        vsp = -5;
        save_open();
        ini_write_real("GameProgress", string_concat(other.level, "unlocked"), true);
        save_close();
        save_dump();
        
        with (other.id)
        {
            state = 1;
            
            with (instance_create_depth(x - 75, bbox_bottom - 32, depth - 1, obj_baddiedead))
                sprite_index = spr_gauntletsign;
        }
    }
}
