function scr_hud(state)
{
    with (obj_drawcontroller)
    {
        if (!statichud)
        {
            statichud = 1;
            staticind = 0;
            hudstate = state;
        }
    }
}

function tv_defaulthud()
{
    if (instance_exists(obj_player))
    {
        var p = obj_player;
        
        if (p.state == states.hitstun)
            exit;
        
        with (obj_drawcontroller)
        {
            if (!obj_music.secret)
            {
                if (hudstate != "default" && sprite_index != p.spr_newhudidle1 && !global.panic && !p.inwar && global.stylethreshold < 2)
                    scr_hud("default");
                
                if (hudstate != "panic" && sprite_index != p.spr_newhudpanic && global.panic && !p.inwar && global.stylethreshold < 2)
                    scr_hud("panic");
                
                if (hudstate != "rage" && sprite_index != p.spr_newhudrage && !p.inwar && global.stylethreshold >= 2)
                    scr_hud("rage");
                
                if (hudstate != "shotgun" && sprite_index != p.spr_newhudshotgun && p.inwar)
                    scr_hud("shotgun");
            }
        }
    }
}

function tv_bgcolor(_r, _g, _b)
{
    tvbgcolor = make_color_rgb(_r, _g, _b);
}
