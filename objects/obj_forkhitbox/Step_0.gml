if (!instance_exists(ID))
{
    instance_destroy();
    exit;
}

x = ID.x;
y = ID.y;
image_xscale = ID.image_xscale;
image_index = ID.image_index;

with (ID)
{
    var targetplayer = instance_nearest(x, y, obj_player);
    
    if (object_index == obj_forknight)
    {
        if (state != states.homingattack && state != states.timesup)
        {
            hitboxcreate = 0;
            instance_destroy(other.id);
        }
    }
    
    if (object_index == obj_minijohn)
    {
        if (state != states.timesup)
        {
            hitboxcreate = 0;
            instance_destroy(other.id);
        }
    }
    
    if (object_index == obj_fencer || object_index == obj_ancho || object_index == obj_cheeseslime)
    {
        if (state != states.timesup || targetplayer.state == states.mach3)
        {
            hitboxcreate = 0;
            instance_destroy(other.id);
        }
    }
    
    if (object_index == obj_weeniesquire)
    {
        if (state != states.timesup)
        {
            hitboxcreate = 0;
            instance_destroy(other.id);
        }
    }
}
