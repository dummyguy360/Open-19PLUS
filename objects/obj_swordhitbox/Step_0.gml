image_xscale = playerid.xscale;
x = playerid.x;
y = playerid.y;

if (playerid.state != states.finishingblow && playerid.state != states.swingdingfinish)
    instance_destroy();
