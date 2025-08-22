condition = function()
{
    return global.panic;
};

if (obj_player.character == "N")
    texts = string_get("tvmessages/entryN/unimpressed");
else
    texts = string_get("tvmessages/entry/unimpressed");
