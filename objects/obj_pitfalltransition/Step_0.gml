tick += image_speed;

if (fade == 0)
{
    if (image_alpha < 1)
        image_alpha += 0.1;
    
    if (image_alpha == 1)
    {
        with (obj_player)
        {
            if (portalcheckpointid != -4)
            {
                x = portalcheckpointid.x;
                y = portalcheckpointid.y;
            }
            else if (portalcheckpointid == -4)
            {
                x = roomstartx;
                y = roomstarty;
            }
        }
    }
    
    if (floor(image_index) == 12 && !groundpoundsound)
    {
        groundpoundsound = 1;
        event_play_oneshot("event:/sfx/misc/cymbalcrash");
    }
    
    if (floor(image_index) == 26 && !offsound)
    {
        offsound = 1;
        event_play_oneshot("event:/sfx/misc/tvmessageoff");
    }
    
    if (image_index >= 41)
    {
        fade = 1;
        image_speed = 0;
        
        with (obj_player)
        {
            if (state == 98)
            {
                if (global.smallpep)
                {
                    sprite_index = spr_smallidle;
                    state = 106;
                    grav = 0.5;
                    hsp = 0;
                    movespeed = 0;
                    image_alpha = 1;
                }
                else
                {
                    state = 0;
                    grav = 0.5;
                    hsp = 0;
                    movespeed = 0;
                    vsp = 0;
                    image_alpha = 1;
                }
            }
        }
    }
}
else if (fade == 1)
{
    image_speed = 0;
    
    if (image_alpha > 0)
        image_alpha -= 0.1;
    
    if (image_alpha <= 0)
        instance_destroy();
}
