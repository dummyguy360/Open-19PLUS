draw_set_font(global.font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
bgqueue = array_unique(bgqueue, -1, -infinity);
bgqueue = array_reverse(bgqueue);
array_foreach(bgqueue, function(_layer, _unused)
{
    draw_sprite_tiled_ext(_layer.background, -1, bgx, bgy, 1, 1, c_white, _layer.fade);
    var _temp_local_var_3 = -9;
    _layer.fade = _layer.fade + (_layer.dofade ? -0.1 : 0.1);
    _layer.fade = clamp(_layer.fade, 0, 1);
});
bgqueue = array_filter(bgqueue, function(_layer, _unused)
{
    return _layer.fade > 0;
});
ds_stack_top(optionstack).drawoptions();
draw_set_font(global.thinfont);
draw_set_valign(fa_bottom);
draw_set_halign(fa_left);
draw_text_fancy(20, get_game_height() - 20, optiontip);

if (room == TitlescreenRoom)
{
    draw_set_font(global.smallfont);
    draw_set_halign(fa_right);
    __draw_text_hook(get_game_width() - 20, get_game_height() - 20, "V1.0.3");
}
