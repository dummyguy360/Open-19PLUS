if (obj_player.state == states.suplexgrab)
{
    with (obj_player)
    {
        image_index = 0;
        
        if (input_check("up"))
        {
            state = states.superslam;
            sprite_index = spr_piledriver;
            piledrivervsp = -14;
            movespeed = 0;
            hsp = 0;
            fmod_studio_event_instance_start(groundpoundfallsnd);
        }
        else if (!input_check("up"))
        {
            if (movespeed <= 10)
            {
                sprite_index = spr_haulingstart;
                scr_fmod_soundeffectONESHOT("event:/sfx/player/grabthing", x, y);
            }
            else if (movespeed > 10)
                sprite_index = spr_swingding;
            
            state = states.grab;
            
            if (!grounded)
                vsp = -6;
        }
    }
    
    grabbedby = other.playerid;
}
