function gamepadvibrate(arg0, arg1, arg2, arg3 = 0, arg4 = false)
{
    if (global.rumble)
        input_vibrate_constant(arg0, arg1, arg2, arg3, arg4);
}
