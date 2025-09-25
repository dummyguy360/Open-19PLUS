function get_savedir()
{
    return "File1";
}

function save_clear()
{
    trace("Clearing Save...");
    global.savetime = 0;
    global.tutorialdone = false;
    
    for (var i = 0; i < array_length(global.levels); i++)
    {
        if (global.timetrialreplays[? global.levels[i]] != -1)
        {
            buffer_delete(array_get(global.timetrialreplays[? global.levels[i]], 1));
            global.timetrialreplays[? global.levels[i]] = -1;
        }
        
        ds_map_clear(global.timetrialsavedsplits[? global.levels[i]]);
        ds_list_clear(global.pizzacointracker[? global.levels[i]]);
    }
    
    with (obj_savesystem)
    {
        savestr = "";
        walletstr = "";
    }
}

function save_setup()
{
    var _filename = file_find_first(working_directory + "Data/Defaults/*", 0);
    
    while (_filename != "")
    {
        var _name = string_split(_filename, "/");
        _name = _name[array_length(_name) - 1];
        var _newname = string_concat(get_savedir(), "/", _name);
        
        if (!file_exists(_newname))
            file_copy(_filename, _newname);
        
        _filename = file_find_next();
    }
    
    file_find_close();
}

function save_load()
{
    with (obj_savesystem)
    {
        if (savestate == save_state.idle)
        {
            savestate = save_state.loadsave;
            trace("Loading Save...");
            save_setup();
            loadbuff = buffer_create(1, buffer_grow, 1);
            walletloadbuff = buffer_create(1, buffer_grow, 1);
            buffer_async_group_begin(get_savedir());
            buffer_load_async(loadbuff, "saveData.save", 0, -1);
            buffer_load_async(walletloadbuff, "playerWallet.save", 0, -1);
            demoloadbuffs = ds_map_create();
            var _democount = 0;
            
            for (var i = 0; i < array_length(global.levels); i++)
            {
                var _filename = string_concat(global.levels[i], "Replay.demo");
                
                if (!file_exists(get_savedir() + "/" + _filename))
                    continue;
                
                _democount++;
                demoloadbuffs[? global.levels[i]] = buffer_create(1, buffer_grow, 1);
                buffer_load_async(demoloadbuffs[? global.levels[i]], _filename, 0, -1);
            }
            
            trace("Found ", _democount, " Demo(s)");
            asyncloadid = buffer_async_group_end();
        }
    }
}

function save_dump(level_name = noone)
{
    with (obj_savesystem)
    {
        if (savestate == save_state.idle)
        {
            savestate = save_state.dumpsave;
            trace("Dumping Save...");
            buffer_async_group_begin(get_savedir());
            ini_open_from_string(savestr);
            ini_write_real("GameProgress", "saveage", global.savetime);
            var _closedini = ini_close();
            savebuff = buffer_create(string_byte_length(_closedini) + 1, buffer_fixed, 1);
            buffer_write(savebuff, buffer_string, _closedini);
            buffer_save_async(savebuff, "saveData.save", 0, buffer_get_size(savebuff));
            var _wallettempbuff = buffer_create(string_byte_length(walletstr) + 1, buffer_fixed, 1);
            buffer_write(_wallettempbuff, buffer_string, walletstr);
            walletsavebuff = buffer_compress(_wallettempbuff, 0, buffer_get_size(_wallettempbuff));
            buffer_delete(_wallettempbuff);
            buffer_save_async(walletsavebuff, "playerWallet.save", 0, buffer_get_size(walletsavebuff));
            
            if (level_name != noone && level_name != "tutorial" && global.timetrial)
            {
                if (global.timetrialreplays[? level_name] == -1 || global.timetrialtick < array_get(global.timetrialreplays[? level_name], 0))
                {
                    var _filename = string_concat(level_name, "Replay.demo");
                    var _buffsize = buffer_tell(global.timetrialrecording);
                    var _mapsize = ds_map_size(global.timetrialsplits);
                    var _tempbuff = buffer_create(_buffsize + 17, buffer_grow, 1);
                    var _key = ds_map_find_first(global.timetrialsplits);
                    buffer_resize(global.timetrialrecording, _buffsize);
                    buffer_write(_tempbuff, buffer_u8, 1);
                    buffer_write(_tempbuff, buffer_u64, _buffsize + 17);
                    buffer_write(_tempbuff, buffer_u64, global.timetrialtick);
                    buffer_copy(global.timetrialrecording, 0, _buffsize, _tempbuff, 17);
                    buffer_seek(_tempbuff, buffer_seek_relative, _buffsize);
                    
                    repeat (_mapsize)
                    {
                        buffer_write(_tempbuff, buffer_string, _key);
                        buffer_write(_tempbuff, buffer_f64, global.timetrialsplits[? _key]);
                        _key = ds_map_find_next(global.timetrialsplits, _key);
                    }
                    
                    demosavebuff = buffer_compress(_tempbuff, 0, buffer_tell(_tempbuff));
                    buffer_delete(_tempbuff);
                    buffer_save_async(demosavebuff, _filename, 0, buffer_get_size(demosavebuff));
                    
                    if (global.timetrialreplays[? level_name] == -1)
                        global.timetrialreplays[? level_name] = [-1, -1];
                    else
                        buffer_delete(array_get(global.timetrialreplays[? level_name], 1));
                    
                    array_set(global.timetrialreplays[? level_name], 0, global.timetrialtick);
                    array_set(global.timetrialreplays[? level_name], 1, global.timetrialrecording);
                    ds_map_copy(global.timetrialsavedsplits[? level_name], global.timetrialsplits);
                    global.timetrialrecording = buffer_create(0, buffer_grow, 1);
                    ds_map_clear(global.timetrialsplits);
                }
            }
            else
                demosavebuff = -1;
            
            asyncsaveid = buffer_async_group_end();
        }
    }
}

function config_dump()
{
    with (obj_savesystem)
    {
        if (savestate == save_state.idle)
        {
            savestate = save_state.dumpconfig;
            trace("Dumping Config...");
            buffer_async_group_begin("");
            configsavebuff = buffer_create(1, buffer_grow, 1);
            var _configasjson = "//hello! I assume you're looking at this file\n";
            _configasjson += "//because you screwed something up and can't revert it ingame.\n";
            _configasjson += "//that's perfectly fine! but beware! setting some of these values to the wrong data type may result in a crash.\n";
            _configasjson += "//anyway. I'll let you get on with editing the file now. cya! - lerp32\n\n";
            _configasjson += json_stringify(configstruct, true);
            buffer_write(configsavebuff, buffer_string, _configasjson);
            buffer_save_async(configsavebuff, "optionsData.json", 0, buffer_get_size(configsavebuff));
            asyncconfigsaveid = buffer_async_group_end();
        }
    }
}

function save_delete()
{
    trace("Deleting Save...");
    directory_destroy(get_savedir());
    obj_savesystem.saveiconalpha = 3;
    obj_savesystem.saveiconspr = spr_saveindicator;
}

function save_open()
{
    ini_open_from_string(obj_savesystem.savestr);
}

function save_close()
{
    obj_savesystem.savestr = ini_close();
}

function get_savestate()
{
    return obj_savesystem.savestate;
}

function wallet_open()
{
    ini_open_from_string(obj_savesystem.walletstr);
}

function wallet_close()
{
    obj_savesystem.walletstr = ini_close();
}

function wallet_writecoins(_level = -3)
{
    if (_level == -3)
    {
        for (var i = 0; i < array_length(global.levels); i++)
            wallet_writecoins(global.levels[i]);
    }
    else if (!ds_list_empty(global.pizzacointracker[? _level]))
    {
        var _str = ds_list_write(global.pizzacointracker[? _level]);
        ini_write_string("Data", _level, _str);
    }
}

function wallet_readcoins(_level = -3, _clear_lvl_data = false)
{
    if (_level == -3)
    {
        for (var i = 0; i < array_length(global.levels); i++)
            wallet_readcoins(global.levels[i]);
    }
    else
    {
        var _str = ini_read_string("Data", _level, "");
        
        if (_str != "")
            ds_list_read(global.pizzacointracker[? _level], _str);
        else if (_clear_lvl_data)
            ds_list_clear(global.pizzacointracker[? _level]);
    }
}

function config_get_option(_section_name, _option_name, _value)
{
    with (obj_savesystem)
    {
        if (!variable_struct_exists(configstruct, _section_name))
            return _value;
        
        var _sect = variable_struct_get(configstruct, _section_name);
        
        if (!variable_struct_exists(_sect, _option_name))
            return _value;
        
        _value = variable_struct_get(_sect, _option_name);
        return _value;
    }
}

function config_set_option(_section_name, _option_name, _value)
{
    with (obj_savesystem)
    {
        if (!variable_struct_exists(configstruct, _section_name))
            variable_struct_set(configstruct, _section_name, {});
        
        var _sect = variable_struct_get(configstruct, _section_name);
        variable_struct_set(_sect, _option_name, _value);
    }
}

function calc_perc(_coin_amount = global.pizzacointracker)
{
    var _lcount = array_length(global.levels);
    var _tcount = 0;
    var _achperc = ach_perc();
    var _coins = 0;
    var _coinperc = 0;
    var _rankperc = 0;
    var _prankperc = 0;
    var _ttrankperc = 0;
    var _ttprankperc = 0;
    var _secretperc = 0;
    var _treasureperc = 0;
    
    for (var i = 0; i < array_length(global.levels); i++)
    {
        _coins += ds_list_size(_coin_amount[? global.levels[i]]);
        _rankperc += (ini_read_real("Ranks", global.levels[i], -1) >= 4);
        _prankperc += (ini_read_real("Ranks", global.levels[i], -1) >= 5);
        _ttrankperc += (ini_read_real("TrialRanks", global.levels[i], -1) >= 2);
        _ttprankperc += (ini_read_real("TrialRanks", global.levels[i], -1) >= 3);
        _secretperc += (ini_read_real("Secrets", global.levels[i], 0) == 3);
        
        if (i == 0 || (i % 4) != 0)
        {
            _tcount++;
            _treasureperc += ini_read_real("Treasures", global.levels[i], false);
        }
    }
    
    _coinperc = _coins / (25 * _lcount);
    _rankperc /= _lcount;
    _prankperc /= _lcount;
    _ttrankperc /= _lcount;
    _ttprankperc /= _lcount;
    _secretperc /= _lcount;
    _treasureperc /= _tcount;
    return (((_achperc + _coinperc + _rankperc + _ttrankperc + _secretperc + _treasureperc) / 6) * 100) + _prankperc + _ttprankperc;
}
