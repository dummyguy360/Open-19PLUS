function get_char(arg0)
{
    switch (arg0)
    {
        case "PP":
            return ["Peppino", 9988216, "event:/sfx/npc/peppino"];
        
        case "MR":
            return ["Mr. Incognito", 10400, "event:/sfx/npc/mrincognito"];
        
        case "SK":
            return ["Snick", 12058704, "event:/sfx/npc/snick"];
    }
}

state = 0;
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

scenarioupdatefunc = function()
{
};

endfunc = function()
{
};

dialoguebubblesurf = -1;
nameboxsurf = -1;
sounds = ds_map_create();
soundsetup = false;
outlinetexel = shader_get_uniform(shd_blackoutline, "u_Texel");
image_speed = 0.35;
