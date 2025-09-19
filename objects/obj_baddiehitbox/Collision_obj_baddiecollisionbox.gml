with (other.id)
{
    if (instance_exists(baddieID) && baddieID != other.id && baddieID.hitboxID != other.id)
    {
        if (baddieID.state == states.seat && baddieID.thrown)
        {
            instance_destroy(other.baddieID);
            instance_destroy(other.id);
        }
    }
}
