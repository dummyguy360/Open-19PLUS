image_xscale = playerid.xscale;
x = playerid.x;
y = playerid.y;

if (playerid.state != states.suplexgrab && playerid.state != states.shoulderbash && playerid.state != states.lunge)
    instance_destroy();
