function scr_saveleveldata(levelname)
{
    wallet_open();
    wallet_writecoins(levelname);
    wallet_close();
    save_open();
    
    if (global.secretfound > ini_read_real("Secrets", levelname, 0))
        ini_write_real("Secrets", levelname, global.secretfound);
    
    if (!ini_read_real("Treasures", levelname, false))
        ini_write_string("Treasures", levelname, global.treasure);
    
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
        
        if (!ini_read_real("Toppins", levelname + string(i), false))
            ini_write_real("Toppins", levelname + string(i), there_is_follower_obj(top));
    }
    
    if (!global.timetrial)
    {
        var prevrank = ini_read_real("Ranks", levelname, -1);
        
        if (global.rank > prevrank)
            ini_write_real("Ranks", levelname, global.rank);
        
        if (ini_read_real("Highscores", levelname, 0) < global.collect)
            ini_write_string("Highscores", levelname, global.collect);
    }
    else
    {
        var _prevrank = ini_read_real("TrialRanks", levelname, -1);
        
        if (global.timetrialrank > _prevrank)
            ini_write_real("TrialRanks", levelname, global.timetrialrank);
    }
    
    save_close();
}
