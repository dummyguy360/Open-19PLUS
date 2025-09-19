if (instance_exists(baddieID))
{
    with (baddieID)
    {
        if (object_index != obj_pizzagoblin)
        {
            state = states.seat;
            stunned = 100;
            vsp = -5;
        }
    }
}
