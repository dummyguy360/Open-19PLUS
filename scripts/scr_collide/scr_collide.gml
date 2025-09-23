function scr_collide()
{
    grounded = false;
    var vy = vsp;
    
    repeat (ceil(abs(vy)))
    {
        var v = clamp(vy, -1, 1);
        
        if (!scr_solid(x, y + v))
        {
            y += v;
            vy -= v;
        }
        else
        {
            vsp = 0;
            break;
        }
    }
    
    var vx = hsp;
    
    repeat (ceil(abs(vx)))
    {
        var v = clamp(vx, -1, 1);
        var cDefault = scr_solid(x + v, y);
        var skipCollision = false;
        var snapPrecision = 0.25;
        var maxSnapUp = 2.75;
        var maxSnapDown = 3;
        var snap = 0;
        var ogY = y;
        
        if (cDefault)
        {
            while (scr_solid(x + v, y))
            {
                skipCollision = true;
                y -= snapPrecision;
                snap += snapPrecision;
                
                if (snap > maxSnapUp)
                {
                    skipCollision = false;
                    y = ogY;
                    break;
                }
            }
        }
        else
        {
            skipCollision = true;
            
            while (!scr_solid(x + v, y + snapPrecision))
            {
                y += snapPrecision;
                snap += snapPrecision;
                
                if (snap > maxSnapDown)
                {
                    y = ogY;
                    break;
                }
            }
        }
        
        if (skipCollision)
        {
            x += v;
            vx -= v;
        }
        else
        {
            hsp = 0;
            break;
        }
    }
    
    if (vsp < 10)
        vsp += grav;
    
    grounded |= scr_solid(x, y + 1);
}

function scr_collide_enemy()
{
    grounded = false;
    var _selfcollision = noone;
    
    with (obj_baddiecollisionbox)
    {
        if (baddieID == other.id)
        {
            _selfcollision = id;
            y -= room_height;
        }
    }
    
    var vy = vsp;
    
    repeat (ceil(abs(vy)))
    {
        var v = clamp(vy, -1, 1);
        scr_enemy_destructibles(0, v);
        killed |= scr_enemy_enemies(0, v);
        
        if (!scr_solid(x, y + v))
        {
            y += v;
            vy -= v;
        }
        else
        {
            killed |= (hp <= 0);
            
            if (state == states.seat && thrown)
                killed = true;
            
            vsp = 0;
            break;
        }
    }
    
    var vx = hsp;
    
    repeat (ceil(abs(vx)))
    {
        var v = clamp(vx, -1, 1);
        scr_enemy_destructibles(v, 0);
        killed |= scr_enemy_enemies(v, 0);
        var cDefault = scr_solid(x + v, y);
        var skipCollision = false;
        var snapPrecision = 0.25;
        var maxSnapUp = 2.75;
        var maxSnapDown = 3;
        var snap = 0;
        var ogY = y;
        
        if (cDefault)
        {
            while (scr_solid(x + v, y))
            {
                skipCollision = true;
                y -= snapPrecision;
                snap += snapPrecision;
                
                if (snap > maxSnapUp)
                {
                    skipCollision = false;
                    y = ogY;
                    break;
                }
            }
        }
        else
        {
            skipCollision = true;
            
            while (!scr_solid(x + v, y + snapPrecision))
            {
                y += snapPrecision;
                snap += snapPrecision;
                
                if (snap > maxSnapDown)
                {
                    y = ogY;
                    break;
                }
            }
        }
        
        if (skipCollision)
        {
            x += v;
            vx -= v;
        }
        else
        {
            killed |= (hp <= 0);
            
            if (state == states.seat && thrown)
                killed = true;
            
            hsp = 0;
            break;
        }
    }
    
    if (vsp < 10)
        vsp += grav;
    
    grounded |= scr_solid(x, y + 1);
    
    with (_selfcollision)
        y += room_height;
}

function scr_collide_and_destroy(_obj)
{
    grounded = false;
    var _destroyedsomething = false;
    var vy = vsp;
    
    repeat (ceil(abs(vy)))
    {
        var v = clamp(vy, -1, 1);
        var _i = instance_place(x, y + v, _obj);
        
        while (_i != noone)
        {
            _destroyedsomething = true;
            instance_destroy(_i);
            _i = instance_place(x, y + v, _obj);
        }
        
        if (!scr_solid(x, y + v))
        {
            y += v;
            vy -= v;
        }
        else
        {
            vsp = 0;
            break;
        }
    }
    
    var vx = hsp;
    
    repeat (ceil(abs(vx)))
    {
        var v = clamp(vx, -1, 1);
        var _i = instance_place(x + v, y, _obj);
        
        while (_i != noone)
        {
            _destroyedsomething = true;
            instance_destroy(_i);
            _i = instance_place(x + v, y, _obj);
        }
        
        var cDefault = scr_solid(x + v, y);
        var skipCollision = false;
        var snapPrecision = 0.25;
        var maxSnapUp = 2.75;
        var maxSnapDown = 3;
        var snap = 0;
        var ogY = y;
        
        if (cDefault)
        {
            while (scr_solid(x + v, y))
            {
                skipCollision = true;
                y -= snapPrecision;
                snap += snapPrecision;
                
                if (snap > maxSnapUp)
                {
                    skipCollision = false;
                    y = ogY;
                    break;
                }
            }
        }
        else
        {
            skipCollision = true;
            
            while (!scr_solid(x + v, y + snapPrecision))
            {
                y += snapPrecision;
                snap += snapPrecision;
                
                if (snap > maxSnapDown)
                {
                    y = ogY;
                    break;
                }
            }
        }
        
        if (skipCollision)
        {
            x += v;
            vx -= v;
        }
        else
        {
            hsp = 0;
            break;
        }
    }
    
    if (vsp < 10)
        vsp += grav;
    
    grounded |= scr_solid(x, y + 1);
    return _destroyedsomething;
}
