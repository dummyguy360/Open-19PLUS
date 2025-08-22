if (active == 1 && obj_player.state == 97)
{
    obj_player.movespeed += 12;
    active = 0;
    alarm[0] = 60;
}
