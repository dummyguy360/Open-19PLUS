for (var i = 0; i < (ramptricks * collectmul); i++)
{
    var _x = x + lengthdir_x(collectlen, collectrand[i][0]);
    var _y = y + lengthdir_y(collectlen, collectrand[i][0]);
    var _val = (25 * maxramptricks) / (maxramptricks * collectmul);
    restore_combo(10);
    add_collect(_val);
    
    with (instance_create_depth(_x, _y, depth, obj_collectparticle))
    {
        sprite_index = other.collectrand[i][1];
        image_speed = 0.35;
        image_index = other.collectrand[i][2];
        value = _val;
        shake = 4;
    }
}
