uparrowid = create_uparrow();
perc = -1;
time = -1;
showtext = false;

function get_file_percentage()
{
    var _cointracker;
    
    if (file_exists(get_savedir() + "/playerWallet.save"))
    {
        _cointracker = ds_map_create();
        
        for (var i = 0; i < array_length(global.levels); i++)
            _cointracker[? global.levels[i]] = ds_list_create();
        
        var _walletbuff = buffer_load(get_savedir() + "/playerWallet.save");
        var _walletuncomp = buffer_decompress(_walletbuff);
        
        if (_walletuncomp != -1)
        {
            var _wallet = buffer_read(_walletuncomp, buffer_string);
            ini_open_from_string(_wallet);
            var _walletver = ini_read_string("Version", "version", 0);
            
            if (_walletver == 0)
            {
                for (var i = 0; i < array_length(global.levels); i++)
                {
                    var _str = ini_read_string("Data", global.levels[i], "");
                    
                    if (_str != "")
                        ds_list_read(_cointracker[? global.levels[i]], _str);
                }
            }
            
            ini_close();
            buffer_delete(_walletuncomp);
        }
        
        buffer_delete(_walletbuff);
    }
    
    ini_open(get_savedir() + "/saveData.save");
    
    if (file_exists(get_savedir() + "/playerWallet.save"))
        perc = floor(calc_perc(_cointracker));
    else
        perc = floor(calc_perc());
    
    time = ini_read_real("GameProgress", "saveage", 0);
    ini_close();
    
    for (var i = 0; i < array_length(global.levels); i++)
    {
        ds_list_destroy(_cointracker[? global.levels[i]]);
        _cointracker[? global.levels[i]] = -1;
    }
    
    ds_map_destroy(_cointracker);
}

if (file_exists(get_savedir() + "/saveData.save"))
{
    get_file_percentage();
    
    with (obj_readme)
        vis = false;
}
