function scr_textureload(arg0)
{
    static prevtex = -1;
    static prevtex = arg0;
    
    if (arg0 == undefined)
        arg0 = global.levelname;
    
    if (arg0 == -4 && string_starts_with(room_get_name(room), "hub"))
    {
        arg0 = "hub";
    }
    else if (arg0 == "dragonslair")
    {
        switch (room)
        {
            case dragonslair_5:
            case dragonslair_7:
                arg0 = "medieval";
                break;
            
            case dragonslair_8:
            case dragonslair_10:
                arg0 = "ruin";
                break;
            
            case dragonslair_11:
                arg0 = "dungeon";
                break;
        }
    }
    
    var groups = ["chateau", "beach", "city", "dungeon", "desert", "entrance", "etb", "factory", "golf", "graveyard", "hub", "mansion", "medieval", "sewer", "smb", "space", "strongcold", "ruin", "war", "kungfu"];
    
    if (prevtex == arg0 || array_get_index(groups, arg0) == -1)
        exit;
    
    for (var i = 0; i < array_length(groups); i++)
    {
        if (arg0 != groups[i])
        {
            t = texturegroup_get_textures(groups[i]);
            
            for (var l = 0; l < array_length(t); l++)
                texture_flush(t[l]);
        }
    }
    
    var t = texturegroup_get_textures(t);
    
    for (var l = 0; l < array_length(t); l++)
        texture_prefetch(t[l]);
}
