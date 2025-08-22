if (instance_exists(grabbedby))
{
    if (grabbedby.state == 28 || grabbedby.state == 119 || grabbedby.state == 7 || grabbedby.state == 2 || grabbedby.sprite_index == grabbedby.spr_piledriver || grabbedby.sprite_index == grabbedby.spr_piledriverland)
        grabbedby.state = 0;
    
    grabbedby = -4;
}
