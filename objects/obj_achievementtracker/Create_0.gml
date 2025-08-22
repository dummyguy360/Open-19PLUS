popupstruct = 
{
    type: -1
};
popupy = 0;
popuptime = 200;
achievements = [];
notifications = ds_list_create();
popupqueue = ds_list_create();
variables = ds_map_create();
add_achievement("entry1", function()
{
}, function(arg0)
{
    var _type = arg0[0];
    var _info = arg0[1];
    
    if (_type == 4 && _info[0] >= 480 && global.levelname == "entry")
        achievement_get(saveid, spr_cowboytask_entry1, 1);
});
add_achievement("entry2", function()
{
    add_achievement_variable("entry2tracker", -1, 2);
}, function(arg0)
{
    var _type = arg0[0];
    var _info = arg0[1];
    
    if (_type == 0 && global.levelname == "entry")
    {
        if (ds_list_find_index(get_achvariable("entry2tracker").value, _info[0]) == -1)
            set_achvariable("entry2tracker", _info[0]);
        
        if (ds_list_size(get_achvariable("entry2tracker").value) >= 12)
            achievement_get(saveid, spr_cowboytask_entry2, 1);
    }
}, function()
{
    ds_list_destroy(get_achvariable("entry2tracker").value);
});
add_achievement("entry3", function()
{
    add_achievement_variable("entry3tracker", -1, 2);
}, function(arg0)
{
    var _type = arg0[0];
    var _info = arg0[1];
    
    if (_type == 11 && global.levelname == "entry")
    {
        if (ds_list_find_index(get_achvariable("entry3tracker").value, _info[1]) == -1)
            set_achvariable("entry3tracker", _info[1]);
        
        if (ds_list_size(get_achvariable("entry3tracker").value) >= 10)
            achievement_get(saveid, spr_cowboytask_entry3, 1);
    }
}, function()
{
    ds_list_destroy(get_achvariable("entry3tracker").value);
});
add_achievement("medieval1", function()
{
    add_achievement_variable("medieval1tracker", false, 0);
}, function(arg0)
{
    var _type = arg0[0];
    
    if (global.levelname == "medieval")
    {
        if (_type == 6)
            set_achvariable("medieval1tracker", true);
        
        if (_type == 18 && !get_achvariable("medieval1tracker").value)
            achievement_get(saveid, spr_cowboytask_medieval1, 1);
    }
});
add_achievement("medieval2", function()
{
    add_achievement_variable("medieval2tracker", 0, 0);
}, function(arg0)
{
    var _type = arg0[0];
    
    if (_type == 9 && global.levelname == "medieval" && !obj_music.secret)
    {
        set_achvariable("medieval2tracker", get_achvariable("medieval2tracker").value + 1);
        
        if (get_achvariable("medieval2tracker").value >= 11)
            achievement_get(saveid, spr_cowboytask_medieval2, 1);
    }
});
add_achievement("medieval3", function()
{
}, function(arg0)
{
    var _type = arg0[0];
    var _info = arg0[1];
    
    if (_type == 16 && global.levelname == "medieval" && _info[0] >= 5)
        achievement_get(saveid, spr_cowboytask_medieval3, 1);
});
add_achievement("ruin1", function()
{
    add_achievement_variable("ruin1tracker", -1, 2);
}, function(arg0)
{
    var _type = arg0[0];
    var _info = arg0[1];
    
    if (_type == 1 && global.levelname == "ruin" && !obj_music.secret)
    {
        if (ds_list_find_index(get_achvariable("ruin1tracker").value, _info[0]) == -1)
            set_achvariable("ruin1tracker", _info[0]);
        
        if (ds_list_size(get_achvariable("ruin1tracker").value) >= global.cheeseblocknumb)
            achievement_get(saveid, spr_cowboytask_ruin1, 1);
    }
}, function()
{
    ds_list_destroy(get_achvariable("ruin1tracker").value);
});
add_achievement("ruin2", function()
{
}, function(arg0)
{
    var _type = arg0[0];
    var _info = arg0[1];
    
    if (_type == 10 && global.levelname == "ruin" && _info[0])
        achievement_get(saveid, spr_cowboytask_ruin2, 1);
});
add_achievement("ruin3", function()
{
    add_achievement_variable("ruin3tracker", 0, 0);
}, function(arg0)
{
    var _type = arg0[0];
    
    if (_type == 8 && global.levelname == "ruin")
    {
        set_achvariable("ruin3tracker", get_achvariable("ruin3tracker").value + 1);
        
        if (get_achvariable("ruin3tracker").value >= 43)
            achievement_get(saveid, spr_cowboytask_ruin3, 1);
    }
});
add_achievement("dungeon1", function()
{
    add_achievement_variable("dungeon1tracker", false, 0);
}, function(arg0)
{
    var _type = arg0[0];
    
    if (global.levelname == "dungeon")
    {
        if (_type == 3)
            set_achvariable("dungeon1tracker", true);
        
        if (_type == 18 && !get_achvariable("dungeon1tracker").value)
            achievement_get(saveid, spr_cowboytask_dungeon1, 1);
    }
});
add_achievement("dungeon2", function()
{
    add_achievement_variable("dungeon2tracker", 0, 0);
}, function(arg0)
{
    var _type = arg0[0];
    
    if (global.levelname == "dungeon")
    {
        if (_type == 14)
        {
            set_achvariable("dungeon2tracker", get_achvariable("dungeon2tracker").value + 1);
            
            if (get_achvariable("dungeon2tracker").value >= 3)
                achievement_get(saveid, spr_cowboytask_dungeon2, 1);
        }
    }
});
add_achievement("dungeon3", function()
{
    add_achievement_variable("dungeon3tracker", 0, 0);
}, function(arg0)
{
    var _type = arg0[0];
    var _info = arg0[1];
    
    if (global.levelname == "dungeon")
    {
        if (_type == 15 && _info[0] == obj_ancho && _info[1] == obj_fencer)
        {
            set_achvariable("dungeon3tracker", get_achvariable("dungeon3tracker").value + 1);
            
            if (get_achvariable("dungeon3tracker").value >= 3)
                achievement_get(saveid, spr_cowboytask_dungeon3, 1);
        }
    }
});
add_achievement("dragonslair1", function()
{
}, function(arg0)
{
    var _type = arg0[0];
    
    if (global.levelname == "dragonslair")
    {
        if (_type == 13)
            achievement_get(saveid, spr_cowboytask_dragonslair1, 1);
    }
});
add_achievement("dragonslair2", function()
{
    add_achievement_variable("dragonslair2tracker", 0, 0);
}, function(arg0)
{
    var _type = arg0[0];
    
    if (global.levelname == "dragonslair")
    {
        if (_type == 17)
            set_achvariable("dragonslair2tracker", true);
        
        if (_type == 18 && !get_achvariable("dragonslair2tracker").value)
            achievement_get(saveid, spr_cowboytask_dragonslair2, 1);
    }
});
add_achievement("dragonslair3", function()
{
}, function(arg0)
{
    var _type = arg0[0];
    var _info = arg0[1];
    
    if (global.levelname == "dragonslair")
    {
        if (_type == 18 && _info[0] >= 120)
            achievement_get(saveid, spr_cowboytask_dragonslair3, 1);
    }
});
add_unlock("timetrialunlocked", function()
{
}, function(arg0)
{
    var _type = arg0[0];
    
    if (_type == 19)
    {
        var _shouldunlock = true;
        save_open();
        var i = 0;
        
        while (i < 4)
        {
            if (ini_read_real("Ranks", global.levels[i], -1) == -1)
            {
                _shouldunlock = false;
                break;
            }
            else
            {
                i++;
            }
        }
        
        save_close();
        
        if (_shouldunlock)
            unlockable_unlock(saveid, spr_notif_timetrialunlock, 0);
    }
});

for (var i = 0; i < array_length(achievements); i++)
{
    with (achievements[i])
        self.setupfunc();
}

achievementlist = [];

for (var l = 0; l < array_length(achievements); l++)
{
    if (achievements[l].type == 0)
        array_push(achievementlist, achievements[l].saveid);
}

achievements_load();
