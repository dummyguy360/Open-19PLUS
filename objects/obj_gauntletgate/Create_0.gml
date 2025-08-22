uparrowid = create_uparrow();
level = "";
targetRoom = virtualinsanity;
world = 1;
state = 0;
metrequirement = true;

create_func = function(arg0 = false)
{
    with (instance_create_depth(x, y, depth, obj_startgate))
    {
        level = other.level;
        targetRoom = other.targetRoom;
        unlocked = true;
        unlockedanim = arg0;
    }
};

currtreasure = 0;
treasurelerp = 0;
