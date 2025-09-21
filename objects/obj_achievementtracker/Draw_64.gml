switch (popupstruct.type)
{
    case popup_type.cowboytask:
        var _x = get_game_width() - 146;
        var _y = (get_game_height() + 36) - (195 * popupy);
        draw_sprite(spr_notif_cowboytaskcomplete, 0, _x, _y);
        draw_sprite(popupstruct.sprite, popupstruct.index, _x, _y);
        break;
    
    case popup_type.othertask:
        var _x = get_game_width() - 146;
        var _y = (get_game_height() + 36) - (195 * popupy);
        draw_sprite(popupstruct.sprite, popupstruct.index, _x, _y);
        break;
}
