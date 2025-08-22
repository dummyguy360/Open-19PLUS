image_xscale = playerid.xscale;

if (playerid.state != 66 || (playerid.character == "S" && playerid.state != 85))
    instance_destroy();

x = playerid.x;
y = playerid.y;
