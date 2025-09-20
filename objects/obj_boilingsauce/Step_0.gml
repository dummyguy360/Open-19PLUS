if (place_meeting(x, y - 1, obj_player) && obj_player.state != states.ejected2 && obj_player.state != states.weeniemount)
{
    with (instance_place(x, y - 1, obj_player))
    {
        if (state == states.knightpep || state == states.knightpepslopes)
        {
            flash = 1;
            scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/detransfo", x, y);
            
            for (var i = 0; i < 5; i += 1)
            {
                with (instance_create_depth(x, y, -1, obj_knightdebris))
                    image_index = i;
            }
        }
        
        if (state != states.fireass)
            push_notif(achieve_type.fireass, [other.id]);
        
        state = states.fireass;
        vsp = -25;
        sprite_index = spr_fireass;
        
        if (!event_isplaying(PfireassVA) && character == "P")
            fmod_studio_event_instance_start(PfireassVA);
        
        if (!event_isplaying(NfireassVA) && character == "N")
            fmod_studio_event_instance_start(NfireassVA);
        
        scr_fmod_soundeffectONESHOT("event:/sfx/misc/firesound", x, y);
    }
}
