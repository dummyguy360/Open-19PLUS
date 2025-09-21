var __player = other.playerid;

if (instance_exists(baddieID))
{
    with (__player)
    {
        if (instance_exists(other.baddieID))
        {
            if (state != states.lunge)
            {
                if (state == states.shoulderbash || (state == states.suplexgrab && other.baddieID.hitfactor > 0 && character != "N"))
                {
                    other.baddieID.sprite_index = other.baddieID.stunfallspr;
                    var hitstun = 1;
                    other.baddieID.flash = 1;
                    other.baddieID.hp = 0;
                    
                    with (other.baddieID)
                        scr_enemygibs();
                    
                    scr_fmod_soundeffectONESHOT("event:/sfx/enemy/punched", x, y);
                    instance_create_depth(other.baddieID.x, other.baddieID.y, -1, obj_parryeffect);
                    camera_shake(3, 3);
                    restore_combo();
                    machpunchAnim = 1;
                    other.baddieID.thrown = 1;
                    other.baddieID.state = states.seat;
                    other.baddieID.stunned = 100;
                    other.baddieID.image_xscale = -xscale;
                    other.baddieID.sprite_index = other.baddieID.spr_dead;
                    other.baddieID.image_yscale = 1;
                    scr_fmod_soundeffectONESHOT("event:/sfx/player/killingblow", x, y);
                    
                    if (input_check("up"))
                    {
                        other.baddieID.vsp = -16 + other.baddieID.hitfactor;
                        other.baddieID.hsp = 0;
                    }
                    else if (input_check("down"))
                    {
                        other.baddieID.vsp = 16 - other.baddieID.hitfactor;
                        other.baddieID.hsp = 0;
                    }
                    else
                    {
                        other.baddieID.vsp = -8;
                        other.baddieID.hsp = -other.baddieID.image_xscale * 16;
                    }
                    
                    if (other.baddieID.hitfactor < 12)
                        other.baddieID.hitfactor += 4;
                    
                    if (sprite_index != spr_player_shoulderbash)
                    {
                        state = states.jump;
                        image_index = 0;
                        sprite_index = choose(spr_player_hitstun1, spr_player_hitstun2, spr_player_hitstun3);
                        vsp = -12;
                        momemtum = 1;
                        jumpstop = 0;
                    }
                    else
                        state = states.normal;
                    
                    hitstun -= 1;
                    do_hitstun(global.otherimpactfulhitstun);
                    gamepadvibrate(0.8, 0, 7);
                    other.baddieID.ishurt = -1;
                    alarm[0] = 25;
                }
                
                if (instance_exists(other.baddieID) && character != "S" && ((state == states.suplexgrab && other.baddieID.hitfactor == 0 && character != "N") || (state == states.suplexgrab && character == "N")))
                {
                    image_index = 0;
                    other.baddieID.state = states.smallpepdash;
                    other.baddieID.grabbedby = playerobj;
                    
                    if (input_check("up"))
                    {
                        state = states.superslam;
                        sprite_index = spr_piledriver;
                        other.baddieID.image_yscale = -1;
                        piledrivervsp = -14;
                        movespeed = 0;
                        hsp = 0;
                        fmod_studio_event_instance_start(groundpoundfallsnd);
                    }
                    else if (!input_check("up"))
                    {
                        other.baddieID.image_yscale = 1;
                        
                        if (movespeed <= 10)
                        {
                            sprite_index = spr_haulingstart;
                            scr_fmod_soundeffectONESHOT("event:/sfx/player/grabthing", x, y);
                        }
                        else if (movespeed > 10)
                        {
                            if (movespeed < 12)
                                movespeed = 12;
                            
                            sprite_index = spr_swingding;
                        }
                        
                        state = states.grab;
                        
                        if (!grounded)
                            vsp = -6;
                    }
                }
            }
            else
                player_pummelhit();
        }
    }
}
