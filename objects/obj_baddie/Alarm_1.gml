var a = random_range(-20, 20);

if (state == states.seat)
    alarm[1] = 5;

instance_create_depth(x + a, y + a, 0, obj_machalleffect);
