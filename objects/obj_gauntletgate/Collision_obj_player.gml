if (!metrequirement)
    exit;

with (other.id)
{
    if (input_check_pressed("up") && grounded && (state == states.normal || state == states.mach2 || (state == states.mach3 && !rocket)) && !instance_exists(obj_fadeout) && state != states.victory && state != states.comingoutdoor)
    {
        state = states.gatecutscene;
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
            state = states.tumble;
            
            with (instance_create_depth(x - 75, bbox_bottom - 32, depth - 1, obj_baddiedead))
                sprite_index = spr_gauntletsign;
        }
    }
}
