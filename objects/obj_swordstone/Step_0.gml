with (obj_player)
{
    var _checkstate = state;
    
    if (state == 116)
        _checkstate = tauntstoredstate;
    
    if (state == 87)
        _checkstate = hitstunstoredstate;
    
    if (_checkstate == 18 || _checkstate == 115 || _checkstate == 13)
        other.sprite_index = spr_swordstonetaken;
    else
        other.sprite_index = spr_swordstone;
}
