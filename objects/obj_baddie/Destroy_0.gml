if (ds_list_find_index(global.baddieroom, id) == -1)
{
    if (!important)
    {
        end_combopoint_abrupt();
        add_collect(75);
        obj_drawcontroller.comboshake = 1;
        
        if (playkillsound)
            scr_fmod_soundeffectONESHOT("event:/sfx/enemy/die", x, y);
        
        ds_list_add(global.baddieroom, id);
        
        if (escape)
            ds_list_add(global.escaperoom, id);
        
        add_combo();
    }
    
    scr_enemygibs();
    instance_create_depth(x, y, -100, obj_genericpoofeffect);
    camera_shake(3, 3);
    scr_enemycorpse(undefined, undefined, ((object_index == obj_cheeseslime && snotty) || (object_index == obj_forknight && yellow)) ? 2 : global.enemypalette);
    push_notif(achieve_type.killenemy, [object_index]);
    
    if (killedbyknightslide)
    {
        obj_player.knightslidekills++;
        push_notif(achieve_type.medieval3, [obj_player.knightslidekills]);
    }
    
    if (killedbyfireassstoredsprite != noone)
        push_notif(achieve_type.dungeon2, [killedbyfireassstoredsprite]);
    
    if (killedwithbypiledrive != noone)
        push_notif(achieve_type.dungeon3, [object_index, killedwithbypiledrive]);
    
    var _num = instance_place_list(x, y, obj_baddie, global.baddiecollidelist, false);
    
    for (var i = 0; i < _num; i++)
    {
        with (global.baddiecollidelist[| i])
        {
            if (state != states.smallpepdash)
            {
                playkillsound = false;
                killedbyknightslide = other.killedbyknightslide;
                killedbyfireassstoredsprite = other.killedbyfireassstoredsprite;
                killedwithbypiledrive = other.killedwithbypiledrive;
                instance_destroy();
            }
        }
    }
    
    ds_list_clear(global.baddiecollidelist);
}
