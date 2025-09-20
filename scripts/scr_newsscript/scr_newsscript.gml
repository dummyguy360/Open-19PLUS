function trigger_news(_text = -1, _hud = -1)
{
    with (obj_drawcontroller)
    {
        news = _text;
        newshud = _hud;
        newsscrl = 0;
        newspopup = 0;
        newsarr = 0;
    }
}

function scr_newsscript(level)
{
    with (obj_drawcontroller)
    {
        newshud = -1;
        
        switch (level)
        {
            case "tutorial1":
                news = ["Press " + input_verb_get_icon("jump") + " to jump!", "Hold " + input_verb_get_icon("down") + " to crawl!"];
                newshud = ["ball", "ball"];
                break;
            
            case "tutorial2":
                news = ["Press " + input_verb_get_icon("down") + " in midair to body slam!"];
                newshud = ["ball"];
                break;
            
            case "tutorial3":
                news = ["Press " + input_verb_get_icon("down") + " higher in midair to destroy metal blocks!"];
                newshud = ["ball"];
                break;
            
            case "tutorial4":
                news = ["Press " + input_verb_get_icon("attack") + " to suplex dash!"];
                newshud = ["ball"];
                break;
            
            case "tutorial5":
                news = ["You can also start a suplex dash in midair!"];
                newshud = ["ball"];
                break;
            
            case "tutorial6":
                news = ["Some destroyables may be hidden! Keep an EYE out for them!"];
                newshud = ["ball"];
                break;
            
            case "tutorial7":
                news = ["Press and hold " + input_verb_get_icon("dash") + " to mach dash!"];
                newshud = ["ball"];
                break;
            
            case "tutorial8":
                news = ["Gain enough speed while mach dashing to destroy metal blocks!"];
                newshud = ["ball"];
                break;
            
            case "tutorial9":
                news = ["While mach dashing, jump onto a wall to wallrun!"];
                newshud = ["ball"];
                break;
            
            case "tutorial10":
                news = ["You can also simply run up a slope to start a wallrun!"];
                newshud = ["ball"];
                break;
            
            case "tutorial11":
                news = ["While wallrunning, keep holding " + input_verb_get_icon("dash") + " and press " + input_verb_get_icon("jump") + " to jump off a wall!"];
                newshud = ["ball"];
                break;
            
            case "tutorial12":
                news = ["While mach dashing, press and hold " + input_verb_get_icon("down") + " to roll!"];
                newshud = ["ball"];
                break;
            
            case "tutorial13":
                news = ["While mach dashing, hold the opposite direction to change direction!"];
                newshud = ["ball"];
                break;
        }
        
        newsscrl = 0;
        newspopup = 0;
        newsarr = 0;
    }
}
