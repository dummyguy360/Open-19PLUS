var _bananaid = id;

with (other.id)
{
    state = states.slipbanan;
    
    if (movespeed < 6)
        movespeed = 6;
    
    if (movespeed > 12)
        movespeed = 12;
    
    vsp = -12;
    image_index = 0;
    sprite_index = spr_slipbanan1;
    scr_fmod_soundeffect(slipsnd, x, y);
    
    with (instance_create_depth(x, y, -100, obj_baddiedead))
        sprite_index = _bananaid.sprite_index;
    
    push_notif(achieve_type.entry3, [_bananaid, _bananaid.baddieID]);
    instance_destroy(_bananaid);
}
