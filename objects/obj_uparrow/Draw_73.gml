with (obj_player)
{
    if (grounded && sprite_index != spr_player_spawn && state != 54 && state != 41 && state != 39 && state != 122 && !scr_transformationcheck() && place_meeting(x, y, obj_uparrowhitbox))
        draw_sprite(spr_uparrow, -1, x, y - 50);
}
