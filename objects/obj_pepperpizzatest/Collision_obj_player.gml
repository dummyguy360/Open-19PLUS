if (active == 1 && obj_player.state == states.firemove)
{
    obj_player.movespeed += 12;
    active = 0;
    alarm[0] = 60;
}
