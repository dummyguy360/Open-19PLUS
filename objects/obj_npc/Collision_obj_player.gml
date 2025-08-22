if (other.state == 0 && other.grounded && input_check_pressed("up"))
{
    other.state = 122;
    state = 1;
    self.scenarioupdatefunc();
}
