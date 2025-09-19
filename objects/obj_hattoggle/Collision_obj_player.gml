if (other.state == states.normal && other.grounded && input_check_pressed("up"))
{
    with (obj_cowboyhat)
        persistent = !persistent;
}
