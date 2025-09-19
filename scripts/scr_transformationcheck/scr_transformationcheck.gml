function scr_transformationcheck(arg0 = instance_nearest(x, y, obj_player))
{
    if (arg0.state == states.knightpep || arg0.state == states.knightpepslopes || arg0.state == states.knightpepbump || arg0.state == states.bombpep 
	|| arg0.state == states.cheesepep || arg0.state == states.cheesepepstick || arg0.state == states.cheeseball || arg0.state == states.heropep 
	|| arg0.state == states.boxxedpep || arg0.state == states.firemouth || arg0.state == states.fireass || arg0.state == states.firemove || arg0.state == states.barrel)
        return true;
    
    return false;
}
