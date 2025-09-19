if (other.state != states.hitstun)
{
    scr_hurtplayer(other.id, false);
    instance_destroy();
}
