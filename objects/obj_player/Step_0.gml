if (state != states.noclip && state != states.nothing && state != states.sagelevelentrance && state != states.hubeject)
{
    if ((state != states.bump && state != states.hurt) || mask_index == spr_masknull)
    {
        mask_index = player_mask;
        
        if (!place_meeting(x, y, obj_solid))
        {
            if (sprite_index != spr_bombpepintro && sprite_index != spr_player_skateboardcrouch && sprite_index != spr_player_crouchslip && sprite_index != spr_player_grabslidestart && sprite_index != spr_player_grabslide && sprite_index != spr_knightpepthunder && state != states.tumble && state != states.fireass && state != states.crouch && state != states.boxxedpep && sprite_index != spr_player_crouchshoot && state != states.sjumpprep && state != states.machroll && sprite_index != spr_crouchslip && state != states.crouchjump && sprite_index != spr_player_chainsawcrouch && sprite_index != spr_barrelslipnslide && sprite_index != spr_barrelroll && sprite_index != spr_player_breakdanceslide && sprite_index != spr_player_sjumpcancelground && sprite_index != spr_player_sjumpcancelgroundstart && state != states.smallpep && state != states.smallpepdash && state != states.barrelbounce && sprite_index != spr_player_jumpdive1 && sprite_index != spr_player_jumpdive2)
                mask_index = player_mask;
            else
                mask_index = player_crouchmask;
        }
        else
            mask_index = player_crouchmask;
    }
}
else
    mask_index = spr_masknull;

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

if (!asset_has_tags(room, "No Timer", 3) && !scr_hudroomcheck() && global.levelname != noone && !instance_exists(obj_endlevelfade))
    global.timer++;

if (_player == 1)
{
    if (global.combotime > 0)
    {
        global.combopointmultipler = min(8, global.combo);
        global.combopoints = ceil((global.combo * 5 * global.combopointmultipler) / 10) * 10;
        
        if (global.currentbadge != badge.nohit)
        {
            if (state != states.taxi && state != states.pitfall && state != states.pipe && state != states.door && state != states.comingoutdoor && sprite_index != spr_player_catched && !instance_exists(obj_fadeout) && !cutscene)
                global.combotime -= 0.15;
        }
        else
            global.combopoints *= 2;
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
        
        if (global.currentbadge == badge.nohit)
        {
            global.combopoints *= 0.25;
            global.combogalstate = states.finishingblow;
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

global.stylethreshold = min(floor(((global.currentbadge == badge.nohit) ? (global.combo + 25) : global.combo) / 25), 3);

if (global.timetrial)
    global.collect = 0;

warriorcooldown = Approach(warriorcooldown, 0, 1);
exitgatescale = Approach(exitgatescale, 1, 0.1);

if (state != states.machroll)
    timeuntilslide = 10;

if (state != states.hurt)
    thrown = 0;

if (state != states.slipnslide)
    slipnslidewall = 0;

if (state != states.backbreaker)
    taunttimer = 0;

if (state != states.knightpepslopes && state != states.hitstun)
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

if (state != states.fireass)
    fireass_sound = 0;

if (state != states.grab)
    grabspin = -1;

if (state != states.mach3 && state != states.hitstun && state != states.crouchslide)
{
    rocket = 0;
    snicksupermode = 0;
}

if (state != states.ramp && (state != states.hitstun || hitstunstoredstate != states.ramp))
{
    rampdotricks = 0;
    ramptricks = 0;
}

if (state == states.hitstun)
{
    hitstunshakeX = random_range(-6, 6);
    hitstunshakeY = random_range(-6, 6);
}
else
{
    hitstunshakeX = 0;
    hitstunshakeY = 0;
}

if (state == states.normal || state == states.jump || state == states.mach2 || state == states.mach3)
{
    if (input_check("shoot") && global.currentpowerup == powerup.shotgun && !rocket && shotgunbuffer == 0)
    {
        shotgunbuffer = 3;
        scr_fmod_soundeffectONESHOT("event:/sfx/player/killingblow", x, y);
        momemtum = 1;
        
        if (state == states.mach2 || state == states.mach3)
            state = states.swingdingfinish;
        else
            state = states.shotgun;
        
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

if (global.playerhealth == 1 && !instance_exists(obj_sweat) && state == states.normal)
{
    with (instance_create_depth(x, y, 0, obj_sweat))
        playerid = other.id;
}

if (!instance_exists(obj_angrycloud) && state == states.normal)
{
    if (angry == 1)
    {
        with (instance_create_depth(x, y, 0, obj_angrycloud))
            playerid = other.id;
    }
}

if (!instance_exists(obj_angrycloudheat) && state == states.normal)
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
            sprite_index = get_collectspr(collect_type.big, other.character);
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

if (state != states.lunge && state != states.tackle && state != states.shoryuken)
    suplexmove = 0;

if (grounded && state != states.lunge)
    lunge = 0;

if (grounded && state != states.kungfu)
    kungfumove = 0;

if (state != states.finishingblow)
    punchedenemy = false;

if (grounded)
    canuppercut = 1;

if (state != states.freefall && state != states.superslam)
    freefallsmash = 0;

if (state != states.slipbanan)
    currentslip = 0;

if (state != states.mach2 && state != states.crouchslide && state != states.hitstun && state != states.backbreaker)
{
    longjumping = 0;
    longjumpslideanim = 0;
    longjumpspd = 0;
}

if (state != states.firemove && ((state != states.hitstun && state != states.backbreaker) || tauntstoredstate != states.firemove))
    angle = 0;

if (state != states.tackle && state != states.lunge)
{
    pummelpunch = 0;
    pummeltimer = 0;
}

if (grounded && vsp >= 0)
    pummeldoublejump = false;

if (state != states.victory && state != states.door)
    enteredDoor = noone;

if (global.playerhealth <= 0 && state != states.ejected2)
{
    image_index = 0;
    sprite_index = spr_deathstart;
    state = states.ejected2;
}

if (y > (room_height + 400) && room != hub_forcedtutorial && room != timesuproom && room != pizzatale && state != states.pitfall && state != states.sagelevelentrance && state != states.hubeject && !instance_exists(obj_fadeparent))
{
    state = states.pitfall;
    sprite_index = spr_emptyplayer;
    
    if (!instance_exists(obj_pitfalltransition))
        instance_create_depth(x, y, -8000, obj_pitfalltransition);
}

if (y < -1344 && state != states.slipbanan && !instance_exists(obj_fadeparent))
{
    state = states.slipbanan;
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
    state = states.grind;

if (sprite_index == spr_winding && state != states.normal)
    windingAnim = 0;

if (state != states.grab)
    swingdingbuffer = 0;

if (inv_frames == 0 && !hurted)
    image_alpha = 1;

if (state == states.mach2 || state == states.tacklecharge || state == states.skateboard || state == states.knightpep || state == states.boxxedpep || state == states.cheesepep || state == states.knightpepslopes || state == states.bombpep || state == states.machroll || state == states.mach3 || state == states.freefall || state == states.sjump)
    attacking = 1;
else
    attacking = 0;

if (state == states.punch || state == states.shoulder)
    grabbing = 1;
else
    grabbing = 0;

if (key_particles == 1)
    instance_create_depth(random_range(x + 25, x - 25), random_range(y + 35, y - 25), -8, obj_keyeffect);

if (state != states.normal)
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

if (state != states.jump && state != states.suplexgrab && state != states.mach2 && state != states.mach3 && state != states.climbwall && state != states.freefallprep && state != states.freefall && state != states.knightpep && state != states.shotgun && state != states.knightpepslopes && state != states.hitstun)
    momemtum = 0;

if (state != states.mach2)
    machpunchAnim = 0;

if (state != states.backbreaker)
    taunting = 0;

if (state != states.jump && state != states.backbreaker)
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

if ((state != states.hitstun && state != states.jump && state != states.crouchjump && state != states.boxxedpep) || vsp < 0)
    fallinganimation = 0;

if (state != states.freefallland && state != states.normal && state != states.machslide)
{
    facehurt = 0;
    armhurt = 0;
    introscared = 0;
}

if (state != states.normal && state != states.machslide)
    machslideAnim = 0;

if (state != states.sjump && state != states.sjumpprep)
    a = 0;

if (state != states.freefall && state != states.superslam && state != states.freefallland)
    superslam = 0;

if (state != states.mach2)
    machpunchAnim = 0;

if (state == states.mach3)
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

mach3effect = state == states.mach2 || state == states.mach3 || (state == states.finishingblow && hsp != 0) || state == states.pogo || state == states.climbwall || state == states.tacklecharge || (state == states.shoryuken && vsp <= 0) || state == states.breakdance || state == states.sjump || (state == states.smallpepdash && sprite_index == spr_smalldash) || (sprite_index == spr_swingding && movespeed > 12) || sprite_index == spr_piledriver || state == states.ramp || state == states.weeniemount || state == states.firemove || state == states.nwalljump || state == states.skateboard || state == states.swingdingfinish || (state == states.jump && character == "S" && snickmach2mode);
global.mach3effectspecial = (character != "N") ? #8C00FF : #FFFF80;

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
        
        if (other.state == states.shoryuken || other.state == states.sjump || other.state == states.finishingblow)
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
            
            if (other.state == states.shoryuken || other.state == states.sjump || other.state == states.finishingblow)
                image_alpha = 1;
        }
        
        toomuchalarm1 = 6;
    }
}

blueeffect = state == states.kungfu || state == states.firemouth;

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
        
        if (other.state == states.firemouth)
            flashcolor = #F87018;
        else if (other.character == "N")
            flashcolor = #FFFF80;
        else
            flashcolor = #2B7DDF;
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
            
            if (other.state == states.firemouth)
                continue;
            
            if (other.character == "N")
                continue;
        }
        
        toomuchalarm3 = 6;
    }
}

if (state == states.gottreasure || sprite_index == spr_knightpepstart || sprite_index == spr_knightpepthunder || state == states.keyget || state == states.door || state == states.ejected || state == states.victory || state == states.comingoutdoor || state == states.ejected2 || state == states.sagelevelentrance || state == states.hubeject || state == states.taxi || state == states.secretportal)
    cutscene = 1;
else
    cutscene = 0;

if (state != states.chainsaw)
{
    chainsaw = 50;
    canchain = 1;
}

if (state != states.sjump && (state != states.hitstun || hitstunstoredstate != states.sjump))
    cancel_Sjump = true;

if (state != states.golf)
{
    golflocked = false;
    golfaimx = 0;
    golfaimy = 0;
    golfcharge = 0;
    golfcharging = false;
    golfmaxcharge = 0;
    golfchargingwait = false;
}

if (state == states.hitstun)
    mask_index = spr_masknull;

if (state != states.hitstun && state != states.climbwall)
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
    push_notif(achieve_type.entry1, [mach4time]);

if (grounded && vsp >= 0 && bumped)
    bumped = 0;

if (state != states.homingattack && state != states.pipe && state != states.shoryuken)
    grav = 0.5;
else
    grav = 0;

if (state == states.normal || state == states.jump || state == states.hurt)
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

if (state != states.sagelevelentrance && state != states.hubeject && state != states.titlescreen && state != states.door && state != states.sjump && state != states.ejected && state != states.comingoutdoor && state != states.keyget && state != states.victory && state != states.portal && state != states.gottreasure && state != states.ejected2 && sprite_index != spr_player_spawn && state != states.pipe && state != states.noclip && state != states.retrodeath && state != states.held && state != states.nothing)
    scr_collide_player();

if (state != states.breakdance && state != states.hitstun && state != states.freefallprep && state != states.freefall)
    assflingspeed = 0;
