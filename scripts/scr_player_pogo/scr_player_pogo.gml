function scr_player_pogo()
{
    collide_destructibles = function(_h, _v)
    {
        scr_destroy_horizontal(_h);
    };
}
