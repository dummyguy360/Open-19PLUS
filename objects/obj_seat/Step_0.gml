with (obj_player)
{
    if (state == states.jump && !grounded && vsp > 0 && place_meeting(x, y + 1, other) && other.player_isseated == 0 && other.player_cansit == 1)
    {
        other.player_isseated = 1;
        state = states.seat;
        sprite_index = spr_emo;
        xscale = 1;
        x = other.x;
        y = other.y;
        instance_create_depth(x, y, -20, obj_genericpoofeffect);
    }
}
