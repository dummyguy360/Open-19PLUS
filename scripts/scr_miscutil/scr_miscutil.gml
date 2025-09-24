function array_get_undefined(_var, _index)
{
    try
    {
        return array_get(_var, _index);
    }
    catch (_ex)
    {
        return undefined;
    }
}

function is_player_grabbing(p = obj_player)
{
    return p.state == states.suplexgrab || p.state == states.shoulderbash || p.state == states.kungfu || p.state == states.lunge;
}

function draw_rotated_primcircle(_x, _y, _len, _dir, _vertex_amount)
{
    var _add = 360 / _vertex_amount;
    draw_primitive_begin(pr_trianglefan);
    draw_vertex(_x, _y);
    
    for (var i = 0; i < _vertex_amount; i++)
        draw_vertex(_x + lengthdir_x(_len, _dir + (_add * i)), _y + lengthdir_y(_len, _dir + (_add * i)));
    
    draw_primitive_end();
}

function roundlower(val)
{
    if (frac(val) <= 0.5)
        return floor(val);
    
    if (frac(val) > 0.5)
        return ceil(val);
}

function delete_covered_tiles(_obj = id, create_debris = false)
{
    with (_obj)
    {
        var _layers = layer_get_all();
        
        for (var i = 0; i < array_length(_layers); i++)
        {
            if (string_pos("KITY", layer_get_name(_layers[i])) > 0)
                continue;
            
            var _layer = _layers[i];
            var _mapid = layer_tilemap_get_id(_layer);
            
            if (_mapid < 0)
                continue;
            
            var _tileset = tilemap_get_tileset(_mapid);
            var _gridW = tilemap_get_tile_width(_mapid);
            var _gridH = tilemap_get_tile_height(_mapid);
            var _occupiedtilesX = sprite_width / _gridW;
            var _occupiedtilesY = sprite_height / _gridH;
            
            for (var _x = 0; _x < _occupiedtilesX; _x++)
            {
                for (var _y = 0; _y < _occupiedtilesY; _y++)
                {
                    var _tilex = floor(x + (_gridW * _x));
                    var _tiley = floor(y + (_gridH * _y));
                    var _data = tilemap_get_at_pixel(_mapid, _tilex + 1, _tiley + 1);
                    
                    if (create_debris)
                    {
                        with (instance_create_depth(_tilex, _tiley, 0, obj_tiledebris))
                        {
                            tileset = _tileset;
                            data = _data;
                        }
                    }
                    
                    _data = tile_set_empty(_data);
                    tilemap_set_at_pixel(_mapid, _data, _tilex + 1, _tiley + 1);
                }
            }
        }
    }
}

function destroy_clips()
{
    var _checks = [ [x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1] ];
    
    for (var _i = 0; _i < array_length(_checks); _i++)
    {
        var _pos = _checks[_i];
        var _inst = instance_place(_pos[0], _pos[1], obj_clipparent);
        
        while (_inst != noone)
        {
            instance_destroy(_inst);
            _inst = instance_place(_pos[0], _pos[1], obj_clipparent);
        }
    }
}

function object_is_parent_or_ancestor(_obj_par, _obj_to_check = object_index)
{
    return _obj_to_check == _obj_par || object_is_ancestor(_obj_to_check, _obj_par);
}

function reset_aspectratio()
{
    var _width = global.currentinternalres[0];
    var _height = global.currentinternalres[1];
    var _width2 = global.currentres[0];
    var _height2 = global.currentres[1];
    var _width3 = global.maxscreenwidth;
    var _height3 = global.maxscreenheight;
    view_wport[0] = _width;
    view_hport[0] = _height;
    view_wport[1] = _width3;
    view_hport[1] = _height3;
    camera_set_view_size(view_camera[0], _width, _height);
    camera_set_view_size(view_camera[1], _width3, _height3);
    surface_resize(application_surface, _width2, _height2);
    
    if (global.fullscreen == 0 && !gameframe_is_maximised())
        gameframe_restore(true);
    else
        gameframe_set_fullscreen(global.fullscreen);
    
    if (global.fullscreen == 0 && !gameframe_is_maximised())
    {
        window_set_size(_width2, _height2);
        window_center();
    }
    
    display_reset(0, global.vsync);
}

function apply_videoglobals()
{
    global.currentres = global.screensizes[global.resmode][global.resnumb];
    global.currentinternalres = global.screensizes[global.resmode][1];
    reset_aspectratio();
}

function apply_inputglobals()
{
    input_axis_threshold_set(gp_axislh, global.horizdeadzone, 1);
    input_axis_threshold_set(gp_axisrh, global.horizdeadzone, 1);
    input_axis_threshold_set(gp_axislv, global.vertdeadzone, 1);
    input_axis_threshold_set(gp_axisrv, global.vertdeadzone, 1);
}

function array_find_pos(array, entry)
{
    for (var i = 0; i < array_length(array); i++)
    {
        if (array[i] == entry)
            return i;
    }
    
    return -1;
}

function string_wordwrap_width(_str, _spacing, _spacing_str, _pos_type)
{
    var pos_space = -1;
    var pos_current = 1;
    var text_current = _str;
    
    if (is_real(_spacing_str))
        _spacing_str = "#";
    
    var text_output = "";
    
    while (string_length(text_current) >= pos_current)
    {
        if (string_width(string_copy(text_current, 1, pos_current)) > _spacing)
        {
            if (pos_space != -1)
            {
                text_output += (string_copy(text_current, 1, pos_space) + string(_spacing_str));
                text_current = string_copy(text_current, pos_space + 1, string_length(text_current) - pos_space);
                pos_current = 1;
                pos_space = -1;
            }
            else if (_pos_type)
            {
                text_output += (string_copy(text_current, 1, pos_current - 1) + string(_spacing_str));
                text_current = string_copy(text_current, pos_current, string_length(text_current) - (pos_current - 1));
                pos_current = 1;
                pos_space = -1;
            }
        }
        
        pos_current += 1;
        
        if (string_char_at(text_current, pos_current) == " ")
            pos_space = pos_current;
    }
    
    if (string_length(text_current) > 0)
        text_output += text_current;
    
    return text_output;
}

function there_is_follower_obj(_obj)
{
    with (_obj)
    {
        if (array_get_index(global.followers, id) != -1)
            return true;
    }
    
    return false;
}

function there_is_follower_id(_obj)
{
    return instance_exists(_obj) && array_get_index(global.followers, _obj) != -1;
}

function create_uparrow()
{
    var _createdID = instance_create_depth(bbox_left, bbox_top, depth, obj_uparrowhitbox);
    _createdID.image_xscale = bbox_right - bbox_left;
    _createdID.image_yscale = bbox_bottom - bbox_top;
    _createdID.owner = id;
    return _createdID;
}

function fire_ray(_x1, _y1, _x2, _y2, _check = 1, _obj = noone, _unused = noone, _mask_index = spr_1x1)
{
    var _dist = point_distance(_x1, _y1, _x2, _y2);
    var _dir = point_direction(_x1, _y1, _x2, _y2);
    var _mask = mask_index;
    var _raystruct = 
    {
        x: 0,
        y: 0,
        clear: true
    };
    var _ogx = x;
    var _ogy = y;
    mask_index = _mask_index;
    
    if (_dist > 0)
    {
        var i = 0;
        
        while (i < _dist)
        {
            _raystruct.x = _x1 + lengthdir_x(i, _dir);
            _raystruct.y = _y1 + lengthdir_y(i, _dir);
            x = _raystruct.x;
            y = _raystruct.y;
            _raystruct.clear = true;
            
            if (scr_solid(x + sign(lengthdir_x(1, _dir)), y + sign(lengthdir_y(1, _dir))))
            {
                if (_obj == noone || !place_meeting(x + sign(lengthdir_x(1, _dir)), y + sign(lengthdir_y(1, _dir)), _obj))
                {
                    _raystruct.clear = false;
                    break;
                }
                else
                    i += _check;
            }
            else
                i += _check;
        }
    }
    
    mask_index = _mask;
    x = _ogx;
    y = _ogy;
    return _raystruct;
}

function fast_ray(_x1, _y1, _x2, _y2)
{
    static _il = global.instancelist;
    
    var _y = _y2;
    var _num = collision_rectangle_list(_x1, _y1, _x2, _y2, [obj_solid, obj_slope, (_y2 > _y1) ? obj_platform : noone], false, true, _il, true);
    
    for (var _i = 0; _i < _num; _i++)
    {
        var _instance = _il[| _i];
        
        if (place_meeting(x, y, _instance) && object_is_parent_or_ancestor(obj_platform, _instance.object_index))
            continue;
        
        if (object_is_parent_or_ancestor(obj_slope, _instance.object_index))
        {
            with (_instance)
            {
                var object_side = 0;
                var slope_start = 0;
                var slope_end = 0;
                
                if (image_xscale > 0)
                {
                    object_side = max(_x1, _x2);
                    slope_start = bbox_bottom;
                    slope_end = bbox_top;
                }
                else
                {
                    object_side = min(_x1, _x2);
                    slope_start = bbox_top;
                    slope_end = bbox_bottom;
                }
                
                var m = (sign(image_xscale) * (bbox_bottom - bbox_top)) / (bbox_right - bbox_left);
                _y = min(clamp(slope_start - round(m * (object_side - bbox_left)), bbox_top, bbox_bottom), _y);
            }
        }
        else
            _y = min(_y, _instance.bbox_top);
    }
    
    ds_list_clear(_il);
    return _y - 1;
}

function get_escapetime(_unused)
{
    switch (global.levelname)
    {
        case "entry":
            return 195;
        
        case "medieval":
            return 165;
        
        case "ruin":
            return 200;
        
        case "dungeon":
            return 260;
        
        case "dragonslair":
            return 125;
        
        case "sewer":
            return 270;
        
        case "chateau":
            return 239;
        
        case "factory":
            return 299;
        
        case "etb":
            return 180;
        
        default:
            return 60;
    }
}

function add_ghostcollect()
{
    if (obj_music.secret)
    {
        with (obj_drawcontroller)
        {
            array_push(ghostcollectibles, 
            {
                sprite_index: other.sprite_index,
                image_index: other.image_index,
                image_speed: other.image_speed,
                image_number: other.image_number,
                x: other.xstart,
                y: other.ystart
            });
        }
    }
}

function create_key(_key)
{
    return { key: _key };
}

function scr_tiptext(_text, save_progress = noone)
{
    var _dothing = true;
    var _id = noone;
    
    if (save_progress != noone)
    {
        save_open();
        _dothing = !ini_read_real("GameProgress", save_progress, false);
        ini_write_real("GameProgress", save_progress, true);
        save_close();
    }
    
    if (_dothing)
    {
        instance_destroy(obj_tiptext);
        
        with (instance_create_depth(0, 0, -11500, obj_tiptext))
        {
            text = _text;
            _id = id;
        }
    }
    
    return _id;
}

function draw_input(_x, _y, _alpha, _verb, _remap_check = true, _profile = input_profile_get(), _alternate = 0, _controller_button_spr = spr_controllerbuttons, _keyboard_key_spr = spr_keyboardkey, _func_key_spr = spr_keyfunctions, _key_fnt = global.keyfont, _color = #FFFFFF)
{
    if (_verb != "any")
    {
        var _icon = input_verb_get_icon(_verb, 0, _alternate, _profile);
        
        if (is_struct(_icon) || is_string(_icon))
        {
            draw_sprite_ext(_keyboard_key_spr, 0, _x, _y, 1, 1, 0, c_white, _alpha);
            
            if (is_string(_icon))
            {
                var _prevfont = draw_get_font();
                draw_set_font(_key_fnt);
                __draw_text_colour_hook(_x, _y, _icon, _color, _color, _color, _color, _alpha);
                draw_set_font(_prevfont);
            }
            else
                draw_sprite_ext(_func_key_spr, _icon.key, _x, _y, 1, 1, 0, _color, _alpha);
        }
        else
        {
            var _ind = _icon;
            
            if (_remap_check)
            {
                switch (_ind)
                {
                    case 7:
                    case 15:
                    case 20:
                        _ind = 39;
                        break;
                    
                    case 5:
                    case 13:
                    case 18:
                        _ind = 37;
                        break;
                    
                    case 6:
                    case 14:
                    case 19:
                        _ind = 38;
                        break;
                    
                    case 4:
                    case 12:
                    case 17:
                        _ind = 36;
                        break;
                }
            }
            
            draw_sprite_ext(_controller_button_spr, _ind, _x, _y, 1, 1, 0, c_white, _alpha);
        }
    }
    else
        draw_sprite_ext(_controller_button_spr, 35, _x, _y, 1, 1, 0, c_white, _alpha);
}

function end_combo_abrupt()
{
    with (obj_player)
    {
        if (global.combo > 0)
        {
            global.combo = 0;
            global.combotime = 0;
            add_collect(global.combopoints);
            var _pizzas = (global.currentbadge == badge.nohit) + 1;
            
            repeat (_pizzas)
            {
                with (instance_create_depth(x + irandom_range(-3, 3), y + irandom_range(-3, 3), -15000, obj_collectparticle))
                {
                    sprite_index = get_collectspr(collect_type.small, obj_player.character);
                    image_speed = 0.35;
                    value = global.combopoints;
                    shake = 10;
                }
            }
            
            global.combopoints = 0;
        }
    }
}

function end_combopoint_abrupt()
{
    with (obj_player)
    {
        if (combopointduration)
        {
            add_collect(combopointstogive);
            var _pizzas = (global.currentbadge == badge.nohit) + 1;
            
            repeat (_pizzas)
            {
                with (instance_create_depth(x + irandom_range(-3, 3), y + irandom_range(-3, 3), -15000, obj_collectparticle))
                {
                    sprite_index = get_collectspr(collect_type.small, obj_player.character);
                    image_speed = 0.35;
                    value = other.combopointstogive;
                    shake = 10;
                }
            }
            
            combopointstogive = 0;
            global.combopoints = 0;
            combopointduration = false;
        }
    }
}

function json_are_equal(_json_file1, _json_file2)
{
    var type = typeof(_json_file1);
    
    if (type != typeof(_json_file2))
        return false;
    
    switch (type)
    {
        case "array":
            var n = array_length(_json_file1);
            
            if (n != array_length(_json_file2))
                return false;
            
            for (var i = 0; i < n; i++)
            {
                if (!json_are_equal(_json_file1[i], _json_file2[i]))
                    return false;
            }
            
            break;
        
        case "struct":
            var ks = variable_struct_get_names(_json_file1);
            var n = array_length(ks);
            var ksb = variable_struct_get_names(_json_file2);
            
            if (n != array_length(ksb))
                return false;
            
            for (var i = 0; i < n; i++)
            {
                var k = ks[i];
                
                if (!(variable_struct_exists(_json_file2, k) && json_are_equal(variable_struct_get(_json_file1, k), variable_struct_get(_json_file2, k))))
                    return false;
            }
            
            break;
        
        default:
            if (_json_file1 != _json_file2)
                return false;
    }
}

function obj_moved(init_val, final_val)
{
    return abs(final_val - init_val) >= 1;
}

function update_object_coordinates(_obj = id)
{
    if (room != rank_room && room != rank_roomtutorial)
    {
        with (obj_pizzaface)
        {
            x = _obj.x;
            y = _obj.y;
        }
    }
    
    with (obj_keyinv)
    {
        x = (_obj.xscale == 1) ? (_obj.x - 32) : (_obj.x + 32);
        y = _obj.y - 16;
    }
    
    with (obj_cowboyhat)
    {
        if (persistent)
        {
            x = _obj.x;
            y = (_obj.y + sprite_get_bbox_top(_obj.sprite_index)) - 15;
        }
    }
    
    with (_obj)
    {
        array_foreach(global.followers, function(_follower, _unused)
        {
            with (_follower)
            {
                ds_queue_clear(followerqueue);
                x = other.x;
                y = other.y;
            }
        });
    }
}

function get_coins()
{
    var _coins = 0;
    
    for (var i = 0; i < array_length(global.levels); i++)
        _coins += ds_list_size(global.pizzacointracker[? global.levels[i]]);
    
    _coins -= ini_read_real("GameProgress", "usedcoins", 0);
    return _coins;
}

function all_badges_bought()
{
    var _badges = ["kungfu", "breakdance", "nohit"];
    
    for (var i = 0; i < array_length(_badges); i++)
    {
        if (!ini_read_real("UnlockedBadges", _badges[i], false))
            return false;
    }
    
    return true;
}

function badge_at_pos(_badgeslots, _badgerows, _badge_amount, _badge_selected, _total_width = 0, _backing_y = 0)
{
    var _badgewidth = 128;
    var _badgeheight = 128;
    var _badgeswidth = _badgeslots / _badgerows;
    _badgeswidth *= _badgewidth;
    var _badgesheight = _badgerows * _badgeheight;
    var _badgestruct = 
    {
        x: _badge_selected,
        y: _badge_selected,
        info: array_get_undefined(_badge_amount, _badge_selected)
    };
    
    with (_badgestruct)
    {
        x %= (_badgeslots / _badgerows);
        x *= _badgewidth;
        x += (_badgewidth / 2);
        x -= (_badgeswidth / 2);
        x += _total_width;
        y = (y / _badgeslots) * _badgerows;
        y = floor(y);
        y *= _badgeheight;
        y += (_badgeheight / 2);
        y -= (_badgesheight / 2);
        y += _backing_y;
    }
    
    return _badgestruct;
}

enum collect_type
{
	big = 0,
	pizzaslice = 1,
	small = 2,
	giant = 3,
	
	destroyable = 4,
	destroyabledead = 5,
	destroyablebig = 6,
	destroyablebigdead = 7
}

function get_collectspr(type, char)
{
    switch (type)
    {
        case collect_type.big:
            if (char == "N")
                return choose(spr_halloweencollectibles1, spr_halloweencollectibles2, spr_halloweencollectibles3, spr_halloweencollectibles4, spr_halloweencollectibles5);
            
            if (char == "S")
                return spr_snickcollectible1;
            
            return choose(spr_shroomcollect, spr_tomatocollect, spr_cheesecollect, spr_sausagecollect, spr_pineapplecollect);
        
        case collect_type.pizzaslice:
            return spr_pizzaslice;
        
        case collect_type.small:
            if (char == "N")
                return choose(spr_pizzacollect1halloween, spr_pizzacollect2halloween, spr_pizzacollect3halloween);
            
            if (char == "S")
                return spr_snickcollectible2;
            
            return choose(spr_pizzacollect, spr_pizzacollect2, spr_pizzacollect3, spr_pizzacollect4, spr_pizzacollect5);
        
        case collect_type.giant:
            if (char == "N")
                return spr_giantpizzahalloween;
            
            if (char == "S")
                return spr_snickcollectible3;
            
            return spr_giantpizza;
        
        case collect_type.destroyable:
            if (char == "N")
                return spr_noisedestroyable2;
            
            return spr_destroyable2;
        
        case collect_type.destroyabledead:
            if (char == "N")
                return spr_noisedestroyable2dead;
            
            return spr_destroyable2dead;
        
        case collect_type.destroyablebig:
            if (char == "N")
                return spr_noisedestroyable2big;
            
            return spr_destroyable2big;
        
        case collect_type.destroyablebigdead:
            if (char == "N")
                return spr_noisedestroyable2bigdead;
            
            return spr_destroyable2bigdead;
    }
}

function get_toppincount()
{
    var _toppins = [obj_pizzakinshroom, obj_pizzakincheese, obj_pizzakintomato, obj_pizzakinsausage, obj_pizzakinpineapple];
    var _num = 0;
    
    for (var i = 0; i < array_length(_toppins); i++)
    {
        if (there_is_follower_obj(_toppins[i]))
            _num++;
    }
    
    return _num;
}

function restore_combo(amount = 60)
{
    if (global.currentbadge == badge.nohit && global.combogalstate != states.normal && global.levelname != "tutorial")
        exit;
    
    if (global.combo <= 0 || amount < 0)
        exit;
    
    global.combotime += amount;
    global.combotime = min(60, global.combotime);
    
    if (global.combogalstate < 1)
        global.combogalstate = states.tumble;
}

function add_combo(amount = 1)
{
    if (global.currentbadge == badge.nohit && global.combogalstate == states.finishingblow && global.levelname != "tutorial")
        exit;
    
    global.combo += amount;
    obj_player.supertauntcooldown += 1;
    restore_combo();
}

function add_collect(amount = 5)
{
    global.collect += amount;
}

function ach_perc()
{
    var _count = 0;
    
    for (var i = 0; i < array_length(obj_achievementtracker.achievementlist); i++)
        _count += ini_read_real("Achievements", obj_achievementtracker.achievementlist[i], false);
    
    return _count / array_length(obj_achievementtracker.achievementlist);
}

function get_levelcoincount(_level)
{
    return ds_list_size(global.pizzacointracker[? _level]);
}

function string_width_fancy(_str)
{
    var _font = draw_get_font();
    var _width = 0;
    _str = string_replace_all(_str, "{S}", "");
    _str = string_replace_all(_str, "{V}", "");
    _str = string_replace_all(_str, "{W}", "");
    _str = string_replace_all(_str, "{/}", "");
    var _arrays = ds_map_keys_to_array(global.inputs);
    
    for (var _i = 0; _i < array_length(_arrays); _i++)
    {
        _width += (global.fontextra[_font][4] * string_count(_arrays[_i], _str));
        _str = string_replace_all(_str, _arrays[_i], "");
    }
    
    _width += string_width(_str);
    return _width;
}

function get_game_width()
{
    return global.currentinternalres[0];
}

function get_game_height()
{
    return global.currentinternalres[1];
}

function get_level_tt_time(_level_name, _tt_rank)
{
    switch (_level_name)
    {
        case "entry":
            if (_tt_rank == tt_rank.purple)
                return 7020;
            
            if (_tt_rank == tt_rank.gold)
                return 7800;
            
            if (_tt_rank == tt_rank.silver)
                return 10200;
            
            break;
        
        case "medieval":
            if (_tt_rank == tt_rank.purple)
                return 8640;
            
            if (_tt_rank == tt_rank.gold)
                return 9600;
            
            if (_tt_rank == tt_rank.silver)
                return 12000;
            
            break;
        
        case "ruin":
            if (_tt_rank == tt_rank.purple)
                return 10080;
            
            if (_tt_rank == tt_rank.gold)
                return 12000;
            
            if (_tt_rank == tt_rank.silver)
                return 14400;
            
            break;
        
        case "dungeon":
            if (_tt_rank == tt_rank.purple)
                return 10800;
            
            if (_tt_rank == tt_rank.gold)
                return 13200;
            
            if (_tt_rank == tt_rank.silver)
                return 14400;
            
            break;
        
        case "dragonslair":
            if (_tt_rank == tt_rank.purple)
                return 12060;
            
            if (_tt_rank == tt_rank.gold)
                return 13800;
            
            if (_tt_rank == tt_rank.silver)
                return 16200;
            
            break;
    }
}
