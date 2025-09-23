event_inherited();

create_func = function(_unlockanim = false)
{
    with (instance_create_depth(x, y, depth, obj_sagegate))
    {
        level = other.level;
        targetRoom = other.targetRoom;
        gatespr = other.gatespr;
        gateox = other.gateox;
        gateoy = other.gateoy;
        unlocked = true;
        unlockedanim = _unlockanim;
    }
};

gatespr = spr_sagegate_entry;
gateox = 78;
gateoy = 142;
