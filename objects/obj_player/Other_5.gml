if (global.combo <= 0)
    global.prankattempt = true;

if (instance_exists(obj_mortfollow) && global.currentpowerup == powerup.mort)
    instance_destroy(obj_mortfollow);

if (place_meeting(x, y, obj_startgate))
    scr_playerreset(1);
