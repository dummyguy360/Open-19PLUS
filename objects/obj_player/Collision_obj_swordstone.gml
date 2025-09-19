if (grounded && other.sprite_index == spr_swordstone && (is_player_grabbing() || (character == "S" && state == states.normal)))
{
    scr_fmod_soundeffectONESHOT("event:/sfx/player/transfo/knightsword", x, y);
    momemtum = 0;
    movespeed = 0;
    other.image_index = 1;
    image_index = 0;
    image_speed = 0.35;
    sprite_index = spr_knightpepstart;
    state = states.knightpep;
    hsp = 0;
    knightsliding = 0;
    
    switch (other.swordtype)
    {
        case 0:
            knightspr = 0;
            break;
        
        case 1:
            knightspr = 1;
            break;
        
        case 2:
            knightspr = 2;
            break;
    }
    
    restore_combo();
}
