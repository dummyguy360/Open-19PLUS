if (other.state != 87 && !parried)
{
    scr_hurtplayer(other.id, false);
    instance_destroy();
}
