if (!instance_exists(obj_parryhitbox))
{
    instance_destroy(other);
    instance_create_depth(x, y, 0, obj_bombexplosion);
    
    if (!cutscene && other.grounded && state != 19 && state == 53 && !rocket)
    {
        scr_fmod_soundeffect(char_superjumpsnd, x, y);
        instance_create_depth(x, y, 0, obj_bangeffect);
        sprite_index = spr_presentjump;
        state = 40;
        vsp = -18;
        cancel_Sjump = false;
    }
}
