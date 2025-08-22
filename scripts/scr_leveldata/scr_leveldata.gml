function scr_saveleveldata(arg0)
{
    wallet_open();
    wallet_writecoins(arg0);
    wallet_close();
    save_open();
    
    if (global.secretfound > ini_read_real("Secrets", arg0, 0))
        ini_write_real("Secrets", arg0, global.secretfound);
    
    if (!ini_read_real("Treasures", arg0, false))
        ini_write_string("Treasures", arg0, global.treasure);
    
    for (var i = 1; i <= 5; i++)
    {
        var top;
        
        switch (i)
        {
            case 1:
                top = obj_pizzakinshroom;
                break;
            
            case 2:
                top = obj_pizzakincheese;
                break;
            
            case 3:
                top = obj_pizzakintomato;
                break;
            
            case 4:
                top = obj_pizzakinsausage;
                break;
            
            case 5:
                top = obj_pizzakinpineapple;
                break;
        }
        
        if (!ini_read_real("Toppins", arg0 + string(i), false))
            ini_write_real("Toppins", arg0 + string(i), there_is_follower_obj(top));
    }
    
    if (!global.timetrial)
    {
        var prevrank = ini_read_real("Ranks", arg0, -1);
        
        if (global.rank > prevrank)
            ini_write_real("Ranks", arg0, global.rank);
        
        if (ini_read_real("Highscores", arg0, 0) < global.collect)
            ini_write_string("Highscores", arg0, global.collect);
    }
    else
    {
        var _prevrank = ini_read_real("TrialRanks", arg0, -1);
        
        if (global.timetrialrank > _prevrank)
            ini_write_real("TrialRanks", arg0, global.timetrialrank);
    }
    
    save_close();
}
