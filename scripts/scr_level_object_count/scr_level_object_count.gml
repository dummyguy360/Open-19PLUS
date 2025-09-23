// unused in code, but code works maybe
function scr_level_object_count(rm_array, obj_inst)
{
    var count = 0;
    
    for (var i = 0; i < array_length(rm_array); i++)
    {
        layer_set_target_room(rm_array[i]);
        var layers = layer_get_all();
        
        for (i = 0; i < array_length(layers); i++)
        {
            if (string_letters(layer_get_name(layers[i])) == "Instances")
            {
                var elements = layer_get_all_elements(layers[i]);
                
                for (i = 0; i < array_length(elements); i++)
                {
                    if (object_is_ancestor(layer_instance_get_instance(elements[i]), obj_inst) || layer_instance_get_instance(elements[i]) == obj_inst)
                        count++;
                }
            }
        }
    }
    
    layer_reset_target_room();
    return count;
}
