function scr_hurtplayer(_player = other.id, check_hurttype = true)
{
    with (_player)
    {
        var _hurttype = 0;
        
        if (check_hurttype)
        {
            switch (other.object_index)
            {
                case obj_baddiecollisionbox:
                    _hurttype = obj_baddiecollisionbox.baddieID.hurttype;
                    break;
                
                default:
                    _hurttype = other.hurttype;
                    break;
            }
        }
        
        if ((state == states.knightpep || state == states.knightpepslopes || state == states.knightpepbump) && !cutscene)
            return false;
        
        if (state == states.bombpep && !hurted)
            return false;
        
        if (state == states.cheeseball)
            return false;
        
        if (state == states.weeniemount)
            return false;
        
        if (state == states.retrodeath)
            return false;
        
        if (state == states.tumble)
            return false;
        
        if (state == states.slipbanan)
            return false;
        
        if (instance_exists(obj_parryhitbox))
            return false;
        
        if ((state == states.smallpep || state == states.smallpepdash) && !hurted && !cutscene)
        {
            mariodeathid = event_play_oneshot("event:/sfx/player/retrodeath");
            state = states.retrodeath;
            push_notif(achieve_type.gethurt, [_hurttype]);
            return true;
        }
        
        if (state == states.boxxedpep)
        {
            scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/detransfo", x, y);
            
            repeat (5)
            {
                with (instance_create_depth(x, y, -1, obj_boxxeddebris))
                    image_index = 0;
            }
            
            if (x != other.x)
                obj_player.hsp = sign(x - other.x) * 5;
            else
                obj_player.hsp = 5;
            
            vsp = -3;
            image_index = 0;
            obj_player.image_index = 0;
            obj_player.flash = 1;
            state = states.bump;
            push_notif(achieve_type.gethurt, [_hurttype]);
            return true;
        }
        
        if (state == states.cheesepep || state == states.cheesepepstick)
        {
            scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/detransfo", x, y);
            obj_player.grav = 0.5;
            
            repeat (8)
                instance_create_depth(x, y, -1, obj_slimedebris);
            
            if (x != other.x)
                obj_player.hsp = sign(x - other.x) * 5;
            else
                obj_player.hsp = 5;
            
            vsp = -3;
            image_index = 0;
            obj_player.image_index = 0;
            obj_player.flash = 1;
            state = states.bump;
            push_notif(achieve_type.gethurt, [_hurttype]);
            return true;
        }
        
        if (shield == 0 && state != states.hurt && state != states.fireass && state != states.boxxedpep && state != states.bump && state != states.parrying && state != states.ghost && state != states.firemouth && state != states.slipbanan && state != states.cheeseball && state != states.weeniemount && !hurted && !cutscene)
        {
            var fmodhurtsound = scr_fmod_soundeffectONESHOT("event:/sfx/player/hurt", x, y);
            fmod_studio_event_instance_set_parameter_by_name(fmodhurtsound, "hurttype", _hurttype, true);
            voice_hurt();
            hurted = 1;
            alarm[7] = 50;
            alarm[8] = 600;
            
            if (global.smallpep)
            {
                sprite_index = spr_smallhurt;
                movespeed = -8;
            }
            else if (character != "S")
            {
                if (xscale == other.image_xscale)
                {
                    sprite_index = spr_hurtjumpstart;
                    movespeed = 8;
                }
                else
                {
                    sprite_index = spr_hurt;
                    movespeed = -8;
                }
            }
            else
            {
                sprite_index = spr_hurt;
                movespeed = -8;
            }
            
            with (obj_drawcontroller)
            {
                hurthud = 1;
                alarm[11] = 120;
            }
            
            vsp = -12;
            timeuntilhpback = 300;
            instance_create_depth(x, y, 0, obj_spikehurteffect);
            state = states.hurt;
            image_index = 0;
            flash = 1;
            
            if (global.currentbadge != badge.nohit)
            {
                global.combotime -= 25;
                
                if (global.combotime < 0)
                    global.combotime = 0;
            }
            else
                global.combotime = 0;
            
            global.hurtcounter += 1;
            add_collect(-50);
            
            if (global.collect > 0)
            {
                instance_create_depth(x, y - 20, 0, obj_minus50);
                
                repeat (12)
                    instance_create_depth(x, y, 0, obj_pizzaloss);
            }
            
            push_notif(achieve_type.gethurt, [_hurttype]);
            return true;
        }
        
        if (shield > 0 && state != states.tackle && !hurted)
        {
            state = states.tackle;
            flash = 1;
            hurted = 1;
            alarm[7] = 50;
            instance_create_depth(x, y, 0, obj_spikehurteffect);
            scr_fmod_soundeffectONESHOT("event:/sfx/player/killingblow", x, y);
            sprite_index = spr_player_punchblock;
            image_index = 0;
            movespeed = -10;
            vsp = 0;
            shieldhurt = 1;
            shieldhealth -= 1;
            shieldblocking = false;
            
            if (shieldhealth > 0)
            {
                shieldblocking = true;
                shieldind = 0;
            }
            
            if (shield > 0 && shieldhealth <= 0)
            {
                shield -= 1;
                shieldhealth = 3;
                
                with (instance_create_depth(x + ((shield - 1) * 20 * xscale), y, 0, obj_baddiedead))
                    sprite_index = spr_pizzashield_collectible;
            }
            
            push_notif(achieve_type.gethurt, [_hurttype]);
            return true;
        }
    }
}
