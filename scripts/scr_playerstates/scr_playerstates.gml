function scr_playerstates()
{
    collide_destructibles = function()
    {
    };
    
    step_vertical = function()
    {
        return true;
    };
    
    step_horizontal = function()
    {
        return true;
    };
    
    hit_vertical = function()
    {
    };
    
    hit_horizontal = function()
    {
    };
    
    noisesnapvalue = (character == "N") ? 32 : 22;
    
    if (state == 13 || state == 45 || state == 16 || state == 73 || state == 118 || state == 91 || state == 66 || state == 47)
        maxSnapUp = (vsp >= 0) ? 32 : noisesnapvalue;
    else
        maxSnapUp = 2.75;
    
    if (!is_undefined(statemachine[state].script))
        statemachine[state].script();
    
    if (state == 66 || (state == 47 && character != "S") || (state == 12 && character != "S") || (state == 81 && pogobounce >= 5) || state == 51 || state == 1 || state == 4 || (state == 5 && sprite_index != spr_firemouthintro) || state == 26 || state == 40 || state == 23 || state == 7 || (state == 25 && sprite_index == spr_piledriver) || state == 18 || state == 13 || state == 11 || state == 9 || state == 8 || (state == 75 && vsp <= 0) || state == 77 || state == 80 || state == 45 || state == 71 || state == 88 || state == 38 || state == 96 || state == 97 || state == 95 || (state == 107 && sprite_index == spr_smalldash) || state == 27 || state == 120 || sprite_index == spr_machslideboost3 || sprite_index == spr_machslideboost3end || sprite_index == spr_freefall || sprite_index == spr_facestomp)
        instakillmove = 1;
    else
        instakillmove = 0;
    
    if (state != 16)
        grabslap = 0;
    
    if (state != 75)
        uppercutcancel = 0;
    
    if (grounded && vsp > 0)
        godown = 0;
    
    if (doorblend != 1)
    {
        image_blend = make_color_hsv(0, 0, doorblend * 255);
        doorblend = min(1, doorblend + (0.35 / sprite_get_number(spr_walkfront)));
    }
    
    if (state != 87)
    {
        if (state != 40)
            sjumpvsp = -12;
        
        if (state != 51)
            bodyslamvsp = 14;
        
        if (state != 88)
            slipbounce = 0;
    }
}

function throwmort()
{
    if (input_check_pressed("shoot") && character == "P" && global.currentpowerup == 3 && !instance_exists(obj_mortprojectile))
    {
        state = 74;
        sprite_index = spr_player_mortthrow;
        image_index = 0;
        
        with (instance_create_depth(x, y, depth, obj_mortprojectile))
            image_xscale = other.xscale;
        
        instance_destroy(obj_mortfollow);
        facehurt = 0;
        armhurt = 0;
        introscared = 0;
    }
}

function parry()
{
    if (state != 70 && state == 31)
    {
        scr_fmod_soundeffectONESHOT("event:/sfx/player/parry", x, y);
        movespeed = -8;
        
        if (!grounded)
            vsp = -6;
        
        if (instance_exists(obj_taunteffect))
            instance_destroy(obj_taunteffect);
        
        instance_create_depth(x, y, 1, obj_parryeffect);
        sprite_index = choose(spr_parry1, spr_parry2, spr_parry3);
        state = 70;
        image_index = 0;
        flash = 1;
        camera_shake(10, 20);
        gamepadvibrate(1, 0, 15);
        
        with (other.id)
        {
            switch (object_index)
            {
                case obj_pizzacutter:
                    dir *= -1;
                    break;
            }
        }
    }
}

function blurafterimageeffect(arg0, arg1)
{
    if (blurafterimagebuffer > 0)
        blurafterimagebuffer--;
    
    if (blurafterimagebuffer <= 0)
    {
        blurafterimagebuffer = arg0;
        
        with (instance_create_depth(x, y, depth + 1, obj_blurafterimage))
        {
            sprite_index = other.sprite_index;
            image_xscale = other.xscale;
            alphaacc = arg1;
            
            if (floor(other.image_index) == 0)
                image_index = 0;
            else
                image_index = other.image_index - 1;
        }
    }
}

function player_pummelhit()
{
    state = 35;
    pummelpunch = 1;
    pummeltimer = 10;
    sprite_index = choose(spr_suplexmash1, spr_suplexmash2, spr_suplexmash3, spr_suplexmash4, spr_suplexmash5, spr_suplexmash6, spr_suplexmash7);
    instance_create_depth(x + (32 * xscale), y, depth - 1, obj_parryeffect);
    scr_fmod_soundeffectONESHOT("event:/sfx/enemy/punched", x, y);
    image_index = 0;
    hsp = xscale * 3;
    vsp = 0;
    scr_tiptext(string_get("tips/other/pummel"), "pummeltip");
    
    with (other.baddieID)
    {
        scr_enemygibs();
        state = 104;
        stunned = 100;
        pummelled = other;
        alarm[3] = 3;
        alarm[1] = 5;
        hp -= 0.5;
        image_xscale = -other.xscale;
        hsp = 0;
        vsp = 0;
        stompscale = -0.5;
        restore_combo();
    }
    
    if (other.baddieID.hp <= 0)
    {
        state = 35;
        pummelpunch = 0;
        image_index = 0;
        
        if (!input_check("up") && !input_check("down"))
        {
            if (input_check("dash"))
            {
                state = 66;
                sprite_index = spr_mach3hit;
                image_index = 0;
            }
            else
            {
                sprite_index = spr_player_punchblock;
                movespeed = -8;
            }
            
            scr_fmod_soundeffectONESHOT("event:/sfx/player/killingblow", x, y);
            do_hitstun(global.otherimpactfulhitstun);
            camera_shake(7, 6);
            
            with (other.baddieID)
            {
                alarm[3] = 3;
                alarm[1] = 5;
                grav = 0;
                thrown = 1;
                stunned = 10000;
                state = 104;
                parried = 1;
                sprite_index = spr_dead;
                
                if (hitfactor < 12)
                    hitfactor += 4;
                
                throwhsp = -image_xscale * 25;
                throwvsp = 0;
                y -= 4;
            }
        }
        else if (input_check("up"))
        {
            suplexmove = 1;
            cangrab = 0;
            state = 75;
            sprite_index = spr_shoryukenstart;
            image_index = 0;
            hsp = 0;
            vsp = -14;
            shoryukenvsp = -14;
            canuppercut = 0;
            scr_fmod_soundeffectONESHOT("event:/sfx/player/uppercut", x, y);
            
            with (instance_create_depth(x, y, 0, obj_highjumpcloud2))
                image_xscale = other.xscale;
            
            jumpAnim = 1;
            facehurt = 0;
            armhurt = 0;
            introscared = 0;
            other.baddieID.x = x;
            other.baddieID.y = y;
            camera_shake(10, 6);
        }
        else if (input_check("down"))
        {
            image_index = 0;
            other.baddieID.state = 107;
            other.baddieID.grabbedby = obj_player;
            state = 25;
            sprite_index = spr_piledriver;
            other.baddieID.image_yscale = -1;
            piledrivervsp = -4;
            movespeed = 0;
            hsp = 0;
            fmod_studio_event_instance_start(groundpoundfallsnd);
            other.baddieID.x = x;
            other.baddieID.y = y;
        }
    }
}

function enterdoor()
{
    lastroom_x = other.x;
    lastroom_y = other.y;
    lastroom = room;
    event_play_oneshot("event:/sfx/player/doorenter");
    obj_drawcontroller.chargecamera = 0;
    ds_list_add(global.saveroom, id);
    
    with (obj_player)
    {
        sprite_index = spr_lookdoor;
        image_index = 0;
        state = 54;
    }
    
    obj_player.targetDoor = other.targetDoor;
    obj_player.targetRoom = other.targetRoom;
    obj_player.enteredDoor = other;
    other.visited = 1;
    instance_create_depth(x, y, -9999, obj_fadeout);
}

function do_hitstun(arg0)
{
    if (state != 87)
    {
        hitstunstoredmovespeed = movespeed;
        hitstunstoredsprite = sprite_index;
        hitstunstoredstate = state;
        hitstunstoredvsp = vsp;
        hitstunstoredimagespeed = image_speed;
        hitstunstoredhsp = hsp;
        hittimer = arg0;
        state = 87;
    }
}

function enterboxofpizza(arg0)
{
    other.depth = -10;
    event_play_oneshot("event:/sfx/player/boxenter");
    obj_player.box = 1;
    mach2 = 0;
    obj_drawcontroller.chargecamera = 0;
    x = other.x;
    obj_player.targetDoor = other.targetDoor;
    obj_player.targetRoom = other.targetRoom;
    obj_player.enteredDoor = other.id;
    sprite_index = arg0;
    image_index = 0;
    state = 54;
}

function voice_collect(arg0 = id)
{
    with (arg0)
    {
        var voice = random_range(1, 100);
        
        if (voice >= 45)
        {
            if (character == "P")
                fmod_studio_event_instance_start(PcollectVA);
            else if (character == "N")
                fmod_studio_event_instance_start(NrandomVA);
        }
    }
}

function voice_random(arg0 = id)
{
    with (arg0)
    {
        var voice = random_range(1, 100);
        
        if (voice >= 45)
        {
            if (character == "P")
                fmod_studio_event_instance_start(PrandomVA);
            else if (character == "N")
                fmod_studio_event_instance_start(NrandomVA);
        }
    }
}

function voice_transfo(arg0 = id)
{
    with (arg0)
    {
        var voice = random_range(1, 100);
        
        if (voice >= 45)
        {
            if (character == "P")
                fmod_studio_event_instance_start(PtransfoVA);
            else if (character == "N")
                fmod_studio_event_instance_start(NrandomVA);
        }
    }
}

function voice_hurt(arg0 = id)
{
    with (arg0)
    {
        var voice = random_range(1, 100);
        
        if (voice >= 45)
        {
            if (character == "P")
                fmod_studio_event_instance_start(PhurtVA);
            else if (character == "N")
                fmod_studio_event_instance_start(NhurtVA);
        }
    }
}

function voice_scream(arg0 = 1, arg1 = id)
{
    with (arg1)
    {
        if (character == "P")
            fmod_studio_event_instance_start(PscreamVA);
        else if (character == "N")
            fmod_studio_event_instance_start(NscreamVA);
    }
}
