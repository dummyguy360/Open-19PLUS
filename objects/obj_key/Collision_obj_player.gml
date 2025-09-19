with (other.id)
{
    if (other.inv_frame == 0 && !scr_transformationcheck(id) && state != states.hurt && state != states.weeniemount)
    {
        instance_destroy(other.id);
        global.key_inv = 1;
        key_particles = 1;
        alarm[7] = 30;
        global.hasgotkeybefore = 1;
        event_play_oneshot("event:/sfx/player/collect/toppin");
        
        with (obj_drawcontroller)
        {
            happyhud = 1;
            alarm[10] = 120;
        }
    }
}

with (obj_peppermandestroyable)
    instance_destroy();

if (global.keyget == 0 && !scr_transformationcheck(other.id) && other.state != states.hurt && other.state != states.weeniemount)
{
    other.id.state = states.keyget;
    other.id.image_index = 0;
    
    if (global.levelname == "medieval")
    {
        if (obj_player.character == "N")
            trigger_news(string_get("tvmessages/medievalN/hungry"), ["", "forknight", "default"]);
        else
            trigger_news(string_get("tvmessages/medieval/hungry"), ["", "forknight", "default"]);
    }
    
    global.keyget = 1;
}
