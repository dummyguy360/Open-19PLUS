// Feather disable all

//This script contains the default profiles, and hence the default bindings and verbs, for your game
//
//  Please edit this macro to meet the needs of your game!
//
//The struct return by this script contains the names of each default profile.
//Default profiles then contain the names of verbs. Each verb should be given a binding that is
//appropriate for the profile. You can create bindings by calling one of the input_binding_*()
//functions, such as input_binding_key() for keyboard keys and input_binding_mouse() for
//mouse buttons

function __input_config_verbs()
{
	// Changed for 19PLUS
    return 
    {
        keyboard_and_mouse: 
        {
            up: input_binding_key(vk_up),
            down: input_binding_key(vk_down),
            left: input_binding_key(vk_left),
            right: input_binding_key(vk_right),
            jump: input_binding_key("Z"),
            attack: input_binding_key("X"),
            taunt: input_binding_key("C"),
            shoot: input_binding_key("A"),
            dash: input_binding_key(vk_shift),
            groundpound: input_binding_key(vk_down),
            superjump: input_binding_key(vk_up),
            pause: input_binding_key(vk_escape)
        },
        gamepad: 
        {
            up: [input_binding_gamepad_button(gp_padu), input_binding_gamepad_axis(gp_axislv, true)],
            down: [input_binding_gamepad_button(gp_padd), input_binding_gamepad_axis(gp_axislv, false)],
            left: [input_binding_gamepad_button(gp_padl), input_binding_gamepad_axis(gp_axislh, true)],
            right: [input_binding_gamepad_button(gp_padr), input_binding_gamepad_axis(gp_axislh, false)],
            jump: input_binding_gamepad_button(gp_face1),
            attack: input_binding_gamepad_button(gp_face3),
            taunt: input_binding_gamepad_button(gp_face2),
            shoot: [input_binding_gamepad_button(gp_shoulderlb), input_binding_gamepad_button(gp_shoulderl)],
            dash: [input_binding_gamepad_button(gp_shoulderrb), input_binding_gamepad_button(gp_shoulderr)],
            groundpound: [input_binding_gamepad_button(gp_padd), input_binding_gamepad_axis(gp_axislv, false)],
            superjump: [input_binding_gamepad_button(gp_padu), input_binding_gamepad_axis(gp_axislv, true)],
            pause: [input_binding_gamepad_button(gp_start), input_binding_gamepad_button(gp_select)]
        }
    };
}