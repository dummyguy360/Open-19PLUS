if (distance_to_object(obj_player) < 200 && (obj_player.instakillmove || obj_player.state == 16 || obj_player.state == 91 || obj_player.state == 73 || obj_player.state == 118))
    sprite_index = spr_pillarjohn_worried;
else if (distance_to_object(obj_player) > 200)
    sprite_index = spr_pillarjohn;
