with (obj_player)
{
    if (other.image_index == 1 && !other.cutscene && state != states.backbreaker && !global.panic)
    {
        ds_list_add(global.saveroom, other.id);
        other.image_index = 0;
        y = camera_get_view_y(view_camera[1]) - 100;
        image_blend = c_white;
        doorblend = 1;
        sprite_index = spr_slipbananimpact;
        state = states.sagelevelentrance;
        other.cutscene = 1;
    }
    
    if (input_check("up") && grounded && x > (other.x - 160) && x < (other.x + 160) && (state == states.normal || state == states.mach2 || (state == states.mach3 && !rocket) || state == states.sjumpprep) && global.panic)
    {
        targetDoor = "none";
        obj_drawcontroller.alarm[1] = -1;
        obj_drawcontroller.alarm[6] = -1;
        obj_drawcontroller.givetime = 0;
        push_notif(achieve_type.shared_achievement, [global.escapetime]);
        stop_music();
        
        if (global.levelname == "tutorial")
        {
            instance_create_depth(x, y, 0, obj_endtutorialfade);
            save_open();
            ini_write_real("GameProgress", "tutorialdone", true);
            
            if (!ini_read_real("GameProgress", "lap2unlocked", false) && global.timer <= 4800)
            {
                ini_write_real("GameProgress", "lap2unlocked", true);
                scr_tiptext(string_get("tips/other/unlockedlap2"));
            }
            
            save_close();
        }
        else
        {
            var _prevattempt = global.prankattempt;
            var _prevcombo = global.combo;
            end_combo_abrupt();
            
            if (global.levelname != "dragonslair")
                global.prank = !_prevattempt && global.collect >= global.srank && _prevcombo && there_is_follower_obj(obj_pizzakinshroom) && there_is_follower_obj(obj_pizzakincheese) && there_is_follower_obj(obj_pizzakintomato) && there_is_follower_obj(obj_pizzakinsausage) && there_is_follower_obj(obj_pizzakinpineapple) && global.treasure && global.lapping && (global.secretfound >= 3 || inwar);
            else
                global.prank = !_prevattempt && global.collect >= global.srank && _prevcombo && global.secretfound >= 3;
            
            fmod_studio_event_instance_start(global.ranksnd);
            
            if (!global.timetrial)
            {
                if (global.collect >= global.srank && global.prank)
                    global.rank = rank.P;
                else if (global.collect >= global.srank)
                    global.rank = rank.S;
                else if (global.collect > global.arank)
                    global.rank = rank.A;
                else if (global.collect > global.brank)
                    global.rank = rank.B;
                else if (global.collect > global.crank)
                    global.rank = rank.C;
                else
                    global.rank = rank.D;
                
                fmod_studio_event_instance_set_parameter_by_name(global.ranksnd, "rank", global.rank, true);
            }
            else
            {
                if (global.timetrialtick <= global.purplerank)
                    global.timetrialrank = tt_rank.purple;
                else if (global.timetrialtick <= global.goldrank)
                    global.timetrialrank = tt_rank.gold;
                else if (global.timetrialtick <= global.silverrank)
                    global.timetrialrank = tt_rank.silver;
                else
                    global.timetrialrank = tt_rank.bronze;
                
                fmod_studio_event_instance_set_parameter_by_name(global.ranksnd, "rank", global.timetrialrank + 2, true);
            }
            
            scr_saveleveldata(global.levelname);
            instance_create_depth(x, y, 0, obj_endlevelfade);
        }
        
        image_index = 0;
        global.panic = 0;
        global.stoptimer = 0;
        
        with (obj_player)
        {
            if (state != states.door)
            {
                state = states.door;
                sprite_index = spr_lookdoor;
            }
            
            if (shield > 0)
                scr_fmod_soundeffectONESHOT("event:/sfx/player/killingblow", x, y);
            
            while (shield > 0)
            {
                shield--;
                
                with (instance_create_depth(x + ((shield - 1) * 20 * xscale), y, 0, obj_baddiedead))
                    sprite_index = spr_pizzashield_collectible;
            }
        }
    }
}
