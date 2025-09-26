function scr_textureload(level = global.levelname)
{
    static prevtex = -1;
    static prevtex = level;
    
    if (level == noone && string_starts_with(room_get_name(room), "hub"))
        level = "hub";
    else if (level == "dragonslair")
    {
        switch (room)
        {
            case dragonslair_5:
            case dragonslair_7:
                level = "medieval";
                break;
            
            case dragonslair_8:
            case dragonslair_10:
                level = "ruin";
                break;
            
            case dragonslair_11:
                level = "dungeon";
                break;
        }
    }
    
    var groups = 
	[
		"chateau", 
		"beach", 
		"city", 
		"dungeon", 
		"desert", 
		"entrance", 
		"etb", 
		"factory", 
		"golf", 
		"graveyard", 
		"hub", 
		"mansion", 
		"medieval", 
		"sewer", 
		"smb", 
		"space", 
		"strongcold", 
		"ruin", 
		"war", 
		"kungfu"
	];
    
    if (prevtex == level || array_get_index(groups, level) == -1)
        exit;
    
    for (var i = 0; i < array_length(groups); i++)
    {
        if (level != groups[i])
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
