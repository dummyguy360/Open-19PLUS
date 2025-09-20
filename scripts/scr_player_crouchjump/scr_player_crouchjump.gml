function scr_player_crouchjump()
{
    var _crouchjumpanim = spr_crouchjump;
    var _crouchfallanim = spr_crouchfall;
    
    if (global.currentpowerup == powerup.shotgun)
    {
        _crouchjumpanim = spr_shotguncrouchjump1;
        _crouchfallanim = spr_shotguncrouchjump2;
    }
    
    move = input_check_opposing("left", "right");
    
    if (fallinganimation >= 40 && fallinganimation < 80)
    {
        sprite_index = spr_facestomp;
        state = states.jump;
    }
    
    mask_index = spr_crouchmask;
    hsp = move * movespeed;
    movespeed = 4;
    
    if (!input_check("jump") && !jumpstop && jumpAnim)
    {
        vsp /= 2;
        jumpstop = 1;
    }
    
    if (scr_solid(x, y - 1) && !jumpstop && jumpAnim)
    {
        vsp = grav;
        jumpstop = 1;
    }
    
    if (grounded && vsp >= 0)
    {
        state = states.crouch;
        jumpAnim = 1;
        crouchAnim = 1;
        image_index = 0;
        jumpstop = 0;
        scr_fmod_soundeffectONESHOT("event:/sfx/player/step", x, y);
    }
    
    if (jumpAnim)
    {
        sprite_index = _crouchjumpanim;
        
        if (floor(image_index) == (image_number - 1))
            jumpAnim = 0;
    }
    
    if (!jumpAnim)
        sprite_index = _crouchfallanim;
    
    if (grounded && !input_check("down") && !scr_solid(x, y - 16))
    {
        movespeed = 0;
        state = states.normal;
        jumpAnim = 1;
        landAnim = 1;
        crouchAnim = 1;
        image_index = 0;
        jumpstop = 0;
        mask_index = spr_player_mask;
        scr_fmod_soundeffectONESHOT("event:/sfx/player/step", x, y);
    }
    
    if (move != 0)
        xscale = move;
    
    image_speed = 0.35;
}
