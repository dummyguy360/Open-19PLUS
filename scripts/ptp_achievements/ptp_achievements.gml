function add_achievement_variable(_name, _value, _type = popup_type.cowboytask, _save = false)
{
    with (obj_achievementtracker)
    {
        var _varstruct = 
        {
            value: -1,
            startingval: -1,
            type: _type,
            save: _save
        };
        
        if (_type != popup_type.othertask)
        {
            _varstruct.value = _value;
            _varstruct.startingval = _varstruct.value;
        }
        else
            _varstruct.value = ds_list_create();
        
        variables[? _name] = _varstruct;
    }
}

function get_achvariable(_name)
{
    with (obj_achievementtracker)
        return variables[? _name];
}

function set_achvariable(_name, _value)
{
    with (obj_achievementtracker)
    {
        if (variables[? _name].type != popup_type.othertask)
            variables[? _name].value = _value;
        else
            ds_list_add(variables[? _name].value, _value);
        
        if (variables[? _name].save)
        {
            save_open();
            
            switch (variables[? _name].type)
            {
                case popup_type.cowboytask:
                    ini_write_real("GameProgress", _name, variables[? _name].value);
                    break;
                
                case popup_type.silent:
                    ini_write_string("GameProgress", _name, variables[? _name].value);
                    break;
                
                case popup_type.othertask:
                    var _str = ds_list_write(variables[? _name].value);
                    ini_write_string("GameProgress", _name, _str);
                    break;
            }
            
            save_close();
        }
    }
}

function add_achievement(_saveid, _setupfunc, _updatefunc, _cleanfunc = function() { } )
{
    with (obj_achievementtracker)
    {
        var _achstruct = 
        {
            type: popup_type.cowboytask,
            saveid: _saveid,
            setupfunc: -1,
            updatefunc: -1,
            cleanfunc: -1,
            done: false
        };
        _achstruct.setupfunc = method(_achstruct, _setupfunc);
        _achstruct.updatefunc = method(_achstruct, _updatefunc);
        _achstruct.cleanfunc = method(_achstruct, _cleanfunc);
        array_push(achievements, _achstruct);
    }
}

function add_unlock(_saveid, _setupfunc, _updatefunc, _cleanfunc = function() { } )
{
    with (obj_achievementtracker)
    {
        var _achstruct = 
        {
            type: popup_type.othertask,
            saveid: _saveid,
            setupfunc: -1,
            updatefunc: -1,
            cleanfunc: -1,
            done: false
        };
        _achstruct.setupfunc = method(_achstruct, _setupfunc);
        _achstruct.updatefunc = method(_achstruct, _updatefunc);
        _achstruct.cleanfunc = method(_achstruct, _cleanfunc);
        array_push(achievements, _achstruct);
    }
}

function push_notif(_notif_type, _conditions)
{
    with (obj_achievementtracker)
        ds_list_add(notifications, [_notif_type, _conditions]);
}

function achievement_get(_name, _sprite, _index)
{
    with (obj_achievementtracker)
    {
        var _popupstruct = 
        {
            type: popup_type.cowboytask,
            sprite: _sprite,
            index: _index
        };
        save_open();
        ini_write_real("Achievements", _name, true);
        save_close();
        save_dump();
        var _ach = achievement_get_ind(_name);
        achievements[_ach].done = true;
        ds_list_add(popupqueue, _popupstruct);
    }
}

function unlockable_unlock(_name, _sprite, _index)
{
    with (obj_achievementtracker)
    {
        var _popupstruct = 
        {
            type: popup_type.othertask,
            sprite: _sprite,
            index: _index
        };
        save_open();
        ini_write_real("GameProgress", _name, true);
        save_close();
        save_dump();
        var _ach = achievement_get_ind(_name);
        achievements[_ach].done = true;
        ds_list_add(popupqueue, _popupstruct);
    }
}

function achievement_get_ind(_saveid)
{
    with (obj_achievementtracker)
    {
        for (var i = 0; i < array_length(achievements); i++)
        {
            if (achievements[i].saveid == _saveid)
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
                case popup_type.cowboytask:
                    variables[? array_get(_vars, v)].value = ini_read_real("GameProgress", _vars[v], variables[? array_get(_vars, v)].startingval);
                    break;
                
                case popup_type.silent:
                    variables[? array_get(_vars, v)].value = ini_read_string("GameProgress", _vars[v], variables[? array_get(_vars, v)].startingval);
                    break;
                
                case popup_type.othertask:
                    var _str = ini_read_string("GameProgress", _vars[v], "");
                    
                    if (_str != "")
                        ds_list_read(variables[? array_get(_vars, v)].value, _str);
                    
                    break;
            }
        }
        
        for (var a = 0; a < array_length(achievements); a++)
        {
            var _section = "GameProgress";
            
            if (achievements[a].type == popup_type.cowboytask)
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
            
            if (variables[? array_get(_vars, v)].type != popup_type.othertask)
                variables[? array_get(_vars, v)].value = variables[? array_get(_vars, v)].startingval;
            else
                ds_list_clear(variables[? array_get(_vars, v)].value);
        }
    }
}
