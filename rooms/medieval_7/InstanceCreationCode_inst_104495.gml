condition = function()
{
    return global.panic;
};

if (obj_player.character == "N")
    texts = string_get("tvmessages/medievalN/alerted");
else
    texts = string_get("tvmessages/medieval/alerted");
