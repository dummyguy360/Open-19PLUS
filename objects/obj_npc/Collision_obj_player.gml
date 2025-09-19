if (other.state == states.normal && other.grounded && input_check_pressed("up"))
{
    other.state = states.npclocked;
    state = states.tumble;
    self.scenarioupdatefunc();
}
