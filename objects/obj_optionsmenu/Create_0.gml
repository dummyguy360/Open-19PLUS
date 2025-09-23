draw_set_font(global.font);
optiontip = string_get("menu/options/tips/generic");

#region Menu Functions
function MenuItem(_name) constructor
{
    static update = function() { };
    static highlighted = function(_option) { };
    
    static draw = function(_x, _y, _alpha)
    {
        if (is_string(name))
            __draw_text_colour_hook(round(_x), round(_y), name, c_white, c_white, c_white, c_white, 1 / (2 - _alpha));
        else if (name != -1)
            draw_sprite_ext(name, 0, round(_x), round(_y), 1, 1, 0, c_white, 1 / (2 - _alpha));
    };
    
    static parented = function() { };
    static left_right = function(_normal_val, _slider_val) { };
    static jump = function(_selected) { };
    static taunt = function(_selected) { };
    static unlock = function(_selected) { };
    
    parent = noone;
    yspacing = 50;
    name = _name;
    skip = false;
}

function Spacer(_name = "") : MenuItem(_name) constructor
{
    skip = true;
}

function Option(_name, _variable, _section, _selections = [
	new Selection(string_get("menu/options/generic/no"), false), 
	new Selection(string_get("menu/options/generic/yes"), true)
	], _updateglobals = noone, _auto = false) : MenuItem(_name) constructor
{
    static updatevar = function(_value, _save = true)
    {
        variable_global_set(variable, _value);
        
        if (_save)
            config_set_option(section, variable, _value);
        
        if (updateglobals != noone)
            updateglobals();
    };
    
    static update = function()
    {
        array_foreach(selections, function(_option, _parent)
        {
            _option.update();
        });
    };
    
    static highlighted = function(_option)
    {
        selections[chosensel].highlighted(_option);
    };
    
    static left_right = function(_normal_val, _slider_val)
    {
        if (!parent.locked && !alone)
            chosensel = clamp(chosensel + _normal_val, 0, array_length(selections) - 1);
        else
            selections[chosensel].left_right(_normal_val, _slider_val);
        
        if (!alone && auto && _normal_val != 0)
        {
            updatevar(selections[chosensel].value);
            event_play_oneshot("event:/sfx/pausemenu/impact");
        }
    };
    
    static jump = function(_selected)
    {
        selections[chosensel].jump(_selected);
    };
    
    static taunt = function(_selected)
    {
        selections[chosensel].taunt(_selected);
    };
    
    static unlock = function(_selected)
    {
        selections[chosensel].unlock(_selected);
    };
    
    variable = _variable;
    section = _section;
    selections = _selections;
    updateglobals = _updateglobals;
    auto = _auto;
    chosensel = 0;
    alone = array_length(selections) == 1;
    
    if (variable != "")
    {
        for (var i = 0; i < array_length(selections); i++)
        {
            if (selections[i].value == variable_global_get(variable))
            {
                chosensel = i;
                break;
            }
        }
    }
    
    array_foreach(selections, function(_option, _parent)
    {
        _option.parent = self;
        _option.parented();
    });
}

function Selection(_name, _value) : MenuItem(_name) constructor
{
    static getfolder = function()
    {
        return parent.parent;
    };
    
    static getwidth = function()
    {
        if (forcedwidth != -1)
            return forcedwidth;
        
        if (is_string(name))
            return string_width(name);
        else if (name != -1)
            return sprite_get_width(name);
    };
    
    static highlighted = function(_option)
    {
        _option.optiontip = string_get(parent.auto ? "menu/options/tips/selectionauto" : "menu/options/tips/selection");
    };
    
    static jump = function()
    {
        if (parent.auto)
            exit;
        
        event_play_oneshot("event:/sfx/pausemenu/impact");
        parent.updatevar(value);
    };
    
    value = _value;
    forcedwidth = -1;
}

function VideoSelection(_value) : Selection(-1, _value) constructor
{
    static update = function()
    {
        name = string("{0}X{1}", global.screensizes[global.resmode][value][0], global.screensizes[global.resmode][value][1]);
    };
}

enum sliderval
{
	hidden = 0,
	normal = 1,
	int = 2,
	percent = 3,
	percentalt = 4,
	percentaltALT = 5,
	degree = 6
}

function Slider(_value_min = 0, _value_max = 1, _value_step = 0.01, _visual = sliderval.hidden) : Selection(-1, -1) constructor
{
    static parented = function()
    {
        value = variable_global_get(parent.variable);
    };
    
    static highlighted = function(_option)
    {
        if (parent.alone)
            _option.optiontip = string_get("menu/options/tips/slideralone");
        else if (selected)
            _option.optiontip = string_get("menu/options/tips/slider");
    };
    
    static draw = function(_x, _y, _alpha)
    {
        var _midwidth = forcedwidth / 2;
        var _percent = lerp(0, 100, (value - value_min) / (value_max - value_min));
        var _percentalt = lerp(0, value_max * 100, (value - value_min) / (value_max - value_min));
        var _percentaltalt = lerp(value_min * 100, value_max * 100, (value - value_min) / (value_max - value_min));
        var _text = "";
        draw_sprite(spr_slidertrack, 0, round(_x - _midwidth), round(_y));
        draw_sprite(spr_sliderknob, 0, round((_x - _midwidth) + (200 * (_percent / 100))), round(_y));
        
        switch (visual)
        {
            case sliderval.normal:
                _text = string(value);
                break;
            
            case sliderval.int:
                _text = string(int64(value));
                break;
            
            case sliderval.percent:
                _text = string("{0}%", int64(_percent));
                break;
            
            case sliderval.percentalt:
                _text = string("{0}%", int64(_percentalt));
                break;
            
            case sliderval.percentaltALT:
                _text = string("{0}%", int64(_percentaltalt));
                break;
            
            case sliderval.degree:
                _text = string("{0}°", round(value));
                break;
        }
        
        __draw_text_colour_hook(_x, _y, _text, c_white, c_white, c_white, c_white, 1 / (2 - _alpha));
    };
    
    static jump = function()
    {
        if (!selected && !parent.alone)
        {
            event_play_oneshot("event:/sfx/pausemenu/impact");
            getfolder().locked++;
            selected = true;
        }
    };
    
    static left_right = function(_normal_val, _slider_val)
    {
        value = clamp(value + (_slider_val * value_step), value_min, value_max);
        parent.updatevar(value, parent.alone);
    };
    
    static unlock = function(_selected)
    {
        if (selected && !alone)
        {
            selected = false;
            event_play_oneshot("event:/sfx/pausemenu/rubbersqueak");
            parent.updatevar(value);
            getfolder().locked--;
        }
    };
    
    value_min = _value_min;
    value_max = _value_max;
    value_step = _value_step;
    visual = _visual;
    selected = false;
    forcedwidth = 200;
    alone = false;
}

function Keybinder(_player, _filter) : Selection(-1, -1) constructor
{
    static update = function()
    {
        name = "[J]";
        forcedwidth = 76;
    };
    
    static highlighted = function(_option)
    {
        _option.optiontip = string_get("menu/options/tips/" + (selected ? "keybinder" : "keyconfig"));
    };
    
    static draw = function(_x, _y, _alpha)
    {
        draw_set_valign(fa_top);
        draw_set_halign(fa_left);
        
        for (var i = 0; i < 2; i++)
        {
            var _perc = i / 2;
            draw_input(round(_x - 16 - (forcedwidth * _perc)), round(_y - 16), 1, parent.variable, false, parent.section, i);
        }
        
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
    };
    
    static jump = function()
    {
        if (!selected)
        {
            selected = true;
            event_play_oneshot("event:/sfx/pausemenu/impact");
            getfolder().locked++;
            input_binding_scan_params_set(
				[
					vk_f1, vk_f2, vk_f3, vk_f4, vk_f5, vk_f6, vk_f7, vk_f8, vk_f9, vk_f10, vk_f11, vk_f12, vk_insert, vk_delete, 
					vk_printscreen, vk_scrollock, vk_tab, vk_home, vk_end, vk_pageup, vk_pagedown, vk_lmeta, vk_rmeta, vk_numlock,
					vk_numpad0, vk_numpad1, vk_numpad2, vk_numpad3, vk_numpad4, vk_numpad5, vk_numpad6, vk_numpad7, 
					vk_numpad8, vk_numpad9, vk_multiply, vk_divide, vk_add, vk_subtract, vk_decimal
				], 
				undefined, filter, player);
				
            input_binding_scan_start(function(_bind)
            {
                var _prevbind = input_binding_get(parent.variable, 0, 0, parent.section);
                input_binding_set(parent.variable, _bind, player, 0, parent.section);
                
                if (!json_are_equal(_bind, _prevbind))
                    input_binding_set(parent.variable, _prevbind, player, 1, parent.section);
                
                getfolder().locked--;
                selected = false;
            }, function(_bind)
            {
                getfolder().locked--;
                selected = false;
            });
        }
    };
    
    static taunt = function()
    {
        if (!selected)
        {
            trace("fffffffff");
            event_play_oneshot("event:/sfx/pausemenu/impact");
            input_binding_set(parent.variable, input_binding_empty(), 0, 0, parent.section);
            input_binding_set(parent.variable, input_binding_empty(), 0, 1, parent.section);
        }
    };
    
    player = _player;
    filter = _filter;
    selected = false;
}

function StackedOption(_name, _variable, _section, _selections = [
	new Selection(string_get("menu/options/generic/off"), false), 
	new Selection(string_get("menu/options/generic/on"), true)
	], _updateglobals = noone, _auto = true) : Option(_name, _variable, _section, _selections, _updateglobals, _auto) constructor
{
    static draw = function(_x, _y, _alpha)
    {
        __draw_text_colour_hook(480, _y, name, c_white, c_white, c_white, c_white, 1 / (2 - _alpha));
        var _len = array_length(selections);
        var _maxwidth = 0;
        
        for (var _i = 0; _i < _len; _i++)
            _maxwidth = max(selections[_i].getwidth(), _maxwidth);
        
        _maxwidth += 18;
        
        for (var _i = 0; _i < _len; _i++)
        {
            var _offset = ((1 - _len) / 2) + _i;
            selections[_i].draw(480 + (_maxwidth * _offset), _y + 50, chosensel == _i);
        }
    };
    
    yspacing = 100;
}

function SideOption(_name, _variable, _section, _selections = [
	new Selection(string_get("menu/options/generic/off"), false), 
	new Selection(string_get("menu/options/generic/on"), true)
	], _updateglobals = noone, _auto = true) : Option(_name, _variable, _section, _selections, _updateglobals, _auto) constructor
{
    static draw = function(_x, _y, _alpha)
    {
        var _sel = selections[chosensel];
        var _margin = 100;
        __draw_text_colour_hook(round(nameoffset + _margin), round(_y), name, c_white, c_white, c_white, c_white, 1 / (2 - _alpha));
        _sel.draw(round(get_game_width() - (_sel.getwidth() / 2) - _margin), round(_y), true);
    };
    
    nameoffset = string_width(name) / 2;
}

function Folder(_name, _options = [], _background = bg_options, _middlealign = false) : MenuItem(_name) constructor
{
    static enterfolder = function(_folder)
    {
        var _memyselfandi = self;
        
        with (_folder)
        {
            event_play_oneshot("event:/sfx/pausemenu/impact");
            ds_stack_push(optionstack, _memyselfandi);
            array_push(bgqueue, _memyselfandi);
        }
        
        dofade = false;
    };
    
    static exitfolder = function(_folder)
    {
        event_play_oneshot("event:/sfx/pausemenu/rubbersqueak");
        ds_stack_pop(_folder.optionstack);
        
        if (ds_stack_empty(_folder.optionstack))
            instance_destroy(_folder);
        else
            dofade = true;
    };
    
    static drawoptions = function()
    {
        var _gy = middlealign ? ((get_game_height() / 2) - (maxheight / 2)) : 100;
        var _totalspacing = _gy;
        
        if (!middlealign)
        {
            for (var _i = 0; _i <= optionselected; _i++)
                _totalspacing += options[_i].yspacing;
            
            scroll = lerp(scroll, min(0, get_game_height() - 50 - _totalspacing), 0.1);
            _gy += scroll;
        }
        
        for (var _i = 0; _i < array_length(options); _i++)
        {
            options[_i].draw(480, _gy, _i == optionselected);
            _gy += options[_i].yspacing;
        }
    };
    
    static update = function()
    {
        array_foreach(options, function(_option, _parent)
        {
            _option.update();
        });
    };
    
    static jump = function(_selected)
    {
        enterfolder(_selected);
    };
    
    static unlock = function(_selected)
    {
        exitfolder(_selected);
    };
    
    optionselected = 0;
    options = _options;
    background = _background;
    middlealign = _middlealign;
    locked = 0;
    scroll = 0;
    dofade = false;
    fade = 0;
    array_foreach(options, function(_option, _parent)
    {
        _option.parent = self;
        _option.parented();
    });
    maxheight = 0;
    
    if (middlealign)
    {
        for (var _i = 0; _i < array_length(options); _i++)
            maxheight += options[_i].yspacing;
    }
}

function KeyFolder(_name, _options = [], _background = bg_options, _middlealign = false) : Folder(_name, _options, _background, _middlealign) constructor
{
    static jump = function(_selected)
    {
        enterfolder(_selected);
        
        if (!input_profile_exists(tempprofile))
            input_profile_create(tempprofile);
        
        input_profile_copy(0, input_profile_get(0), 0, tempprofile);
        input_profile_set(tempprofile);
    };
    
    static unlock = function(_selected)
    {
        exitfolder(_selected);
        
        if (input_profile_exists(tempprofile))
            input_profile_destroy(tempprofile);
        
        config_set_option("Input", "bindings", input_system_export(false));
    };
    
    tempprofile = "pauseprofile";
}
#endregion
#region Reset Binds
var _resetbindskey = new MenuItem(string_get("menu/options/input/resetbinds"));

_resetbindskey.jump = function()
{
    input_profile_reset_bindings("keyboard_and_mouse");
    config_set_option("Input", "bindings", input_system_export(false));
    scr_tiptext(string_get("tips/menu/options/keybindsreset"));
};

var _resetbindspad = new MenuItem(string_get("menu/options/input/resetbinds"));

_resetbindspad.jump = function()
{
    input_profile_reset_bindings("gamepad");
    config_set_option("Input", "bindings", input_system_export(false));
    scr_tiptext(string_get("tips/menu/options/padbindsreset"));
};
#endregion
#region Base Options
var _baseoptions = new Folder("Base", [new Folder(string_get("menu/options/input/mainname"), [
	
	// Input
	// Keyboard Bindings
	new Folder(string_get("menu/options/input/keyname"), [
		new KeyFolder(string_get("menu/options/input/bindname"), [
			// Up
			new SideOption(string_get("menu/options/input/up"), "up", "keyboard_and_mouse", 
				[new Keybinder(0, __input_global().__source_keyboard)]), 
			// Down
			new SideOption(string_get("menu/options/input/down"), "down", "keyboard_and_mouse", 
				[new Keybinder(0, __input_global().__source_keyboard)]), 
			// Left
			new SideOption(string_get("menu/options/input/left"), "left", "keyboard_and_mouse", 
				[new Keybinder(0, __input_global().__source_keyboard)]), 
			// Right
			new SideOption(string_get("menu/options/input/right"), "right", "keyboard_and_mouse", 
				[new Keybinder(0, __input_global().__source_keyboard)]), 
			
			new Spacer(), 
		
			// Jump
			new SideOption(string_get("menu/options/input/jump"), "jump", "keyboard_and_mouse", 
				[new Keybinder(0, __input_global().__source_keyboard)]), 
			// Attack
			new SideOption(string_get("menu/options/input/attack"), "attack", "keyboard_and_mouse", 
				[new Keybinder(0, __input_global().__source_keyboard)]), 
			// Taunt
			new SideOption(string_get("menu/options/input/taunt"), "taunt", "keyboard_and_mouse", 
				[new Keybinder(0, __input_global().__source_keyboard)]), 
			// Dash
			new SideOption(string_get("menu/options/input/dash"), "dash", "keyboard_and_mouse", 
				[new Keybinder(0, __input_global().__source_keyboard)]), 
			
			new Spacer(), 
		
			// Super Jump
			new SideOption(string_get("menu/options/input/superjump"), "superjump", "keyboard_and_mouse", 
				[new Keybinder(0, __input_global().__source_keyboard)]), 
			// Groundpound
			new SideOption(string_get("menu/options/input/groundpound"), "groundpound", "keyboard_and_mouse", 
				[new Keybinder(0, __input_global().__source_keyboard)]), 
			
			new Spacer(), 
		
			// Pause
			new SideOption(string_get("menu/options/input/pause"), "pause", "keyboard_and_mouse", 
				[new Keybinder(0, __input_global().__source_keyboard)])
			], 	
		bg_controls), _resetbindskey], 	
	bg_controls, true), 
	
	// Controller Bindings
	new Folder(string_get("menu/options/input/padname"), [
		new KeyFolder(string_get("menu/options/input/bindname"), [
			// Up
			new SideOption(string_get("menu/options/input/up"), "up", "gamepad", 
				[new Keybinder(0, __input_global().__source_gamepad)]), 
			// Down
			new SideOption(string_get("menu/options/input/down"), "down", "gamepad", 
				[new Keybinder(0, __input_global().__source_gamepad)]), 
			// Left
			new SideOption(string_get("menu/options/input/left"), "left", "gamepad", 
				[new Keybinder(0, __input_global().__source_gamepad)]), 
			// Right
			new SideOption(string_get("menu/options/input/right"), "right", "gamepad", 
				[new Keybinder(0, __input_global().__source_gamepad)]), 
				
			new Spacer(), 
			
			// Jump
			new SideOption(string_get("menu/options/input/jump"), "jump", "gamepad", 
				[new Keybinder(0, __input_global().__source_gamepad)]), 
			// Attack
			new SideOption(string_get("menu/options/input/attack"), "attack", "gamepad", 
				[new Keybinder(0, __input_global().__source_gamepad)]), 
			// Taunt
			new SideOption(string_get("menu/options/input/taunt"), "taunt", "gamepad", 
				[new Keybinder(0, __input_global().__source_gamepad)]), 
			// Dash
			new SideOption(string_get("menu/options/input/dash"), "dash", "gamepad", 
				[new Keybinder(0, __input_global().__source_gamepad)]),
			
			new Spacer(), 
			
			// Super Jump
			new SideOption(string_get("menu/options/input/superjump"), "superjump", "gamepad", 
				[new Keybinder(0, __input_global().__source_gamepad)]), 
			// Groundpound
			new SideOption(string_get("menu/options/input/groundpound"), "groundpound", "gamepad", 
				[new Keybinder(0, __input_global().__source_gamepad)]), 
			
			new Spacer(), 
			
			// Pause
			new SideOption(string_get("menu/options/input/pause"), "pause", "gamepad", 
				[new Keybinder(0, __input_global().__source_gamepad)])
		], bg_controls), 
		
		// Controller Deadzone
		new KeyFolder(string_get("menu/options/input/deadzones/name"), [
			new SideOption(string_get("menu/options/input/deadzones/horizdeadzone"), "horizdeadzone", "Input", 
				[new Slider(0, 1, 0.01, sliderval.percent)], apply_inputglobals), 
			new SideOption(string_get("menu/options/input/deadzones/vertdeadzone"), "vertdeadzone", "Input", 
				[new Slider(0, 1, 0.01, sliderval.percent)], apply_inputglobals)
			], 
		bg_controls, true), _resetbindspad
		
	], bg_controls, true)], bg_controls, true), 
	
	// Video
	new Folder(string_get("menu/options/video/name"), [
		// Fullscreen
		new SideOption(string_get("menu/options/video/fullscreen/name"), "fullscreen", "Video", [
			new Selection(string_get("menu/options/video/fullscreen/windowed"), 0), 
			new Selection(string_get("menu/options/video/fullscreen/exclusive"), 1), 
			new Selection(string_get("menu/options/video/fullscreen/borderless"), 2)
			], 
			apply_videoglobals, false), 
		
		// Aspect Ratio (Mode)
		new SideOption(string_get("menu/options/video/aspectratio"), "resmode", "Video", [
			new Selection("16:9", aspectratio.res16_9), 
			new Selection("16:10", aspectratio.res16_10)
			], 
			apply_videoglobals, false), 
		
		// Aspect Ratio
		new SideOption(string_get("menu/options/video/resolution"), "resnumb", "Video", [
			new VideoSelection(0), 
			new VideoSelection(1), 
			new VideoSelection(2), 
			new VideoSelection(3), 
			new VideoSelection(4)
			], 
			apply_videoglobals, false), 
		
		// Scale Mode
		new SideOption(string_get("menu/options/video/scalemode/name"), "scalemode", "Video", [
			new Selection(string_get("menu/options/video/scalemode/fit"), scaletype.fit), 
			new Selection(string_get("menu/options/video/scalemode/fill"), scaletype.fill), 
			new Selection(string_get("menu/options/video/scalemode/perfect"), scaletype.pixelperfect), 
			new Selection(string_get("menu/options/video/scalemode/exact"), scaletype.exact)
			], 
			apply_videoglobals, false), 
		
		// Border
		new SideOption(string_get("menu/options/video/border/name"), "border", "Video", [
			new Selection(string_get("menu/options/video/border/none"), 0), 
			new Selection(string_get("menu/options/video/border/entry"), 1), 
			new Selection(string_get("menu/options/video/border/medieval"), 2), 
			new Selection(string_get("menu/options/video/border/ruin"), 3), 
			new Selection(string_get("menu/options/video/border/dungeon"), 4), 
			new Selection(string_get("menu/options/video/border/90s"), 5), 
			new Selection(string_get("menu/options/video/border/genesis"), 6), 
			new Selection(string_get("menu/options/video/border/steam"), 7)
			], 
			apply_videoglobals, false), 
		
		new SideOption(string_get("menu/options/video/aa"), "antialiasing", "Video", undefined, apply_videoglobals, false), 
		new SideOption(string_get("menu/options/video/vsync"), "vsync", "Video", undefined, apply_videoglobals, false)
		],
	
	bg_video, true),
	
	// Audio
	new Folder(string_get("menu/options/audio/name"), [
		new SideOption(string_get("menu/options/audio/mastervolume"), "mastervolume", "Audio", 
			[new Slider(0, 1, 0.01, sliderval.percent)]), 
		new SideOption(string_get("menu/options/audio/musicvolume"), "musicvolume", "Audio", 
			[new Slider(0, 1, 0.01, sliderval.percent)]), 
		new SideOption(string_get("menu/options/audio/sfxvolume"), "sfxvolume", "Audio", 
			[new Slider(0, 1, 0.01, sliderval.percent)]), 
		new SideOption(string_get("menu/options/audio/unfocusedmute"), "unfocusedmute", "Audio")
		], 
	bg_audio, true), 
	
	// Accessibility
	new Folder(string_get("menu/options/access/name"), [
		// Escape Screen Tilt
		new SideOption(string_get("menu/options/access/escapetilt"), "escapetilt", "Accessibility", 
			[new Slider(-10, 10, 0.1, sliderval.degree)]), 
			
		new SideOption(string_get("menu/options/access/screenshake"), "screenshake", "Accessibility"), 
		new SideOption(string_get("menu/options/access/rumble"), "rumble", "Accessibility"), 
		new SideOption(string_get("menu/options/access/scorecolours"), "scorecolours", "Accessibility"), 
		
		// Speedrun Timer Type
		new SideOption(string_get("menu/options/access/timertype/name"), "timertype", "Accessibility", [
			new Selection(string_get("menu/options/access/timertype/none"), 0), 
			new Selection(string_get("menu/options/access/timertype/perlevel"), 1), 
			new Selection(string_get("menu/options/access/timertype/persave"), 2), 
			new Selection(string_get("menu/options/access/timertype/both"), 3)
			]), 
			
		new SideOption(string_get("menu/options/access/ghostalpha"), "ghostalpha", "Accessibility", 
			[new Slider(0, 1, 0.01, sliderval.percent)]), 
			
		new SideOption(string_get("menu/options/access/ghostoutlinealpha"), "ghostoutlinealpha", "Accessibility", 
			[new Slider(0, 1, 0.01, sliderval.percent)]), 
			
		new SideOption(string_get("menu/options/access/tvscrollspd"), "tvscrollspd", "Accessibility", 
			[new Slider(1, 3, 0.01, sliderval.int)]), 
			
		new SideOption(string_get("menu/options/access/tvtextalpha"), "tvtextalpha", "Accessibility", 
			[new Slider(0.4, 1, 0.01, sliderval.percentaltALT)]), 
			
		new SideOption(string_get("menu/options/access/hatbounce"), "hatbounce", "Accessibility"), 
		new SideOption(string_get("menu/options/access/screeneffect"), "screeneffect", "Accessibility")
		], 
		
	bg_accessibility)
	], 
	
bg_options, true);
#endregion
#region Title Screen only Options
if (room == TitlescreenRoom)
{
	#region Delete Save
    var _datadel = new Folder(string_get("menu/options/savedelete/name"), [
		// Are you sure you want to delete your save?
		new StackedOption(string_get("menu/options/savedelete/question"), "", "", [
			new Selection(string_get("menu/options/generic/no"), 0), // No
			new Selection(string_get("menu/options/generic/yes"), 0) // Yes
		], noone, false)
	], bg_delete, true);
    
	// Selected No
    with (_datadel.options[0].selections[0])
    {
        jump = function(_selected)
        {
            with (getfolder())
                exitfolder(_selected);
        };
    }
    
	// Selected Yes
    with (_datadel.options[0].selections[1])
    {
        jump = function(_selected)
        {
            save_clear();
            save_delete();
            event_play_oneshot("event:/sfx/pausemenu/explosion");
            scr_tiptext(string_get("tips/menu/options/savedatawiped"));
            
            with (getfolder())
                exitfolder(_selected);
        };
    }
    
    array_push(_baseoptions.options, _datadel);
	#endregion
	#region Close Game
    var _closegame = new Folder(string_get("menu/options/closegame/name"), [
		// Close Game?
		new StackedOption(string_get("menu/options/closegame/question"), "", "", [
			new Selection(string_get("menu/options/generic/no"), 0), // No
			new Selection(string_get("menu/options/generic/yes"), 0) // Yes
		], noone, false)
	], bg_close, true);
    
	// Selected No
    with (_closegame.options[0].selections[0])
    {
        jump = function(_selected)
        {
            with (getfolder())
                exitfolder(_selected);
        };
    }
    
	// Selected Yes
    with (_closegame.options[0].selections[1])
    {
        jump = function(_selected)
        {
            game_end();
        };
    }
    
    array_push(_baseoptions.options, _closegame);
	#endregion
}
#endregion

bgqueue = [];
optionstack = ds_stack_create();
_baseoptions.jump(id);
_baseoptions.fade = 1;
bgx = 0;
bgy = 0;
depth = -11000;
