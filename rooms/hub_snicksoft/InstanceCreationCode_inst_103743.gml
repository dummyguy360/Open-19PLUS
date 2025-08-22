saveid = "dragonslair2";

hidecond = function()
{
    save_open();
    var _unlocked = ini_read_real("GameProgress", "dragonslairunlocked", false);
    save_close();
    return _unlocked;
};
