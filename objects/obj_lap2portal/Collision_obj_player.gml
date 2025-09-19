if (other.state != states.portal && global.panic && sprite_index != spr_pizzaportaloutline)
{
    with (other.id)
    {
        hsp = 0;
        vsp = 0;
        other.sprite_index = spr_pizzaportalend;
        other.image_index = 0;
        state = states.portal;
        grav = 0;
        event_play_oneshot("event:/sfx/player/boxenter");
        add_collect(3000);
        restore_combo();
        
        with (instance_create_depth(x, y, 0, obj_smallnumber))
            number = "3000";
        
        visible = false;
    }
}
