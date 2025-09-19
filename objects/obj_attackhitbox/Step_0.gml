image_xscale = playerid.xscale;
x = playerid.x;
y = playerid.y;

if ((playerid.state != states.kungfu && playerid.state != states.cheeseslimeattack) || (playerid.state == states.kungfu && playerid.sprite_index == playerid.spr_kungfubump))
    instance_destroy();
