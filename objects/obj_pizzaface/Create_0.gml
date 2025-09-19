image_speed = 0.35;
depth = -5;
image_alpha = 0;
errors = "ERROR!: Can't find sprite ref 483";
trailerror = false;
minspeed = 2;
maxspeed = 18;
defaultspeed = 6;
movespeed = defaultspeed;
dir = 0;
toomuchalarm = 0;
stunshakeX = 0;
stunshakeY = 0;
movingsnd = event_instance("event:/sfx/boss/pizzaface/moving");
fmod_studio_event_instance_start(movingsnd);
alarm[1] = 480;
save_open();

if (!ini_read_real("GameProgress", "sawpizzaface", false))
{
    ini_write_real("NPCProgression", "snicklevel", ini_read_real("NPCProgression", "snicklevel", -1) + 0.5);
    ini_write_real("GameProgress", "sawpizzaface", true);
}

save_close();

function pizzaface_freeze()
{
    if (obj_player.state == states.hitstun || obj_player.state == states.pipe || (obj_player.state == states.knightpep && (sprite_index == spr_knightpepstart || sprite_index == spr_knightpepthunder)) || obj_player.cutscene || instance_exists(obj_pitfalltransition) || instance_exists(obj_fadeparent))
        return true;
    
    return false;
}

function pizzaface_fadeout()
{
    if (obj_player.state == states.door || obj_player.state == states.comingoutdoor || obj_player.state == states.keyget || obj_player.state == states.secretportal || obj_player.state == states.portal || obj_player.state == states.gottreasure)
        return true;
    
    return false;
}
