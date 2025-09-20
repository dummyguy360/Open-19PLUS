function effectMapAdd(_player_val = 1, _effect_obj = object_index)
{
    if (!visible)
        exit;
    
    with (obj_player)
    {
        if (_player != _player_val)
            continue;
        
        var key = array_get_index(vfxobjs, _effect_obj);
        
        if (key == -1)
        {
            show_debug_message("{0} not represented in drawn effects list!", object_get_name(_effect_obj));
            exit;
        }
        
        array_push(vfx[key], other);
    }
}
