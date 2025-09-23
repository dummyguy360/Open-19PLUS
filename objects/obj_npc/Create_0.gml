function get_char(char_name)
{
    switch (char_name)
    {
        case "PP":
            return ["Peppino", #786898, "event:/sfx/npc/peppino"];
        
        case "MR":
            return ["Mr. Incognito", #A02800, "event:/sfx/npc/mrincognito"];
        
        case "SK":
            return ["Snick", #5000B8, "event:/sfx/npc/snick"];
    }
}

state = states.normal;
exclemationframe = -1;
bubblescaleanim = 0;
bubblerot = 0;
bubbletilttimer = 0;
nameboxscaleanim = 0;
nameboxrot = 0;
nameslideanim = 0;
characterslide = 0;
currentline = 0;
currentchar = 0;
talkspr = 0;
nextbuttonind = 0;
uparrowid = create_uparrow();
scenario = parse_dialogue();

scenarioupdatefunc = function() { };
endfunc = function() { };

dialoguebubblesurf = -1;
nameboxsurf = -1;
sounds = ds_map_create();
soundsetup = false;
outlinetexel = shader_get_uniform(shd_blackoutline, "u_Texel");
image_speed = 0.35;
