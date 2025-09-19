if (playerid.state != states.keyget)
    instance_create_depth(x + random_range(-5, 5), y + random_range(-5, 5), depth - 1, obj_keyeffect);

alarm_set(0, 50);
