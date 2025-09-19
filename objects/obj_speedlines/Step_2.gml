x = playerid.x;
y = playerid.y;
image_xscale = playerid.xscale;

with (playerid)
{
    if (state != states.mach3)
        instance_destroy(other.id);
}
