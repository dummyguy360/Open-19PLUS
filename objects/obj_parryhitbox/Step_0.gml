if (!instance_exists(playerid))
    instance_destroy();

image_xscale = playerid.xscale;
x = playerid.x;
y = playerid.y;

if (playerid.state != states.parrying && playerid.taunttimer < 10)
    instance_destroy();
