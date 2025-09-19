if (playerid.visible == 0)
{
    with (playerid)
    {
        event_play_oneshot("event:/sfx/misc/taxihonk");
        state = states.normal;
        visible = 1;
        cutscene = 0;
    }
}
