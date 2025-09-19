x = playerid.x;
y = playerid.y;

if (playerid.state != states.freefall && playerid.state != states.superslam && playerid.freefallsmash <= 0)
    instance_destroy();
