x = playerid.x;
y = playerid.y;

if (!instance_exists(playerid) || (instance_exists(playerid) && playerid.state != states.grab && playerid.state != states.hitstun))
    instance_destroy();
