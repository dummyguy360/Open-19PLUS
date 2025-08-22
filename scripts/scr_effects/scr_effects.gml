function effectMapAdd(arg0 = 1, arg1 = object_index)
{
    if (!visible)
        exit;
    
    with (obj_player)
    {
        if (_player != arg0)
            continue;
        
        var key = array_get_index(vfxobjs, arg1);
        
        if (key == -1)
        {
            show_debug_message("{0} not represented in drawn effects list!", object_get_name(arg1));
            exit;
        }
        
        array_push(vfx[key], other);
    }
}
