function scr_player_barrel()
{
    collide_destructibles = function(_h, _v)
    {
        if (_v < 0)
            scr_destroy_vertical(_v);
        
        if (sprite_index == spr_barrelroll || sprite_index == spr_barrelslipnslide)
            scr_destroy_horizontal(_h, destroy.ratblock);
    };
}
