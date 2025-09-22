function update_camera(arg0 = true)
{
    static p = noone;
    
    if (instance_exists(obj_player) && (!obj_pause.pause || copyapp))
        p = obj_player.id;
    
    if (p != noone && p.state != states.ejected2)
    {
        var camx = 0;
        var camy = 0;
        var target = p;
        var cam_width = camera_get_view_width(view_camera[0]);
        var cam_height = camera_get_view_height(view_camera[0]);
        var pause_width = camera_get_view_width(view_camera[1]);
        var pause_height = camera_get_view_height(view_camera[1]);
        var camy_minus = 30;
        var state = target.state;
        
        if (!arg0)
        {
            var _targetcharge = 0;
            var _tspeed = 0;
            
            if (target.state == states.mach2 || target.state == states.mach3 || target.state == states.hitstun || target.state == states.shoulderbash || target.state == states.tumble || target.state == states.grind || target.state == states.skateboard || (target.state == states.knightpep && target.knightsliding) || target.state == states.knightpepslopes)
            {
                _targetcharge = ((target.xscale * target.movespeed) / 4) * 100;
                _tspeed = 0.2;
                chargecamera = Approach(chargecamera, _targetcharge, _tspeed);
            }
            else if (abs(target.hsp) >= 16 && target.state != states.climbwall && target.state != states.sjump)
            {
                _targetcharge = ((target.xscale * abs(target.hsp)) / 4) * 100;
                _tspeed = 2;
                
                if ((_targetcharge > 0 && chargecamera < 0) || (_targetcharge < 0 && chargecamera > 0))
                    _tspeed = 8;
                
                chargecamera = Approach(chargecamera, _targetcharge, _tspeed);
            }
            else if (state == states.machslide)
                chargecamera = Approach(chargecamera, 0, 10);
            else
                chargecamera = Approach(chargecamera, 0, 6);
            
            camerashakex = irandom_range(-shake_mag, shake_mag);
            camerashakey = irandom_range(-shake_mag, shake_mag);
            
            if (global.panic && !obj_music.secret && global.levelname != "dragonslair")
            {
                camerashakex += random_range(-2, 2);
                camerashakey += random_range(-2, 2);
            }
            
            if (!global.screenshake)
            {
                camerashakex = 0;
                camerashakey = 0;
            }
            
            if (instance_exists(obj_screenlockup))
                screenlock = 1;
            else if (instance_exists(obj_screenlockmiddle))
                screenlock = 3;
            else if (instance_exists(obj_screenlockdown))
                screenlock = 2;
            else
                screenlock = 0;
        }
        
        camx = target.x + chargecamera;
        camy = target.y - camy_minus;
        
        if (target.state == states.hubeject)
            camy = target.backtohubstarty - camy_minus;
        
        if (target.state == states.sagelevelentrance)
            camy = target.roomstarty - camy_minus;
        
        if (wasball)
        {
            cameraxoff = (camera_get_view_x(view_camera[0]) + (cam_width / 2)) - camx;
            camerayoff = (camera_get_view_y(view_camera[0]) + (cam_height / 2)) - camy;
            pausexoff = (camera_get_view_x(view_camera[1]) + (pause_width / 2)) - camx;
            pauseyoff = (camera_get_view_y(view_camera[1]) + (pause_height / 2)) - camy;
            wasball = false;
        }
        
        switch (screenlock)
        {
            case 1:
                camy = get_game_height() / 2;
                break;
            
            case 3:
                camy = room_height / 2;
                break;
            
            case 2:
                camy = room_height - (get_game_height() / 2);
                break;
        }
        
        var myx = clamp((camx - (cam_width / 2)) + cameraxoff, 0, room_width - cam_width);
        var myy = clamp((camy - (cam_height / 2)) + camerayoff, 0, room_height - cam_height);
        var myx2 = clamp((camx - (pause_width / 2)) + pausexoff, 0, room_width - pause_width);
        var myy2 = clamp((camy - (pause_height / 2)) + pauseyoff, 0, room_height - pause_height);
        
        if (room_height < get_game_height())
            myy -= ((room_height - get_game_height()) / 2);
        
        camera_set_view_pos(view_camera[0], roundlower(myx) + camerashakex, roundlower(myy) + camerashakey);
        camera_set_view_pos(view_camera[1], roundlower(myx2) + camerashakex, roundlower(myy2) + camerashakey);
        camera_apply(view_camera[0]);
        camera_apply(view_camera[1]);
        listener_setPosition(0, myx + (cam_width / 2), myy + (cam_height / 2), 0);
    }
    
    if (!arg0)
    {
        cameraxoff = Approach(cameraxoff, 0, 3);
        camerayoff = Approach(camerayoff, 0, 3);
        pausexoff = Approach(pausexoff, 0, 3);
        pauseyoff = Approach(pauseyoff, 0, 3);
    }
    
    if (!obj_pause.pause || copyapp)
        scr_parrallax(!arg0);
}

windowwidth = window_get_width();
windowheight = window_get_height();
appscalex = 1;
appscaley = 1;
guisurf = -1;
finalsurf = -1;
copyapp = false;
surface_depth_disable(true);
application_surface_draw_enable(false);

global.inputs = ds_map_create();
global.inputs[? "[U]"] = "up";
global.inputs[? "[D]"] = "down";
global.inputs[? "[L]"] = "left";
global.inputs[? "[R]"] = "right";
global.inputs[? "[J]"] = "jump";
global.inputs[? "[A]"] = "attack";
global.inputs[? "[T]"] = "taunt";
global.inputs[? "[S]"] = "shoot";
global.inputs[? "[M]"] = "dash";
global.inputs[? "[G]"] = "groundpound";
global.inputs[? "[P]"] = "superjump";
global.inputs[? "[?]"] = "any";

depth = -4;
image_speed = 0.35;
alpha = 1;
shaking = 0;
ghostcollectibles = array_create(0);
secretlayers = ds_map_create();
hold_alarm = array_create(12);
hold_image_speed = image_speed;
pummelalpha = 0;

gameframe_init();
global.gameframe_caption_font = font_caption;
global.gameframe_caption_text = window_get_caption();
global.gameframe_caption_icon = spr_icon;
global.gameframe_border_width = 2;

mouse_xprev = mouse_x;
mouse_yprev = mouse_y;
goawaytimer = 100;
n = 0;
alarm[0] = -1;
global.escapetime = 120;
pointlosstimer = 60;
global.objminutes = 1;
global.miniboss = 0;
angle = 0;
frame = 0;
global.pizza = 0;
global.pizzameter = 0;
global.pillarhunger = 4000;
global.showhud = 1;
basement = 0;
shake_mag = 0;
shake_mag_acc = 0;
zoom = 0;
chargecamera = 0;
camangle = 0;
campresecretangle = 0;
yshiftl = 0;
cam_scale = 1;
global.panicbg = 1;
global.maxwave = 0;
global.wave = 0;
ded = 0;
camera_target = 0;
global.heat = 0;
global.heatmeter = true;
global.heatbar = 0;
global.heat = 0;
global.devmode = false;
hitstuncam = 0;
zooming = 0;
onemorepress = 0;
solidvisible = false;
platformvisible = 0;
slopevisible = 0;
restarted = 0;
p2pdistance = 0;
p2pdistancex = 0;
transition = 0;
splitfactor = 0;
camera_height = 540;
camerashrinking = 0;
escapetimery = 64;
escapetimerind = 0;
prevcollect = -1;
collectcolor = [0];
tiltsurf = array_create(4, -1);
givetime = 0;
isnewhud = 0;
max_zoom = 100;
targetzoom = 1;
zoomspd = 0.01;
idleanim = 0;
hudframe = 0;
cameraxoff = 0;
camerayoff = 0;
camerashakex = 0;
camerashakey = 0;
pausexoff = 0;
pauseyoff = 0;
wasball = false;
global.camerashake = 1;
screenlock = 0;
collectHUDX = 130;
collectHUDY = 90;
numberY = collectHUDY - 57;
minipizzafaceY = 500;
previousrank = 0;
rank_scale = 1;
bosshealthbar_width = 144;
bosshealthbar_height = 16;
scorehudspr = spr_pizzascore;
scorefontpalette = spr_score_palette;
scorehudspr_C = spr_pizzascore_pepperoni;
scorehudspr_B = spr_pizzascore_shroom;
scorehudspr_A = spr_pizzascore_pepper;
scorehudspr_S = spr_pizzascore_olive;
sprite_index = spr_hud_start;
hudstate = "default";
staticspr = spr_hud_static;
statichud = 0;
staticind = 0;
happyhud = 0;
hurthud = 0;
evilhud = 0;
newssurf = -1;
news = -1;
newshud = -1;
newsscrl = 0;
newspopup = 0;
tvplayedstart = false;
tvplayedend = false;
emptytvspr = spr_customhud;
scoreshakedir = 1;
alarm[0] = 2;
barcracked = false;
barspeed = 0;
scorebounce = [];
scorey = [];
chose = 0;
message = "";
showtext = 0;
tvspd = 0.1;
xi = 500;
yi = 600;
imageindexstore = 0;
once = 0;
global.hurtcounter = 0;
global.hurtmilestone = 10;
yshiftr = 0;
global.srank = 0;
global.arank = 0;
global.brank = 0;
global.crank = 0;
global.purplerank = 0;
global.goldrank = 0;
global.silverrank = 0;
__display_set_gui_size_hook(960, 540);
global.debug = 0;
secretspeed = 0;
stylecolor = 0;
prevcollect = -1;
collectcolor = [0];
scorehudvisible = false;
showcombo = 0;
showcomboresult = 0;
comboresult = 0;
comboendsound = 0;
supertauntalpha = 0.5;
minibosshealthshowup = 0;
minibosshealth_y = -200;
tvX = 833;
tvY = 90;
comboshake = 0;
global.font = font_add_sprite_ext(spr_font, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.1234567890:%°-?", true, 0);
global.thinfont = font_add_sprite_ext(spr_thinfont, "!#$%&'()*+,-.0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~/\\", true, 0);
global.smallfont = font_add_sprite_ext(spr_smallfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.1234567890:?,'", true, 0);
global.smallerfont = font_add_sprite_ext(spr_smallerfont, "1234567890", true, 0);
global.smallnumber = font_add_sprite_ext(spr_smallnumber, "1234567890/-", true, 0);
global.collectfont = font_add_sprite_ext(spr_font_collect, "0123456789", true, 0);
global.scorefont = font_add_sprite_ext(spr_scorefont, "1234567890%/-+.:ABCDEFGHIJKLMNOPQRSTUVWXYZ", true, 0);
global.combofont = font_add_sprite_ext(spr_font_combo, "0123456789", true, 0);
global.nohitfont = font_add_sprite_ext(spr_nohitcombo_font, "1234567890kmb.", true, 1);
global.speedruntimerfont = font_add_sprite_ext(spr_smallfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.1234567890:?,'", false, -4);
global.keyfont = font_add_sprite_ext(spr_keyfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZ'1234567890-=[];'\\,./", false, 0);
global.npcdialoguefont = font_add_sprite_ext(spr_npcdialoguefont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,'\"?!:", true, 1);
global.npcnamefont = font_add_sprite_ext(spr_npcnamefont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,'\"?!:", true, 0);
global.manualfont = font_add_sprite_ext(spr_manualfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!?.:()[]_-,'\"/&", true, 0);
global.fontextra = [];
global.fontextra[global.thinfont] = [spr_controllerbuttons, spr_keyboardkey, spr_keyfunctions, global.keyfont, 40, 0, 0, 6];
global.fontextra[font_tvtext] = [spr_controllerbuttons_tv, spr_keyboardkey_tv, spr_keyfunctions_tv, font_tvtext, 18, 3, 0, 3];
thintextshow = 0;
thintext = "";
thintextfade = 0;
thintextalpha = 0;
thintextx = 480;
thintexty = 440;
wavetext = 0;

function tv_thintext()
{
    thintextshow = 1;
    thintextalpha = 0;
    thintextfade = 0;
}

combobarvsp = 0;
combobary = -120;
combostate = states.normal;
comboguypos = (tvX + 123) - 61;
comboguyind = 0;
combobubbleind = 0;
visualcombo = 0;
visualheat = 0;
visualprank = 0;
roomname = "";

tvbgs = 
{
    tutorial: #573B7D,
    entry: #803868,
    medieval: #502050,
    ruin: #C8984F,
    dungeon: #9B4040,
    dragonslair: #9C6DB6
};
tvbgcolor = #502050;

dark = 0;
tutorialdrop = false;
tutorialintroanim = -180;
tutorialintroanimbounce = false;
tutorialintroanimvsp = 20;
