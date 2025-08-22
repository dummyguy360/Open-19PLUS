if (state != 128 && state != 110 && state != 126 && state != 125)
{
    if ((state != 49 && state != 50) || mask_index == spr_masknull)
    {
        mask_index = player_mask;
        
        if (!place_meeting(x, y, obj_solid))
        {
            if (sprite_index != spr_bombpepintro && sprite_index != spr_player_skateboardcrouch && sprite_index != spr_player_crouchslip && sprite_index != spr_player_grabslidestart && sprite_index != spr_player_grabslide && sprite_index != spr_knightpepthunder && state != 1 && state != 4 && state != 43 && state != 11 && sprite_index != spr_player_crouchshoot && state != 42 && state != 23 && sprite_index != spr_crouchslip && state != 44 && sprite_index != spr_player_chainsawcrouch && sprite_index != spr_barrelslipnslide && sprite_index != spr_barrelroll && sprite_index != spr_player_breakdanceslide && sprite_index != spr_player_sjumpcancelground && sprite_index != spr_player_sjumpcancelgroundstart && state != 106 && state != 107 && state != 55 && sprite_index != spr_player_jumpdive1 && sprite_index != spr_player_jumpdive2)
                mask_index = player_mask;
            else
                mask_index = player_crouchmask;
        }
        else
        {
            mask_index = player_crouchmask;
        }
    }
}
else
{
    mask_index = spr_masknull;
}

if (input_check_pressed("jump"))
    input_buffer_jump = 0;

if (input_check_pressed("attack"))
    input_buffer_attack = 0;

if (input_check_pressed("down"))
    input_buffer_down = 0;

scr_characterspr();
scr_playerstates();
scr_playersounds();

if (input_buffer_jump < 8)
    input_buffer_jump++;

if (input_buffer_pummel < 6)
    input_buffer_pummel++;

if (input_buffer_attack < 8)
    input_buffer_attack++;

if (input_buffer_down < 8)
    input_buffer_down++;

supertauntcooldown = clamp(supertauntcooldown, 0, 10);

if (!asset_has_tags(room, "No Save Timer", 3))
    global.savetime++;

if (!asset_has_tags(room, "No Timer", 3) && !scr_hudroomcheck() && global.levelname != -4 && !instance_exists(obj_endlevelfade))
    global.timer++;

if (_player == 1)
{
    if (global.combotime > 0)
    {
        global.combopointmultipler = min(8, global.combo);
        global.combopoints = ceil((global.combo * 5 * global.combopointmultipler) / 10) * 10;
        
        if (global.currentbadge != 3)
        {
            if (state != 89 && state != 98 && state != 76 && state != 54 && state != 39 && sprite_index != spr_player_catched && !instance_exists(obj_fadeout) && !cutscene)
                global.combotime -= 0.15;
        }
        else
        {
            global.combopoints *= 2;
        }
    }
    else if (global.combo > 0)
    {
        event_play_oneshot("event:/sfx/misc/comboend");
        var comboresult_spr = spr_hud_comboresult5;
        
        if (global.combo < 20)
            comboresult_spr = spr_hud_comboresult4;
        
        if (global.combo < 15)
            comboresult_spr = spr_hud_comboresult3;
        
        if (global.combo < 10)
            comboresult_spr = spr_hud_comboresult2;
        
        if (global.combo < 5)
            comboresult_spr = spr_hud_comboresult1;
        
        if (!instance_exists(obj_comboend))
        {
            with (instance_create_depth(x, y, -999, obj_comboend))
                sprite_index = comboresult_spr;
        }
        
        obj_drawcontroller.visualcombo = 0;
        obj_drawcontroller.comboshake = 1;
        supertauntcooldown = 0;
        global.combo = 0;
        global.prankattempt = true;
        
        if (global.currentbadge == 3)
        {
            global.combopoints *= 0.25;
            global.combogalstate = 2;
        }
        
        global.combopoints = max(0, global.combopoints);
        combopointstogive += global.combopoints;
        combopointduration = true;
    }
    
    global.enemypalette = global.stylethreshold >= 2;
}

if (scr_hudroomcheck() || global.levelname == "tutorial")
{
    global.combo = 0;
    global.combotime = 0;
}

global.stylethreshold = min(floor(((global.currentbadge == 3) ? (global.combo + 25) : global.combo) / 25), 3);

if (global.timetrial)
    global.collect = 0;

warriorcooldown = Approach(warriorcooldown, 0, 1);
exitgatescale = Approach(exitgatescale, 1, 0.1);

if (state != 23)
    timeuntilslide = 10;

if (state != 50)
    thrown = 0;

if (state != 38)
    slipnslidewall = 0;

if (state != 31)
    taunttimer = 0;

if (state != 13 && state != 87)
    knightslidekills = 0;

if (canhit < 1)
    canhit += 0.05;

if (supertauntcooldown == 10)
{
    if (!instance_exists(obj_superchargeeffect))
        instance_create_depth(x, y, -20, obj_superchargeeffect);
}

can_jump = grounded && vsp > 0;
additionalhsp = lerp(additionalhsp, 0, 0.2);

if (state != 4)
    fireass_sound = 0;

if (state != 28)
    grabspin = -1;

if (state != 66 && state != 87 && state != 45)
{
    rocket = 0;
    snicksupermode = 0;
}

if (state != 95 && (state != 87 || hitstunstoredstate != 95))
{
    rampdotricks = 0;
    ramptricks = 0;
}

if (state == 87)
{
    hitstunshakeX = random_range(-6, 6);
    hitstunshakeY = random_range(-6, 6);
}
else
{
    hitstunshakeX = 0;
    hitstunshakeY = 0;
}

if (state == 0 || state == 36 || state == 47 || state == 66)
{
    if (input_check("shoot") && global.currentpowerup == 1 && !rocket && shotgunbuffer == 0)
    {
        shotgunbuffer = 3;
        scr_fmod_soundeffectONESHOT("event:/sfx/player/killingblow", x, y);
        momemtum = 1;
        
        if (state == 47 || state == 66)
            state = 103;
        else
            state = 24;
        
        with (instance_create_depth(x, y, 0, obj_pistoleffect))
            image_xscale = other.xscale;
        
        image_index = 0;
        sprite_index = spr_Shotgun;
        
        if (!grounded)
            vsp = -5;
        
        if (character != "N")
        {
            with (instance_create_depth(x, y, 0, obj_shotgunblast))
                image_xscale = other.xscale;
            
            with (instance_create_depth(x + (image_xscale * 20), y + 20, 0, obj_shotgunbullet))
                playerid = other.playerobj;
            
            with (instance_create_depth(x + (image_xscale * 20), y + 20, 0, obj_shotgunbullet))
            {
                spdh = 4;
                playerid = other.playerobj;
            }
            
            with (instance_create_depth(x + (image_xscale * 20), y + 20, 0, obj_shotgunbullet))
            {
                spdh = -4;
                playerid = other.playerobj;
            }
        }
    }
}

if (grounded)
    noisewalljump = 0;

if (global.playerhealth == 1 && !instance_exists(obj_sweat) && state == 0)
{
    with (instance_create_depth(x, y, 0, obj_sweat))
        playerid = other.id;
}

if (!instance_exists(obj_angrycloud) && state == 0)
{
    if (angry == 1)
    {
        with (instance_create_depth(x, y, 0, obj_angrycloud))
            playerid = other.id;
    }
}

if (!instance_exists(obj_angrycloudheat) && state == 0)
{
    if (global.combo >= 50)
    {
        with (instance_create_depth(x, y, 0, obj_angrycloudheat))
            playerid = other.id;
    }
}

if (combopointduration)
{
    if (combopointstogive > 0)
    {
        add_collect(10);
        combopointstogive -= 10;
        
        with (instance_create_depth(x + random_range(-3, 3), y + random_range(-3, 3), 0, obj_collectparticle))
        {
            var collectspr = choose(spr_shroomcollect, spr_cheesecollect, spr_tomatocollect, spr_sausagecollect, spr_pineapplecollect);
            
            if (other.character == "N")
                collectspr = choose(spr_halloweencollectibles1, spr_halloweencollectibles2, spr_halloweencollectibles3, spr_halloweencollectibles4, spr_halloweencollectibles5);
            
            sprite_index = collectspr;
            image_speed = 0.35;
            value = 10;
            shake = 2.5;
        }
    }
    
    if (combopointstogive <= 0)
    {
        combopointstogive = 0;
        global.combopoints = 0;
        global.combopointmultipler = 1;
        textalpha = 0;
        combopointduration = false;
    }
}

givepointamount = max(0, givepointamount);

if (givepoints)
{
    if (givepointamount > 0)
    {
        add_collect(givepointmultiplier);
        givepointamount -= givepointmultiplier;
        
        with (instance_create_depth(x + random_range(-3, 3), y + random_range(-3, 3), -9999999, obj_collectparticle))
        {
            sprite_index = get_collectspr(0, other.character);
            image_speed = 0.35;
            value = 1 * obj_player.givepointmultiplier;
            shake = 2.5;
        }
    }
    
    if (givepointamount <= 0)
    {
        givepointamount = 0;
        givepointmultiplier = 1;
        givepoints = 0;
    }
}

if (instance_exists(obj_drawcontroller) && !instance_exists(obj_endlevelfade))
{
    if (global.levelname != "dragonslair")
        global.prank = !global.prankattempt && global.collect >= global.srank && global.combo >= 1 && there_is_follower_obj(obj_pizzakinshroom) && there_is_follower_obj(obj_pizzakincheese) && there_is_follower_obj(obj_pizzakintomato) && there_is_follower_obj(obj_pizzakinsausage) && there_is_follower_obj(obj_pizzakinpineapple) && global.treasure && global.lapping && (global.secretfound >= 3 || inwar);
    else
        global.prank = !global.prankattempt && global.collect >= global.srank && global.combo >= 1 && global.secretfound >= 3;
}

conveyor = (place_meeting(x, y + 1, obj_railh2) - place_meeting(x, y + 1, obj_railh)) * 0.035 * xscale;

if (state != 118 && state != 35 && state != 75)
    suplexmove = 0;

if (grounded && state != 118)
    lunge = 0;

if (grounded && state != 91)
    kungfumove = 0;

if (state != 2)
    punchedenemy = false;

if (grounded)
    canuppercut = 1;

if (state != 51 && state != 25)
    freefallsmash = 0;

if (state != 88)
    currentslip = 0;

if (state != 47 && state != 45 && state != 87 && state != 31)
{
    longjumping = 0;
    longjumpslideanim = 0;
    longjumpspd = 0;
}

if (state != 97 && ((state != 87 && state != 31) || tauntstoredstate != 97))
    angle = 0;

if (state != 35 && state != 118)
{
    pummelpunch = 0;
    pummeltimer = 0;
}

if (grounded && vsp >= 0)
    pummeldoublejump = false;

if (state != 41 && state != 54)
    enteredDoor = -4;

if (global.playerhealth <= 0 && state != 33)
{
    image_index = 0;
    sprite_index = spr_deathstart;
    state = 33;
}

if (y > (room_height + 400) && room != hub_forcedtutorial && room != timesuproom && room != pizzatale && state != 98 && state != 126 && state != 125 && !instance_exists(obj_fadeparent))
{
    state = 98;
    sprite_index = spr_emptyplayer;
    
    if (!instance_exists(obj_pitfalltransition))
        instance_create_depth(x, y, -8000, obj_pitfalltransition);
}

if (y < -1344 && state != 88 && !instance_exists(obj_fadeparent))
{
    state = 88;
    sprite_index = spr_slipbanan1;
    image_index = 0;
    movespeed = 0;
    hsp = 0;
}

if (grounded)
    coyotetime = 6;
else
    coyotetime = Approach(coyotetime, 0, 1);

if (grinding)
    state = 27;

if (sprite_index == spr_winding && state != 0)
    windingAnim = 0;

if (state != 28)
    swingdingbuffer = 0;

if (inv_frames == 0 && !hurted)
    image_alpha = 1;

if (state == 47 || state == 7 || state == 26 || state == 18 || state == 11 || state == 9 || state == 13 || state == 19 || state == 23 || state == 66 || state == 51 || state == 40)
    attacking = 1;
else
    attacking = 0;

if (state == 29 || state == 30)
    grabbing = 1;
else
    grabbing = 0;

if (key_particles == 1)
    instance_create_depth(random_range(x + 25, x - 25), random_range(y + 35, y - 25), -8, obj_keyeffect);

if (state != 0)
{
    idle = 0;
    dashdust = 0;
    turn = 0;
}

if (anger <= 0)
    angry = 0;

if (anger > 0)
{
    angry = 1;
    anger -= 1;
}

if (state != 36 && state != 16 && state != 47 && state != 66 && state != 12 && state != 67 && state != 51 && state != 18 && state != 24 && state != 13 && state != 87)
    momemtum = 0;

if (state != 47)
    machpunchAnim = 0;

if (state != 31)
    taunting = 0;

if (state != 36 && state != 31)
{
    ladderbuffer = 0;
    stompAnim = 0;
    noisedoublejumped = 0;
}

if (dashpadbuffer > 0)
    dashpadbuffer--;

if (shotgunbuffer > 0)
    shotgunbuffer--;

if (noisecapespinbuffer > 0)
    noisecapespinbuffer--;

if (grounded && vsp > 0)
    candive = 1;

if (flash == 1 && alarm[0] <= 0)
    alarm[0] = 0.15 * room_speed;

if ((state != 87 && state != 36 && state != 44 && state != 11) || vsp < 0)
    fallinganimation = 0;

if (state != 53 && state != 0 && state != 48)
{
    facehurt = 0;
    armhurt = 0;
    introscared = 0;
}

if (state != 0 && state != 48)
    machslideAnim = 0;

if (state != 40 && state != 42)
    a = 0;

if (state != 51 && state != 25 && state != 53)
    superslam = 0;

if (state != 47)
    machpunchAnim = 0;

if (state == 66)
{
    if (!instance_exists(obj_speedlines))
    {
        with (instance_create_depth(x, y, 0, obj_speedlines))
        {
            playerid = other.playerobj;
            other.speedlineseffectid = id;
        }
    }
}

mach3effect = state == 47 || state == 66 || (state == 2 && hsp != 0) || state == 81 || state == 12 || state == 7 || (state == 75 && vsp <= 0) || state == 71 || state == 40 || (state == 107 && sprite_index == spr_smalldash) || (sprite_index == spr_swingding && movespeed > 12) || sprite_index == spr_piledriver || state == 95 || state == 96 || state == 97 || state == 120 || state == 26 || state == 103 || (state == 36 && character == "S" && snickmach2mode);
global.mach3effectspecial = (character != "N") ? 16711820 : 8454143;

if (mach3effect && !instance_exists(obj_mach3effect))
{
    macheffect = 1;
    toomuchalarm1 = 6;
    
    with (instance_create_depth(x, y, 0, obj_mach3effect))
    {
        playerid = other.playerobj;
        image_index = other.image_index;
        image_xscale = other.xscale;
        sprite_index = other.sprite_index;
        
        if (other.state == 75 || other.state == 40 || other.state == 2)
            image_alpha = 1;
    }
}

if (toomuchalarm1 > 0)
{
    toomuchalarm1 -= 1;
    
    if (toomuchalarm1 <= 0 && mach3effect)
    {
        with (instance_create_depth(x, y, 0, obj_mach3effect))
        {
            playerid = other.playerobj;
            image_index = other.image_index;
            image_xscale = other.xscale;
            sprite_index = other.sprite_index;
            
            if (other.state == 75 || other.state == 40 || other.state == 2)
                image_alpha = 1;
        }
        
        toomuchalarm1 = 6;
    }
}

blueeffect = state == 91 || state == 5;

if (!instance_exists(obj_blueeffect) && blueeffect && sprite_index != spr_kungfubump)
{
    macheffect = 1;
    toomuchalarm3 = 6;
    
    with (instance_create_depth(x, y, 0, obj_blueeffect))
    {
        playerid = other.playerobj;
        image_index = other.image_index;
        image_xscale = other.xscale;
        sprite_index = other.sprite_index;
        
        if (other.state == 5)
            flashcolor = 1601784;
        else if (other.character == "N")
            flashcolor = 8454143;
        else
            flashcolor = 14646571;
    }
}

if (toomuchalarm3 > 0)
{
    toomuchalarm3 -= 1;
    
    if (toomuchalarm3 <= 0 && blueeffect && sprite_index != spr_kungfubump)
    {
        with (instance_create_depth(x, y, 0, obj_blueeffect))
        {
            playerid = other.playerobj;
            image_index = other.image_index - 1;
            image_xscale = other.xscale;
            sprite_index = other.sprite_index;
            
            if (other.state == 5)
                continue;
            
            if (other.character == "N")
                continue;
        }
        
        toomuchalarm3 = 6;
    }
}

if (state == 17 || sprite_index == spr_knightpepstart || sprite_index == spr_knightpepthunder || state == 34 || state == 54 || state == 3 || state == 41 || state == 39 || state == 33 || state == 126 || state == 125 || state == 89 || state == 116)
    cutscene = 1;
else
    cutscene = 0;

if (state != 22)
{
    chainsaw = 50;
    canchain = 1;
}

if (state != 40 && (state != 87 || hitstunstoredstate != 40))
    cancel_Sjump = true;

if (state != 79)
{
    golflocked = false;
    golfaimx = 0;
    golfaimy = 0;
    golfcharge = 0;
    golfcharging = false;
    golfmaxcharge = 0;
    golfchargingwait = false;
}

if (state == 87)
    mask_index = spr_masknull;

if (state != 87 && state != 12)
{
    if (movespeed > 16)
    {
        mach4time++;
        inmach4 = true;
    }
    else
    {
        mach4time = 0;
        inmach4 = false;
    }
}

if (inmach4)
    push_notif(4, [mach4time]);

if (grounded && vsp >= 0 && bumped)
    bumped = 0;

if (state != 100 && state != 76 && state != 75)
    grav = 0.5;
else
    grav = 0;

if (state == 0 || state == 36 || state == 50)
    inmach = 0;

if (global.stylethreshold >= 2)
{
    if (!instance_exists(obj_heataura))
    {
        with (instance_create_depth(x, y, 1, obj_heataura))
        {
            playerid = other.playerobj;
            image_index = other.image_index - 1;
            image_xscale = other.xscale;
            sprite_index = other.sprite_index;
        }
    }
}

if (pogobounce >= 5)
{
    if (pogoflash > 0)
        pogoflash -= 0.5;
    
    if (pogoflash <= 0)
        pogoflash = 10;
    
    if (pogoflash <= 5)
        flash = 1;
}

if (grounded && vsp >= 0)
    mortjump = 0;

depth = -7;

if (state != 126 && state != 125 && state != 6 && state != 54 && state != 40 && state != 3 && state != 39 && state != 34 && state != 41 && state != 14 && state != 17 && state != 33 && sprite_index != spr_player_spawn && state != 76 && state != 128 && state != 108 && state != 117 && state != 110)
    scr_collide_player();

if (state != 71 && state != 87 && state != 67 && state != 51)
    assflingspeed = 0;
