function scr_transformationcheck(arg0 = instance_nearest(x, y, obj_player))
{
    if (arg0.state == 18 || arg0.state == 13 || arg0.state == 115 || arg0.state == 19 
	|| arg0.state == 9 || arg0.state == 10 || arg0.state == 8 || arg0.state == 99 
	|| arg0.state == 11 || arg0.state == 5 || arg0.state == 4 || arg0.state == 97 || arg0.state == 105)
        return true;
    
    return false;
}
