if (other.state == states.knightpep)
{
    instance_create_depth(x, y, -1, obj_slimedebris);
    instance_create_depth(x, y, -1, obj_slimedebris);
    instance_create_depth(x, y, -1, obj_slimedebris);
    instance_create_depth(x, y, -1, obj_slimedebris);
    instance_create_depth(x, y, -1, obj_slimedebris);
    instance_create_depth(x, y, -1, obj_slimedebris);
    instance_create_depth(x, y, -1, obj_slimedebris);
    instance_create_depth(x, y, -1, obj_slimedebris);
    instance_destroy();
}
else
{
    if (other.state != states.cheeseball && other.state != states.backbreaker && other.state != states.parrying)
    {
        movespeed = 0;
        other.xscale = image_xscale;
        other.hsp = hsp;
        other.vsp = vsp;
        other.x = x;
        other.y = y;
        other.state = states.cheeseball;
        instance_create_depth(x, y, -1, obj_slimedebris);
        instance_create_depth(x, y, -1, obj_slimedebris);
        instance_create_depth(x, y, -1, obj_slimedebris);
        instance_create_depth(x, y, -1, obj_slimedebris);
        instance_create_depth(x, y, -1, obj_slimedebris);
        instance_create_depth(x, y, -1, obj_slimedebris);
        instance_create_depth(x, y, -1, obj_slimedebris);
        instance_create_depth(x, y, -1, obj_slimedebris);
        voice_transfo(other.id);
        scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/transfo", x, y);
        instance_destroy();
    }
    else if (other.state == states.backbreaker && place_meeting(x, y, obj_parryhitbox) && other.state != states.parrying)
    {
        with (other.id)
        {
            scr_fmod_soundeffectONESHOT("event:/sfx/player/parry", x, y);
            movespeed = -6;
            vsp = 0;
            instance_create_depth(x, y, 1, obj_parryeffect);
            
            if (xscale == 1)
            {
                if (!instance_exists(obj_bangeffect))
                    instance_create_depth(x + 20, y, 0, obj_bangeffect);
            }
            else if (xscale == -1)
            {
                if (!instance_exists(obj_bangeffect))
                    instance_create_depth(x - 20, y, 0, obj_bangeffect);
            }
            
            sprite_index = choose(spr_parry1, spr_parry2, spr_parry3);
            state = states.parrying;
            image_index = 0;
            flash = 1;
        }
        
        image_xscale *= -1;
    }
    
    if (other.state == states.cheeseball)
    {
        instance_create_depth(x, y, -1, obj_slimedebris);
        instance_create_depth(x, y, -1, obj_slimedebris);
        instance_create_depth(x, y, -1, obj_slimedebris);
        instance_create_depth(x, y, -1, obj_slimedebris);
        instance_create_depth(x, y, -1, obj_slimedebris);
        instance_create_depth(x, y, -1, obj_slimedebris);
        instance_create_depth(x, y, -1, obj_slimedebris);
        instance_create_depth(x, y, -1, obj_slimedebris);
        scr_fmod_soundeffectONESHOT("event:/sfx/enemy/punched", x, y);
        instance_destroy();
    }
}
