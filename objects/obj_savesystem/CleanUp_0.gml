for (var i = 0; i < array_length(global.levels); i++)
{
    if (global.timetrialreplays[? global.levels[i]] != -1)
        buffer_delete(array_get(global.timetrialreplays[? global.levels[i]], 1));
    
    global.timetrialreplays[? global.levels[i]] = -1;
    ds_map_destroy(global.timetrialsavedsplits[? global.levels[i]]);
    global.timetrialsavedsplits[? global.levels[i]] = -1;
    ds_list_destroy(global.pizzacointracker[? global.levels[i]]);
    global.pizzacointracker[? global.levels[i]] = -1;
}

ds_map_destroy(global.timetrialreplays);
global.timetrialreplays = -1;
ds_map_destroy(global.timetrialsavedsplits);
global.timetrialsavedsplits = -1;
ds_map_destroy(global.pizzacointracker);
global.pizzacointracker = -1;

if (buffer_exists(demosavebuff))
    buffer_delete(demosavebuff);

try
{
    if (!ds_map_empty(demoloadbuffs))
    {
        var _demos = ds_map_keys_to_array(demoloadbuffs);
        
        for (var i = 0; i < array_length(_demos); i++)
            buffer_delete(demoloadbuffs[? array_get(_demos, i)]);
    }
    
    ds_map_destroy(demoloadbuffs);
	
} catch (_ex) { }
