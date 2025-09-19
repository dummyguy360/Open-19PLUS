if (distance_to_object(obj_player) < 200 && (obj_player.instakillmove || obj_player.state == states.suplexgrab || obj_player.state == states.kungfu || obj_player.state == states.shoulderbash || obj_player.state == states.lunge))
    sprite_index = spr_pillarjohn_worried;
else if (distance_to_object(obj_player) > 200)
    sprite_index = spr_pillarjohn;
