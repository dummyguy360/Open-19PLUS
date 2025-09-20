np_update();

if (global.levelname != noone)
    details = scr_getlevelname(global.levelname);

var _state = string_concat("Score: ", global.collect, " / Rank: ", scr_getlevelpoints(), " / Combo: ", global.combo);

if (global.timetrial)
{
    var _seconds = string_padzeros(floor((global.timetrialtick / 60) % 60));
    var _minutes = string_padzeros((global.timetrialtick div 60 div 60) % 60);
    _state = string_concat("Time: ", string_concat(_minutes, ":", _seconds), " / Medal: ", scr_getleveltime(), " / Combo: ", global.combo);
}

if (scr_hudroomcheck() || global.levelname == "tutorial")
    _state = "";

switch (room)
{
    case init:
    case logos:
        details = "Get ready for....";
        break;
    
    case TitlescreenRoom:
        details = "PT ‘19 Plus SAGE Demo";
        break;
    
    case Scootertransition:
    case intro:
        details = "What's this?";
        break;
    
    case hub_forcedtutorial:
        details = "One step away from";
        _state = "the scrapers entrance.";
        break;
    
    case hub_snicksoft:
        details = "Welcome to... Snicksoft HQ!";
        break;
    
    case rank_roomtutorial:
        details = "This is just the beginning...";
        break;
    
    case rank_room:
        details = "And your final rank is.... ";
        
        if (!global.timetrial)
        {
            switch (global.rank)
            {
                case rank.P:
                    _state = "a SPECTACULAR P!!!";
                    break;
                
                case rank.S:
                    _state = "a PERFECT S!!";
                    break;
                
                case rank.A:
                    _state = "a Nice A!";
                    break;
                
                case rank.B:
                    _state = "a Subpar B.";
                    break;
                
                case rank.C:
                    _state = "a Decent C... Could've been better.";
                    break;
                
                case rank.D:
                    _state = "a TERRIBLE D. Shameful.";
                    break;
            }
        }
        else
        {
            switch (global.timetrialrank)
            {
                case tt_rank.purple:
                    _state = "a SPECTACULAR Purple medal!!!";
                    break;
                
                case tt_rank.gold:
                    _state = "a PERFECT Gold medal!!";
                    break;
                
                case tt_rank.silver:
                    _state = "a Nice Silver medal!";
                    break;
                
                case tt_rank.bronze:
                    _state = "a Subpar Bronze medal.";
                    break;
            }
        }
        
        break;
    
    case timesuproom:
        details = "Oh well, that's... unfortunate.";
        break;
}

var _smallimage = "";
var _smalltext = "";

switch (global.currentbadge)
{
    case badge.kungfu:
        _smallimage = "blackbelt";
        _smalltext = "Current Badge: Kung Fu";
        break;
    
    case badge.bdance:
        _smallimage = "boombox";
        _smalltext = "Current Badge: Breakdance";
        break;
    
    case badge.nohit:
        _smallimage = "puppet";
        _smalltext = "Current Badge: No Hit";
        break;
}

np_setpresence(_state, details, "ptpicon", _smallimage);

if (instance_exists(obj_player))
{
    if (obj_player.character == "N")
        np_setpresence_more(_smalltext, "The Noise!", true);
    else
        np_setpresence_more(_smalltext, "Peppino!", true);
}
else
    np_setpresence_more(_smalltext, "Peppino!", true);
