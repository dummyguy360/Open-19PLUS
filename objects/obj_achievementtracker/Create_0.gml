enum popup_type
{
	cowboytask = 0,
	silent = 1,
	othertask = 2
}
popupstruct = { type: -1 };
popupy = 0;
popuptime = 200;
achievements = [];
notifications = ds_list_create();
popupqueue = ds_list_create();
variables = ds_map_create();

// numbers are fucked up, probably because the devs probably just added them randomly during development
// also yeah i know, the naming could be better, but idc
enum achieve_type
{
	// individual level achievements
	entry1 = 4, // Road Runner
	entry2 = 0, // Bit Orange
	entry3 = 11,// Monkey Business
	
	medieval1 = 6, // Shining Armor
	medieval2 = 9, // Pest Control
	medieval3 = 16,// Ye Ol' Bowling
	
	ruin1 = 1, // Ancient Delicacy
	ruin2 = 10,// Friendly Fire
	ruin3 = 8, // Archeological Nightmare
	
	dungeon1 = 3, // Cutter Caution
	dungeon2 = 14,// Flaming Demise
	dungeon3 = 15,// Pepper Flavored Sardine
	
	dragonslair1 = 13,
	dragonslair2 = 17,
	
	// achievement that some levels share
	// is escape related
	shared_achievement = 18,
	
	// kinda self-explanatory
	timetrial = 19,
	
	// misc achievements
	gethurt = 2,
	hitblock = 7,
	fireass = 5,
	killenemy = 12,
}

#region Entry

add_achievement("entry1", function() { }, function(_achievement)
{
    var _type = _achievement[0];
    var _info = _achievement[1];
    
    if (_type == achieve_type.entry1 && _info[0] >= 480 && global.levelname == "entry")
        achievement_get(saveid, spr_cowboytask_entry1, 1);
});

add_achievement("entry2", function() {
    add_achievement_variable("entry2tracker", -1, 2);
}, function(_achievement)
{
    var _type = _achievement[0];
    var _info = _achievement[1];
    
    if (_type == achieve_type.entry2 && global.levelname == "entry")
    {
        if (ds_list_find_index(get_achvariable("entry2tracker").value, _info[0]) == -1)
            set_achvariable("entry2tracker", _info[0]);
        
        if (ds_list_size(get_achvariable("entry2tracker").value) >= 12)
            achievement_get(saveid, spr_cowboytask_entry2, 1);
    }
}, function() {
    ds_list_destroy(get_achvariable("entry2tracker").value);
});

add_achievement("entry3", function() {
    add_achievement_variable("entry3tracker", -1, 2);
}, function(_achievement)
{
    var _type = _achievement[0];
    var _info = _achievement[1];
    
    if (_type == achieve_type.entry3 && global.levelname == "entry")
    {
        if (ds_list_find_index(get_achvariable("entry3tracker").value, _info[1]) == -1)
            set_achvariable("entry3tracker", _info[1]);
        
        if (ds_list_size(get_achvariable("entry3tracker").value) >= 10)
            achievement_get(saveid, spr_cowboytask_entry3, 1);
    }
}, function() {
    ds_list_destroy(get_achvariable("entry3tracker").value);
});

#endregion
#region PizzaScape

add_achievement("medieval1", function() {
    add_achievement_variable("medieval1tracker", false, 0);
}, function(_achievement)
{
    var _type = _achievement[0];
    
    if (global.levelname == "medieval")
    {
        if (_type == achieve_type.medieval1)
            set_achvariable("medieval1tracker", true);
        
        if (_type == achieve_type.shared_achievement && !get_achvariable("medieval1tracker").value)
            achievement_get(saveid, spr_cowboytask_medieval1, 1);
    }
});

add_achievement("medieval2", function() {
    add_achievement_variable("medieval2tracker", 0, 0);
}, function(_achievement)
{
    var _type = _achievement[0];
    
    if (_type == achieve_type.medieval2 && global.levelname == "medieval" && !obj_music.secret)
    {
        set_achvariable("medieval2tracker", get_achvariable("medieval2tracker").value + 1);
        
        if (get_achvariable("medieval2tracker").value >= 11)
            achievement_get(saveid, spr_cowboytask_medieval2, 1);
    }
});

add_achievement("medieval3", function() { }, function(_achievement)
{
    var _type = _achievement[0];
    var _info = _achievement[1];
    
    if (_type == achieve_type.medieval3 && global.levelname == "medieval" && _info[0] >= 5)
        achievement_get(saveid, spr_cowboytask_medieval3, 1);
});

#endregion
#region Ancient Cheese

add_achievement("ruin1", function() {
    add_achievement_variable("ruin1tracker", -1, 2);
}, function(_achievement)
{
    var _type = _achievement[0];
    var _info = _achievement[1];
    
    if (_type == achieve_type.ruin1 && global.levelname == "ruin" && !obj_music.secret)
    {
        if (ds_list_find_index(get_achvariable("ruin1tracker").value, _info[0]) == -1)
            set_achvariable("ruin1tracker", _info[0]);
        
        if (ds_list_size(get_achvariable("ruin1tracker").value) >= global.cheeseblocknumb)
            achievement_get(saveid, spr_cowboytask_ruin1, 1);
    }
}, function() {
    ds_list_destroy(get_achvariable("ruin1tracker").value);
});

add_achievement("ruin2", function() { }, function(_achievement)
{
    var _type = _achievement[0];
    var _info = _achievement[1];
    
    if (_type == achieve_type.ruin2 && global.levelname == "ruin" && _info[0])
        achievement_get(saveid, spr_cowboytask_ruin2, 1);
});

add_achievement("ruin3", function() {
    add_achievement_variable("ruin3tracker", 0, 0);
}, function(_achievement)
{
    var _type = _achievement[0];
    
    if (_type == achieve_type.ruin3 && global.levelname == "ruin")
    {
        set_achvariable("ruin3tracker", get_achvariable("ruin3tracker").value + 1);
        
        if (get_achvariable("ruin3tracker").value >= 43)
            achievement_get(saveid, spr_cowboytask_ruin3, 1);
    }
});

#endregion
#region Bloodsauce Dungeon

add_achievement("dungeon1", function() {
    add_achievement_variable("dungeon1tracker", false, 0);
}, function(_achievement)
{
    var _type = _achievement[0];
    
    if (global.levelname == "dungeon")
    {
        if (_type == achieve_type.dungeon1)
            set_achvariable("dungeon1tracker", true);
        
        if (_type == achieve_type.shared_achievement && !get_achvariable("dungeon1tracker").value)
            achievement_get(saveid, spr_cowboytask_dungeon1, 1);
    }
});

add_achievement("dungeon2", function() {
    add_achievement_variable("dungeon2tracker", 0, 0);
}, function(_achievement)
{
    var _type = _achievement[0];
    
    if (global.levelname == "dungeon")
    {
        if (_type == achieve_type.dungeon2)
        {
            set_achvariable("dungeon2tracker", get_achvariable("dungeon2tracker").value + 1);
            
            if (get_achvariable("dungeon2tracker").value >= 3)
                achievement_get(saveid, spr_cowboytask_dungeon2, 1);
        }
    }
});

add_achievement("dungeon3", function() {
    add_achievement_variable("dungeon3tracker", 0, 0);
}, function(_achievement)
{
    var _type = _achievement[0];
    var _info = _achievement[1];
    
    if (global.levelname == "dungeon")
    {
        if (_type == achieve_type.dungeon3 && _info[0] == obj_ancho && _info[1] == obj_fencer)
        {
            set_achvariable("dungeon3tracker", get_achvariable("dungeon3tracker").value + 1);
            
            if (get_achvariable("dungeon3tracker").value >= 3)
                achievement_get(saveid, spr_cowboytask_dungeon3, 1);
        }
    }
});

#endregion
#region Dragon's Lair

add_achievement("dragonslair1", function() { }, function(_achievement)
{
    var _type = _achievement[0];
    
    if (global.levelname == "dragonslair")
    {
        if (_type == achieve_type.dragonslair1)
            achievement_get(saveid, spr_cowboytask_dragonslair1, 1);
    }
});

add_achievement("dragonslair2", function() {
    add_achievement_variable("dragonslair2tracker", 0, 0);
}, function(_achievement)
{
    var _type = _achievement[0];
    
    if (global.levelname == "dragonslair")
    {
        if (_type == achieve_type.dragonslair2)
            set_achvariable("dragonslair2tracker", true);
        
        if (_type == achieve_type.shared_achievement && !get_achvariable("dragonslair2tracker").value)
            achievement_get(saveid, spr_cowboytask_dragonslair2, 1);
    }
});

add_achievement("dragonslair3", function() { }, function(_achievement)
{
    var _type = _achievement[0];
    var _info = _achievement[1];
    
    if (global.levelname == "dragonslair")
    {
        if (_type == achieve_type.shared_achievement && _info[0] >= 120)
            achievement_get(saveid, spr_cowboytask_dragonslair3, 1);
    }
});

#endregion
#region Time Trial

add_unlock("timetrialunlocked", function() { }, function(_achievement)
{
    var _type = _achievement[0];
    
    if (_type == achieve_type.timetrial)
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
                i++;
        }
        
        save_close();
        
        if (_shouldunlock)
            unlockable_unlock(saveid, spr_notif_timetrialunlock, 0);
    }
});

#endregion

for (var i = 0; i < array_length(achievements); i++)
{
    with (achievements[i])
        self.setupfunc();
}

achievementlist = [];

for (var l = 0; l < array_length(achievements); l++)
{
    if (achievements[l].type == popup_type.cowboytask)
        array_push(achievementlist, achievements[l].saveid);
}

achievements_load();
