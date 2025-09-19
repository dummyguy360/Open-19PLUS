if (place_meeting(x, y, obj_destructibles))
    visible = false;
else
    visible = true;

with (obj_player)
{
    if (other.image_yscale == 1)
    {
        if (!place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other.id) && (state == states.crouch || character == "S" || state == states.machroll || state == states.crouchslide || state == states.freefall || state == states.freefallland || state == states.nwalljump) && !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other.id) && !instance_exists(obj_fadeout) && state != states.door && state != states.comingoutdoor)
            enterboxofpizza(spr_downpizzabox);
    }
    
    if (other.image_yscale == -1)
    {
        if (!place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 1, other.id) && ((input_check("up") && (state == states.normal || state == states.jump || state == states.shoryuken || state == states.mach2 || state == states.mach3 || state == states.nwalljump)) || state == states.sjump || state == states.sjumpland) && !place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 1, other.id) && !instance_exists(obj_fadeout) && state != states.door && state != states.comingoutdoor)
            enterboxofpizza(spr_uppizzabox);
    }
}

if (place_meeting(x, y + 1, obj_doorletterpar))
    targetDoor = instance_place(x, y + 1, obj_doorletterpar).letter;

if (place_meeting(x, y - 1, obj_doorletterpar))
    targetDoor = instance_place(x, y - 1, obj_doorletterpar).letter;
