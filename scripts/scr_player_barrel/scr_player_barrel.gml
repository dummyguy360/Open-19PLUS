function scr_player_barrel()
{
    collide_destructibles = function(arg0, arg1)
    {
        if (arg1 < 0)
            scr_destroy_vertical(arg1);
        
        if (sprite_index == spr_barrelroll || sprite_index == spr_barrelslipnslide)
            scr_destroy_horizontal(arg0, destroy.ratblock);
    };
}
