if (place_meeting(x, y - 1, obj_player))
{
    with (obj_player)
    {
        if (place_meeting(x, y + 1, obj_ladder) && input_check("down") && (state == 43 || (character == "S" && (state == 0 || state == 45))) && place_meeting(x, y + 1, obj_platform))
        {
            y += 5;
            state = 37;
            x = other.x + 16;
            y = floor(y);
            
            if ((y % 2) == 1)
                y -= 1;
        }
    }
}

visible = obj_drawcontroller.solidvisible;
