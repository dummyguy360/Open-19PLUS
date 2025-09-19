function scr_destroy_horizontal(arg0, arg1 = 0)
{
    if (arg0 != 0)
    {
        var _hitblock = false;
        var _arr = [obj_destructibles, obj_onewaybigblock, obj_smbitembox, noone, noone, noone, noone, noone, noone];
        
        if (arg1 & 32)
            _arr[0] = noone;
        
        if (arg1 & 64)
            _arr[1] = noone;
        
        if (arg1 & 128)
            _arr[2] = noone;
        
        if (arg1 & 1)
            _arr[3] = obj_metalblock;
        
        _arr[4] = obj_mrcar;
        
        if (arg1 & 2)
            _arr[5] = obj_ballblock;
        
        if (arg1 & 4)
            _arr[6] = obj_tntblock;
        
        if (arg1 & 8)
            _arr[7] = obj_breakableice;
        
        if (arg1 & 16)
            _arr[8] = obj_ratblock;
        
        var _inst = instance_place(x + arg0, y, _arr);
        var _dest = [];
        
        while (_inst)
        {
            _hitblock = true;
            _dest[object_index] = 1;
            
            with (_inst)
            {
                switch (object_index)
                {
                    case obj_ratblock1x1:
                    case obj_ratblock2x2:
                    case obj_ratblock:
                        instance_destroy();
                        gamepadvibrate(0.4, 0, 8);
                        break;
                    
                    case obj_mrcar:
                        var _player = other;
                        instance_destroy();
                        instance_create_depth(_player.x, _player.y, 0, obj_bangeffect);
                        scr_fmod_soundeffectONESHOT("event:/sfx/misc/mrcarhit", x, y);
                        camera_shake(3, 3);
                        
                        with (instance_create_depth(x, y, 0, obj_mrcardead))
                        {
                            hsp = _player.movespeed * _player.xscale;
                            vsp = -11;
                            image_xscale = other.image_xscale;
                        }
                        
                        gamepadvibrate(1, 0, 12);
                        
                        with (_player)
                            do_hitstun(7);
                        
                        restore_combo();
                        break;
                    
                    case obj_onewaybigblock:
                        if (sign(arg0) == -sign(image_xscale))
                            instance_destroy();
                        
                        gamepadvibrate(0.4, 0, 8);
                        break;
                    
                    case obj_smbitembox:
                        event_user(0);
                        break;
                    
                    case obj_metalblock:
                        instance_create_depth(x + 32, y + 32, -100, obj_genericpoofeffect);
                        gamepadvibrate(1, 0, 8);
                        
                        if (arg1 & 256 && (object_index == obj_bigdestructibles || object_is_ancestor(object_index, obj_bigdestructibles)))
                            instance_create_depth(other.x + (4 * other.xscale), other.y, -10, obj_bangeffect);
                        
                        instance_destroy();
                        gamepadvibrate(0.4, 0, 8);
                        break;
                    
                    default:
                        if (arg1 & 256 && (object_index == obj_bigdestructibles || object_is_ancestor(object_index, obj_bigdestructibles)))
                            instance_create_depth(other.x + (4 * other.xscale), other.y, -10, obj_bangeffect);
                        
                        instance_destroy();
                        gamepadvibrate(0.4, 0, 8);
                        break;
                }
            }
            
            _inst = instance_place(x + arg0, y, _arr);
        }
        
        if (_hitblock)
            push_notif(7, _dest);
        
        return _hitblock;
    }
}

function scr_destroy_vertical(arg0, arg1 = 0)
{
    if (arg0 != 0)
    {
        var _hitblock = false;
        var _arr = [obj_destructibles, obj_smbitembox, noone, noone, noone, noone];
        
        if (arg1 & 32)
            _arr[0] = noone;
        
        if (arg1 & 128)
            _arr[1] = noone;
        
        if (arg1 & 1)
            _arr[2] = obj_metalblock;
        
        if (arg1 & 4)
            _arr[3] = obj_tntblock;
        
        if (arg1 & 8)
            _arr[4] = obj_breakableice;
        
        if (arg1 & 16)
            _arr[5] = obj_ratblock;
        
        var _inst = instance_place(x, y + arg0, _arr);
        var _dest = [];
        
        while (_inst)
        {
            _hitblock = true;
            _dest[object_index] = 1;
            
            with (_inst)
            {
                switch (object_index)
                {
                    case obj_ratblock1x1:
                    case obj_ratblock2x2:
                    case obj_ratblock:
                        instance_destroy();
                        gamepadvibrate(0.4, 0, 8);
                        break;
                    
                    case obj_smbitembox:
                        event_user(0);
                        break;
                    
                    case obj_metalblock:
                        instance_create_depth(x + 32, y + 32, -100, obj_genericpoofeffect);
                        instance_destroy();
                        gamepadvibrate(0.2, 0, 8);
                        break;
                    
                    default:
                        instance_destroy();
                        gamepadvibrate(0.2, 0, 8);
                        break;
                }
            }
            
            _inst = instance_place(x, y + arg0, _arr);
        }
        
        if (_hitblock)
            push_notif(7, _dest);
        
        return _hitblock;
    }
}

function scr_collide_destructibles(arg0, arg1)
{
    var _flags = statemachine[state].flags;
    self.collide_destructibles(arg0, arg1);
    
    if (~_flags & 1)
    {
        var _arr = array_create(4);
        var _i = 0;
        var _cheese = instance_place(x, y + 1, obj_destructibleplatform);
        
        while (_cheese != noone && _i < array_length(_arr))
        {
            with (_cheese)
            {
                falling = 1;
                image_speed = 0.35;
                push_notif(1, [id]);
                
                if (global.levelname == "ruin" && !obj_music.secret)
                    ds_list_add(global.saveroom, id);
                
                _arr[_i++] = id;
                y -= room_height;
            }
            
            _cheese = instance_place(x, y + 1, obj_destructibleplatform);
        }
        
        repeat (_i)
            _arr[--_i].y += room_height;
    }
    
    if (state == states.firemove)
    {
        with (instance_place(x, y, obj_destructibles))
            instance_destroy();
        
        with (instance_place(x, y, obj_smbitembox))
            event_user(0);
    }
}

function scr_bump_rat(arg0 = 0, arg1 = 0, arg2 = true)
{
    var _dobump = false;
    
    with (instance_place(x + arg0, y + arg1, obj_ratblock))
    {
        sprite_index = bumpspr;
        image_index = 0;
        _dobump = true;
    }
    
    if (_dobump && arg2)
    {
        state = states.bump;
        sprite_index = spr_bump;
        xscale = other.image_xscale;
        hsp = -5 * xscale;
        vsp = -5;
        scr_fmod_soundeffectONESHOT("event:/sfx/player/bump", x, y);
        gamepadvibrate(0.4, 0, 7);
        image_index = 0;
    }
    
    return _dobump;
}

function scr_enemy_destructibles(arg0, arg1)
{
    if (thrown || parried || pummelled != noone)
    {
        var _i = instance_place(x + arg0, y + arg1, [obj_destructibles, obj_enemyblock]);
        
        while (_i != noone)
        {
            instance_destroy(_i);
            _i = instance_place(x + arg0, y + arg1, [obj_destructibles, obj_enemyblock]);
        }
    }
}

function scr_enemy_enemies(arg0, arg1)
{
    var _hit = false;
    
    if (state == states.seat && thrown)
    {
        var _i = instance_place(x + arg0, y + arg1, obj_baddiecollisionbox);
        
        while (_i != noone)
        {
            _hit = true;
            instance_destroy(_i.baddieID);
            instance_destroy(_i);
            _i = instance_place(x + arg0, y + arg1, obj_baddiecollisionbox);
        }
    }
    
    return _hit;
}
