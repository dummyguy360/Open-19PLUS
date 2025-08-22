function scr_hudroomcheck()
{
    if (asset_has_tags(room, "No HUD", 3))
        return true;
    
    return false;
}
