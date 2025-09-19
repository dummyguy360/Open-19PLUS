with (other.id)
{
    if (state == states.knightpep || state == states.knightpepslopes || state == states.knightpepbump)
    {
        scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/detransfo", x, y);
        
        if (character == "P")
        {
            for (var i = 0; i < 5; i++)
            {
                with (instance_create_depth(x, y, -1, obj_knightdebris))
                    image_index = i;
            }
        }
    }
    
    if (state != states.hitstun && other.sprite_index == other.pipespr && pipedir != "hold")
    {
        state = states.pipe;
        pipe = other.id;
        pipedir = "hold";
        hsp = 0;
        vsp = 0;
        grounded = 0;
        other.sprite_index = other.pipeenterspr;
        
        with (other.id)
        {
            if (place_meeting(x, y, obj_pipespeed))
                scr_fmod_soundeffectONESHOT("event:/sfx/player/pipeclang", x, y);
        }
    }
}
