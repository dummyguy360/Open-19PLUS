if (savestate != states.normal)
{
    saveiconalpha = 3;
    
    if (savestate == states.ejected)
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
