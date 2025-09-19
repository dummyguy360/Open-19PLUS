if (instance_exists(grabbedby))
{
    if (grabbedby.state == states.grab || grabbedby.state == states.kungfugrab || grabbedby.state == states.tacklecharge || grabbedby.state == states.finishingblow || grabbedby.sprite_index == grabbedby.spr_piledriver || grabbedby.sprite_index == grabbedby.spr_piledriverland)
        grabbedby.state = states.normal;
    
    grabbedby = noone;
}
