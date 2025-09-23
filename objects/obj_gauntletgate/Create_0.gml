uparrowid = create_uparrow();
level = "";
targetRoom = virtualinsanity;
world = 1;
state = states.normal;
metrequirement = true;

create_func = function(_unlockanim = false)
{
    with (instance_create_depth(x, y, depth, obj_startgate))
    {
        level = other.level;
        targetRoom = other.targetRoom;
        unlocked = true;
        unlockedanim = _unlockanim;
    }
};

currtreasure = 0;
treasurelerp = 0;
