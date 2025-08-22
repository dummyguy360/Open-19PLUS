if (!scr_hudroomcheck() && global.battle == 0 && global.currentbadge != 2)
{
    var check;
    
    with (obj_player)
        check = state != 54 && state != 41 && state != 39 && state != 114 && state != 128 && state != 76 && state != 14 && state != 21 && state != 34 && state != 110 && !scr_transformationcheck(self);
    
    with (obj_player)
    {
        if (check && supertauntcooldown >= 10)
        {
            with (other.id)
                draw_sprite(spr_supercharge, -1, other.x, other.y);
        }
    }
}
