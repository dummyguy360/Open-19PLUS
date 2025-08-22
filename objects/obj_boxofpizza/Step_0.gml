if (place_meeting(x, y, obj_destructibles))
    visible = false;
else
    visible = true;

with (obj_player)
{
    if (other.image_yscale == 1)
    {
        if (!place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other.id) && (state == 43 || character == "S" || state == 23 || state == 45 || state == 51 || state == 53 || state == 120) && !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other.id) && !instance_exists(obj_fadeout) && state != 54 && state != 39)
            enterboxofpizza(spr_downpizzabox);
    }
    
    if (other.image_yscale == -1)
    {
        if (!place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 1, other.id) && ((input_check("up") && (state == 0 || state == 36 || state == 75 || state == 47 || state == 66 || state == 120)) || state == 40 || state == 68) && !place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 1, other.id) && !instance_exists(obj_fadeout) && state != 54 && state != 39)
            enterboxofpizza(spr_uppizzabox);
    }
}

if (place_meeting(x, y + 1, obj_doorletterpar))
    targetDoor = instance_place(x, y + 1, obj_doorletterpar).letter;

if (place_meeting(x, y - 1, obj_doorletterpar))
    targetDoor = instance_place(x, y - 1, obj_doorletterpar).letter;
