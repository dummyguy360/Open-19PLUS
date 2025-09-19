if (other.state != states.hitstun && !parried)
{
    scr_hurtplayer(other.id, false);
    instance_destroy();
}
