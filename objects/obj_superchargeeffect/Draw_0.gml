if (!scr_hudroomcheck() && global.battle == 0 && global.currentbadge != badge.bdance)
{
    with (obj_player)
        var check = state != states.door && state != states.victory && state != states.comingoutdoor && state != states.actor && state != states.noclip && state != states.pipe && state != states.portal && state != states.stunned && state != states.keyget && state != states.nothing && !scr_transformationcheck(self);
    
    with (obj_player)
    {
        if (check && supertauntcooldown >= 10)
        {
            with (other.id)
                draw_sprite(spr_supercharge, -1, other.x, other.y);
        }
    }
}
