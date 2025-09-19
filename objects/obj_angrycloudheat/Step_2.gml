image_speed = 0.35;
image_xscale = playerid.xscale;
x = playerid.x;
y = playerid.y;

if (playerid.state != states.normal || global.combo < 50)
    instance_destroy();
