function scr_transformationcheck(p = instance_nearest(x, y, obj_player))
{
    if (p.state == states.knightpep || p.state == states.knightpepslopes || p.state == states.knightpepbump || p.state == states.bombpep 
	|| p.state == states.cheesepep || p.state == states.cheesepepstick || p.state == states.cheeseball || p.state == states.heropep 
	|| p.state == states.boxxedpep || p.state == states.firemouth || p.state == states.fireass || p.state == states.firemove || p.state == states.barrel)
        return true;
    
    return false;
}
