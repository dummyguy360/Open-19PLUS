function add_achievement_variable(arg0, arg1, arg2 = 0, arg3 = false)
{
    with (obj_achievementtracker)
    {
        var _varstruct = 
        {
            value: -1,
            startingval: -1,
            type: arg2,
            save: arg3
        };
        
        if (arg2 != 2)
        {
            _varstruct.value = arg1;
            _varstruct.startingval = _varstruct.value;
        }
        else
            _varstruct.value = ds_list_create();
        
        variables[? arg0] = _varstruct;
    }
}

function get_achvariable(arg0)
{
    with (obj_achievementtracker)
        return variables[? arg0];
}

function set_achvariable(arg0, arg1)
{
    with (obj_achievementtracker)
    {
        if (variables[? arg0].type != 2)
            variables[? arg0].value = arg1;
        else
            ds_list_add(variables[? arg0].value, arg1);
        
        if (variables[? arg0].save)
        {
            save_open();
            
            switch (variables[? arg0].type)
            {
                case 0:
                    ini_write_real("GameProgress", arg0, variables[? arg0].value);
                    break;
                
                case 1:
                    ini_write_string("GameProgress", arg0, variables[? arg0].value);
                    break;
                
                case 2:
                    var _str = ds_list_write(variables[? arg0].value);
                    ini_write_string("GameProgress", arg0, _str);
                    break;
            }
            
            save_close();
        }
    }
}

function add_achievement(arg0, arg1, arg2, arg3 = function() { } )
{
    with (obj_achievementtracker)
    {
        var _achstruct = 
        {
            type: 0,
            saveid: arg0,
            setupfunc: -1,
            updatefunc: -1,
            cleanfunc: -1,
            done: false
        };
        _achstruct.setupfunc = method(_achstruct, arg1);
        _achstruct.updatefunc = method(_achstruct, arg2);
        _achstruct.cleanfunc = method(_achstruct, arg3);
        array_push(achievements, _achstruct);
    }
}

function add_unlock(arg0, arg1, arg2, arg3 = function() { } )
{
    with (obj_achievementtracker)
    {
        var _achstruct = 
        {
            type: 2,
            saveid: arg0,
            setupfunc: -1,
            updatefunc: -1,
            cleanfunc: -1,
            done: false
        };
        _achstruct.setupfunc = method(_achstruct, arg1);
        _achstruct.updatefunc = method(_achstruct, arg2);
        _achstruct.cleanfunc = method(_achstruct, arg3);
        array_push(achievements, _achstruct);
    }
}

function push_notif(arg0, arg1)
{
    with (obj_achievementtracker)
        ds_list_add(notifications, [arg0, arg1]);
}

function achievement_get(arg0, arg1, arg2)
{
    with (obj_achievementtracker)
    {
        var _popupstruct = 
        {
            type: 0,
            sprite: arg1,
            index: arg2
        };
        save_open();
        ini_write_real("Achievements", arg0, true);
        save_close();
        save_dump();
        var _ach = achievement_get_ind(arg0);
        achievements[_ach].done = true;
        ds_list_add(popupqueue, _popupstruct);
    }
}

function unlockable_unlock(arg0, arg1, arg2)
{
    with (obj_achievementtracker)
    {
        var _popupstruct = 
        {
            type: 2,
            sprite: arg1,
            index: arg2
        };
        save_open();
        ini_write_real("GameProgress", arg0, true);
        save_close();
        save_dump();
        var _ach = achievement_get_ind(arg0);
        achievements[_ach].done = true;
        ds_list_add(popupqueue, _popupstruct);
    }
}

function achievement_get_ind(arg0)
{
    with (obj_achievementtracker)
    {
        for (var i = 0; i < array_length(achievements); i++)
        {
            if (achievements[i].saveid == arg0)
                return i;
        }
    }
}

function achievements_load()
{
    with (obj_achievementtracker)
    {
        save_open();
        var _vars = ds_map_keys_to_array(variables);
        
        for (var v = 0; v < array_length(_vars); v++)
        {
            if (!variables[? array_get(_vars, v)].save)
                continue;
            
            switch (variables[? array_get(_vars, v)].type)
            {
                case 0:
                    variables[? array_get(_vars, v)].value = ini_read_real("GameProgress", _vars[v], variables[? array_get(_vars, v)].startingval);
                    break;
                
                case 1:
                    variables[? array_get(_vars, v)].value = ini_read_string("GameProgress", _vars[v], variables[? array_get(_vars, v)].startingval);
                    break;
                
                case 2:
                    var _str = ini_read_string("GameProgress", _vars[v], "");
                    
                    if (_str != "")
                        ds_list_read(variables[? array_get(_vars, v)].value, _str);
                    
                    break;
            }
        }
        
        for (var a = 0; a < array_length(achievements); a++)
        {
            var _section = "GameProgress";
            
            if (achievements[a].type == 0)
                _section = "Achievements";
            
            achievements[a].done = ini_read_real(_section, achievements[a].saveid, false);
        }
        
        save_close();
    }
}

function achievements_reset()
{
    with (obj_achievementtracker)
    {
        var _vars = ds_map_keys_to_array(variables);
        
        for (var v = 0; v < array_length(_vars); v++)
        {
            if (variables[? array_get(_vars, v)].save)
                continue;
            
            if (variables[? array_get(_vars, v)].type != 2)
                variables[? array_get(_vars, v)].value = variables[? array_get(_vars, v)].startingval;
            else
                ds_list_clear(variables[? array_get(_vars, v)].value);
        }
    }
}
