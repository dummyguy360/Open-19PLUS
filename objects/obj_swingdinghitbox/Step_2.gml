x = playerid.x;
y = playerid.y;

if (!instance_exists(playerid) || (instance_exists(playerid) && playerid.state != 28 && playerid.state != 87))
    instance_destroy();
