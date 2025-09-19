function array_get_undefined(arg0, arg1)
{
    try
    {
        return array_get(arg0, arg1);
    }
    catch (_ex)
    {
        return undefined;
    }
}

function is_player_grabbing(arg0 = obj_player)
{
    return arg0.state == states.suplexgrab || arg0.state == states.shoulderbash || arg0.state == states.kungfu || arg0.state == states.lunge;
}

function draw_rotated_primcircle(arg0, arg1, arg2, arg3, arg4)
{
    var _add = 360 / arg4;
    draw_primitive_begin(pr_trianglefan);
    draw_vertex(arg0, arg1);
    
    for (var i = 0; i < arg4; i++)
        draw_vertex(arg0 + lengthdir_x(arg2, arg3 + (_add * i)), arg1 + lengthdir_y(arg2, arg3 + (_add * i)));
    
    draw_primitive_end();
}

function roundlower(arg0)
{
    if (frac(arg0) <= 0.5)
        return floor(arg0);
    
    if (frac(arg0) > 0.5)
        return ceil(arg0);
}

function delete_covered_tiles(arg0 = id, arg1 = false)
{
    with (arg0)
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
                    
                    if (arg1)
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
    var _checks = [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]];
    
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

function object_is_parent_or_ancestor(arg0, arg1 = object_index)
{
    return arg1 == arg0 || object_is_ancestor(arg1, arg0);
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
    input_axis_threshold_set(32785, global.horizdeadzone, 1);
    input_axis_threshold_set(32787, global.horizdeadzone, 1);
    input_axis_threshold_set(32786, global.vertdeadzone, 1);
    input_axis_threshold_set(32788, global.vertdeadzone, 1);
}

function array_find_pos(arg0, arg1)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        if (arg0[i] == arg1)
            return i;
    }
    
    return -1;
}

function string_wordwrap_width(arg0, arg1, arg2, arg3)
{
    var pos_space = -1;
    var pos_current = 1;
    var text_current = arg0;
    
    if (is_real(arg2))
        arg2 = "#";
    
    var text_output = "";
    
    while (string_length(text_current) >= pos_current)
    {
        if (string_width(string_copy(text_current, 1, pos_current)) > arg1)
        {
            if (pos_space != -1)
            {
                text_output += (string_copy(text_current, 1, pos_space) + string(arg2));
                text_current = string_copy(text_current, pos_space + 1, string_length(text_current) - pos_space);
                pos_current = 1;
                pos_space = -1;
            }
            else if (arg3)
            {
                text_output += (string_copy(text_current, 1, pos_current - 1) + string(arg2));
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

function there_is_follower_obj(arg0)
{
    with (arg0)
    {
        if (array_get_index(global.followers, id) != -1)
            return true;
    }
    
    return false;
}

function there_is_follower_id(arg0)
{
    return instance_exists(arg0) && array_get_index(global.followers, arg0) != -1;
}

function create_uparrow()
{
    var _createdID = instance_create_depth(bbox_left, bbox_top, depth, obj_uparrowhitbox);
    _createdID.image_xscale = bbox_right - bbox_left;
    _createdID.image_yscale = bbox_bottom - bbox_top;
    _createdID.owner = id;
    return _createdID;
}

function fire_ray(arg0, arg1, arg2, arg3, arg4 = 1, arg5 = noone, arg6 = noone, arg7 = spr_1x1)
{
    var _dist = point_distance(arg0, arg1, arg2, arg3);
    var _dir = point_direction(arg0, arg1, arg2, arg3);
    var _mask = mask_index;
    var _raystruct = 
    {
        x: 0,
        y: 0,
        clear: true
    };
    var _ogx = x;
    var _ogy = y;
    mask_index = arg7;
    
    if (_dist > 0)
    {
        var i = 0;
        
        while (i < _dist)
        {
            _raystruct.x = arg0 + lengthdir_x(i, _dir);
            _raystruct.y = arg1 + lengthdir_y(i, _dir);
            x = _raystruct.x;
            y = _raystruct.y;
            _raystruct.clear = true;
            
            if (scr_solid(x + sign(lengthdir_x(1, _dir)), y + sign(lengthdir_y(1, _dir))))
            {
                if (arg5 == noone || !place_meeting(x + sign(lengthdir_x(1, _dir)), y + sign(lengthdir_y(1, _dir)), arg5))
                {
                    _raystruct.clear = false;
                    break;
                }
                else
                {
                    i += arg4;
                }
            }
            else
            {
                i += arg4;
            }
        }
    }
    
    mask_index = _mask;
    x = _ogx;
    y = _ogy;
    return _raystruct;
}

function fast_ray(arg0, arg1, arg2, arg3)
{
    static _il = global.instancelist;
    
    var _y = arg3;
    var _num = collision_rectangle_list(arg0, arg1, arg2, arg3, [obj_solid, obj_slope, (arg3 > arg1) ? obj_platform : noone], false, true, _il, true);
    
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
                    object_side = max(arg0, arg2);
                    slope_start = bbox_bottom;
                    slope_end = bbox_top;
                }
                else
                {
                    object_side = min(arg0, arg2);
                    slope_start = bbox_top;
                    slope_end = bbox_bottom;
                }
                
                var m = (sign(image_xscale) * (bbox_bottom - bbox_top)) / (bbox_right - bbox_left);
                _y = min(clamp(slope_start - round(m * (object_side - bbox_left)), bbox_top, bbox_bottom), _y);
            }
        }
        else
        {
            _y = min(_y, _instance.bbox_top);
        }
    }
    
    ds_list_clear(_il);
    return _y - 1;
}

function get_escapetime(arg0)
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

function create_key(arg0)
{
    return 
    {
        key: arg0
    };
}

function scr_tiptext(arg0, arg1 = noone)
{
    var _dothing = true;
    var _id = noone;
    
    if (arg1 != noone)
    {
        save_open();
        _dothing = !ini_read_real("GameProgress", arg1, false);
        ini_write_real("GameProgress", arg1, true);
        save_close();
    }
    
    if (_dothing)
    {
        instance_destroy(obj_tiptext);
        
        with (instance_create_depth(0, 0, -11500, obj_tiptext))
        {
            text = arg0;
            _id = id;
        }
    }
    
    return _id;
}

function draw_input(arg0, arg1, arg2, arg3, arg4 = true, arg5 = input_profile_get(), arg6 = 0, arg7 = spr_controllerbuttons, arg8 = spr_keyboardkey, arg9 = spr_keyfunctions, arg10 = global.keyfont, arg11 = 0)
{
    if (arg3 != "any")
    {
        var _icon = input_verb_get_icon(arg3, 0, arg6, arg5);
        
        if (is_struct(_icon) || is_string(_icon))
        {
            draw_sprite_ext(arg8, 0, arg0, arg1, 1, 1, 0, c_white, arg2);
            
            if (is_string(_icon))
            {
                var _prevfont = draw_get_font();
                draw_set_font(arg10);
                __draw_text_colour_hook(arg0, arg1, _icon, arg11, arg11, arg11, arg11, arg2);
                draw_set_font(_prevfont);
            }
            else
            {
                draw_sprite_ext(arg9, _icon.key, arg0, arg1, 1, 1, 0, arg11, arg2);
            }
        }
        else
        {
            var _ind = _icon;
            
            if (arg4)
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
            
            draw_sprite_ext(arg7, _ind, arg0, arg1, 1, 1, 0, c_white, arg2);
        }
    }
    else
    {
        draw_sprite_ext(arg7, 35, arg0, arg1, 1, 1, 0, c_white, arg2);
    }
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
            var _pizzas = (global.currentbadge == 3) + 1;
            
            repeat (_pizzas)
            {
                with (instance_create_depth(x + irandom_range(-3, 3), y + irandom_range(-3, 3), -15000, obj_collectparticle))
                {
                    sprite_index = get_collectspr(2, obj_player.character);
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
            var _pizzas = (global.currentbadge == 3) + 1;
            
            repeat (_pizzas)
            {
                with (instance_create_depth(x + irandom_range(-3, 3), y + irandom_range(-3, 3), -15000, obj_collectparticle))
                {
                    sprite_index = get_collectspr(2, obj_player.character);
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

function json_are_equal(arg0, arg1)
{
    var type = typeof(arg0);
    
    if (type != typeof(arg1))
        return false;
    
    switch (type)
    {
        case "array":
            var n = array_length(arg0);
            
            if (n != array_length(arg1))
                return false;
            
            for (var i = 0; i < n; i++)
            {
                if (!json_are_equal(arg0[i], arg1[i]))
                    return false;
            }
            
            break;
        
        case "struct":
            var ks = variable_struct_get_names(arg0);
            var n = array_length(ks);
            var ksb = variable_struct_get_names(arg1);
            
            if (n != array_length(ksb))
                return false;
            
            for (var i = 0; i < n; i++)
            {
                var k = ks[i];
                
                if (!(variable_struct_exists(arg1, k) && json_are_equal(variable_struct_get(arg0, k), variable_struct_get(arg1, k))))
                    return false;
            }
            
            break;
        
        default:
            if (arg0 != arg1)
                return false;
    }
}

function obj_moved(arg0, arg1)
{
    return abs(arg1 - arg0) >= 1;
}

function update_object_coordinates(arg0 = id)
{
    if (room != rank_room && room != rank_roomtutorial)
    {
        with (obj_pizzaface)
        {
            x = arg0.x;
            y = arg0.y;
        }
    }
    
    with (obj_keyinv)
    {
        x = (arg0.xscale == 1) ? (arg0.x - 32) : (arg0.x + 32);
        y = arg0.y - 16;
    }
    
    with (obj_cowboyhat)
    {
        if (persistent)
        {
            x = arg0.x;
            y = (arg0.y + sprite_get_bbox_top(arg0.sprite_index)) - 15;
        }
    }
    
    with (arg0)
    {
        array_foreach(global.followers, function(arg0, arg1)
        {
            with (arg0)
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
        _coins += ds_list_size(ds_map_find_value(global.pizzacointracker, global.levels[i]));
    
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

function badge_at_pos(arg0, arg1, arg2, arg3, arg4 = 0, arg5 = 0)
{
    var _badgewidth = 128;
    var _badgeheight = 128;
    var _badgeswidth = arg0 / arg1;
    _badgeswidth *= _badgewidth;
    var _badgesheight = arg1 * _badgeheight;
    var _badgestruct = 
    {
        x: arg3,
        y: arg3,
        info: array_get_undefined(arg2, arg3)
    };
    
    with (_badgestruct)
    {
        x %= (arg0 / arg1);
        x *= _badgewidth;
        x += (_badgewidth / 2);
        x -= (_badgeswidth / 2);
        x += arg4;
        y = (y / arg0) * arg1;
        y = floor(y);
        y *= _badgeheight;
        y += (_badgeheight / 2);
        y -= (_badgesheight / 2);
        y += arg5;
    }
    
    return _badgestruct;
}

function get_collectspr(arg0, arg1)
{
    switch (arg0)
    {
        case 0:
            if (arg1 == "N")
                return choose(spr_halloweencollectibles1, spr_halloweencollectibles2, spr_halloweencollectibles3, spr_halloweencollectibles4, spr_halloweencollectibles5);
            
            if (arg1 == "S")
                return spr_snickcollectible1;
            
            return choose(spr_shroomcollect, spr_tomatocollect, spr_cheesecollect, spr_sausagecollect, spr_pineapplecollect);
        
        case 1:
            return spr_pizzaslice;
        
        case 2:
            if (arg1 == "N")
                return choose(spr_pizzacollect1halloween, spr_pizzacollect2halloween, spr_pizzacollect3halloween);
            
            if (arg1 == "S")
                return spr_snickcollectible2;
            
            return choose(spr_pizzacollect, spr_pizzacollect2, spr_pizzacollect3, spr_pizzacollect4, spr_pizzacollect5);
        
        case 3:
            if (arg1 == "N")
                return spr_giantpizzahalloween;
            
            if (arg1 == "S")
                return spr_snickcollectible3;
            
            return spr_giantpizza;
        
        case 4:
            if (arg1 == "N")
                return spr_noisedestroyable2;
            
            return spr_destroyable2;
        
        case 5:
            if (arg1 == "N")
                return spr_noisedestroyable2dead;
            
            return spr_destroyable2dead;
        
        case 6:
            if (arg1 == "N")
                return spr_noisedestroyable2big;
            
            return spr_destroyable2big;
        
        case 7:
            if (arg1 == "N")
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

function restore_combo(arg0 = 60)
{
    if (global.currentbadge == 3 && global.combogalstate != states.normal && global.levelname != "tutorial")
        exit;
    
    if (global.combo <= 0 || arg0 < 0)
        exit;
    
    global.combotime += arg0;
    global.combotime = min(60, global.combotime);
    
    if (global.combogalstate < 1)
        global.combogalstate = states.tumble;
}

function add_combo(arg0 = 1)
{
    if (global.currentbadge == 3 && global.combogalstate == states.finishingblow && global.levelname != "tutorial")
        exit;
    
    global.combo += arg0;
    obj_player.supertauntcooldown += 1;
    restore_combo();
}

function add_collect(arg0 = 5)
{
    global.collect += arg0;
}

function ach_perc()
{
    var _count = 0;
    
    for (var i = 0; i < array_length(obj_achievementtracker.achievementlist); i++)
        _count += ini_read_real("Achievements", obj_achievementtracker.achievementlist[i], false);
    
    return _count / array_length(obj_achievementtracker.achievementlist);
}

function get_levelcoincount(arg0)
{
    return ds_list_size(ds_map_find_value(global.pizzacointracker, arg0));
}

function string_width_fancy(arg0)
{
    var _font = draw_get_font();
    var _width = 0;
    arg0 = string_replace_all(arg0, "{S}", "");
    arg0 = string_replace_all(arg0, "{V}", "");
    arg0 = string_replace_all(arg0, "{W}", "");
    arg0 = string_replace_all(arg0, "{/}", "");
    var _arrays = ds_map_keys_to_array(global.inputs);
    
    for (var _i = 0; _i < array_length(_arrays); _i++)
    {
        _width += (global.fontextra[_font][4] * string_count(_arrays[_i], arg0));
        arg0 = string_replace_all(arg0, _arrays[_i], "");
    }
    
    _width += string_width(arg0);
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

function get_level_tt_time(arg0, arg1)
{
    switch (arg0)
    {
        case "entry":
            if (arg1 == 3)
                return 7020;
            
            if (arg1 == 2)
                return 7800;
            
            if (arg1 == 1)
                return 10200;
            
            break;
        
        case "medieval":
            if (arg1 == 3)
                return 8640;
            
            if (arg1 == 2)
                return 9600;
            
            if (arg1 == 1)
                return 12000;
            
            break;
        
        case "ruin":
            if (arg1 == 3)
                return 10080;
            
            if (arg1 == 2)
                return 12000;
            
            if (arg1 == 1)
                return 14400;
            
            break;
        
        case "dungeon":
            if (arg1 == 3)
                return 10800;
            
            if (arg1 == 2)
                return 13200;
            
            if (arg1 == 1)
                return 14400;
            
            break;
        
        case "dragonslair":
            if (arg1 == 3)
                return 12060;
            
            if (arg1 == 2)
                return 13800;
            
            if (arg1 == 1)
                return 16200;
            
            break;
    }
}
