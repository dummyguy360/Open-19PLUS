function gamepadvibrate(strength, pan, duration, index = 0, force = false)
{
    if (global.rumble)
        input_vibrate_constant(strength, pan, duration, index, force);
}
