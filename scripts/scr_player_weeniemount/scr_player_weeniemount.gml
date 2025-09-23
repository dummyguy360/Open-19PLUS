function scr_player_weeniemount()
{
    collide_destructibles = function(_h, _v)
    {
        scr_destroy_horizontal(_h, destroy.ratblock);
    };
}
