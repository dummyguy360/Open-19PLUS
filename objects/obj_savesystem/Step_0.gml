if (savestate != save_state.idle)
{
    saveiconalpha = 3;
    
    if (savestate == save_state.dumpconfig)
        saveiconspr = spr_configsaveindicator;
    else
        saveiconspr = spr_saveindicator;
}
else
{
    saveiconalpha -= 0.05;
    
    if (saveiconalpha < 0)
        saveiconalpha = 0;
}

saveiconind += 0.25;
saveiconind %= sprite_get_number(saveiconspr);
