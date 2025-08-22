x = playerid.x;
y = playerid.y;

if (playerid.state != 51 && playerid.state != 25 && playerid.freefallsmash <= 0)
    instance_destroy();
