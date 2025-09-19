image_xscale = playerid.xscale;

if (playerid.state != states.mach3 || (playerid.character == "S" && playerid.state != states.sidejump))
    instance_destroy();

x = playerid.x;
y = playerid.y;
