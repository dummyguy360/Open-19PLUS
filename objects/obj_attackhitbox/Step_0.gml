image_xscale = playerid.xscale;
x = playerid.x;
y = playerid.y;

if ((playerid.state != 91 && playerid.state != 113) || (playerid.state == 91 && playerid.sprite_index == playerid.spr_kungfubump))
    instance_destroy();
