with (obj_player)
{
    var _checkstate = state;
    
    if (state == states.secretportal)
        _checkstate = tauntstoredstate;
    
    if (state == states.hitstun)
        _checkstate = hitstunstoredstate;
    
    if (_checkstate == states.knightpep || _checkstate == states.knightpepbump || _checkstate == states.knightpepslopes)
        other.sprite_index = spr_swordstonetaken;
    else
        other.sprite_index = spr_swordstone;
}
