function pattern_set(arg0, arg1, arg2, arg3)
{
    static u_mask = shader_get_uniform(shd_pattern, "u_Mask");
    static u_spr = shader_get_uniform(shd_pattern, "u_SprRect");
    static u_pat = shader_get_uniform(shd_pattern, "u_PatRect");
    static u_texel = shader_get_uniform(shd_pattern, "u_TexelScl");
    static u_offset = shader_get_uniform(shd_pattern, "u_SprOffset");
    
    if (arg1 == undefined)
        arg1 = sprite_index;
    
    if (arg2 == undefined)
        arg2 = image_index;
    
    if (arg3 == undefined)
        arg3 = 4259839;
    
    var _s_pat = shader_get_sampler_index(shd_pattern, "s_Pattern");
    var _tex = sprite_get_texture(arg0, 0);
    var _tex2 = sprite_get_texture(arg1, arg2);
    shader_set(shd_pattern);
    texture_set_stage(_s_pat, _tex);
    shader_set_uniform_f(u_mask, color_get_red(arg3) / 255, color_get_green(arg3) / 255, color_get_blue(arg3) / 255, 1);
    var _uvs = sprite_get_uvs(arg1, arg2);
    shader_set_uniform_f(u_spr, _uvs[0], _uvs[1], _uvs[2], _uvs[3]);
    shader_set_uniform_f(u_offset, _uvs[4] - sprite_get_xoffset(arg1), _uvs[5] - sprite_get_yoffset(arg1));
    _uvs = sprite_get_uvs(arg0, 0);
    shader_set_uniform_f(u_pat, _uvs[0], _uvs[1], _uvs[2], _uvs[3]);
    shader_set_uniform_f(u_texel, texture_get_texel_width(_tex), texture_get_texel_height(_tex), texture_get_texel_width(_tex2), texture_get_texel_height(_tex2));
}

function clone_set(arg0, arg1)
{
    static u_spr = shader_get_uniform(shd_pizzaclone, "u_SprRect");
    static u_pat = shader_get_uniform(shd_pizzaclone, "u_PatRect");
    static u_texel = shader_get_uniform(shd_pizzaclone, "u_TexelScl");
    static u_offset = shader_get_uniform(shd_pizzaclone, "u_SprOffset");
    
    if (arg0 == undefined)
        arg0 = sprite_index;
    
    if (arg1 == undefined)
        arg1 = image_index;
    
    var _s_pat = shader_get_sampler_index(shd_pizzaclone, "s_Pattern");
    var _tex = sprite_get_texture(spr_pizzaclonepattern, 0);
    var _tex2 = sprite_get_texture(arg0, arg1);
    shader_set(shd_pizzaclone);
    texture_set_stage(_s_pat, _tex);
    var _uvs = sprite_get_uvs(arg0, arg1);
    shader_set_uniform_f(u_spr, _uvs[0], _uvs[1], _uvs[2], _uvs[3]);
    shader_set_uniform_f(u_offset, _uvs[4] - sprite_get_xoffset(arg0), _uvs[5] - sprite_get_yoffset(arg0));
    _uvs = sprite_get_uvs(spr_pizzaclonepattern, 0);
    shader_set_uniform_f(u_pat, _uvs[0], _uvs[1], _uvs[2], _uvs[3]);
    shader_set_uniform_f(u_texel, texture_get_texel_width(_tex), texture_get_texel_height(_tex), texture_get_texel_width(_tex2), texture_get_texel_height(_tex2));
}
