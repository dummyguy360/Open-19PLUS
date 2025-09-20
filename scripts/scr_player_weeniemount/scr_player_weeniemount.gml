function scr_player_weeniemount()
{
    collide_destructibles = function(arg0, arg1)
    {
        scr_destroy_horizontal(arg0, destroy.ratblock);
    };
}
