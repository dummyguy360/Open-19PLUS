with (obj_player)
{
    if (grounded && sprite_index != spr_player_spawn && state != states.door && state != states.victory && state != states.comingoutdoor && state != states.npclocked && !scr_transformationcheck() && place_meeting(x, y, obj_uparrowhitbox))
        draw_sprite(spr_uparrow, -1, x, y - 50);
}
