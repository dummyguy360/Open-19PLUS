function scr_bigdestroyablecheck(arg0)
{
    with (arg0)
    {
        if (object_index == obj_destroyable2_big || object_index == obj_destroyable2_bigescape || object_index == obj_destroyable3 || object_index == obj_destroyable3escape || object_index == obj_secretbigblock || object_index == obj_bigdoughblock)
            return true;
        
        return false;
    }
}
