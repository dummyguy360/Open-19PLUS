// unused in code, but works
function pattern_set(_pal_spr, _target_spr = sprite_index, _target_spr_index = image_index, _mask_col = #FFFF40)
{
    static u_mask = shader_get_uniform(shd_pattern, "u_Mask");
    static u_spr = shader_get_uniform(shd_pattern, "u_SprRect");
    static u_pat = shader_get_uniform(shd_pattern, "u_PatRect");
    static u_texel = shader_get_uniform(shd_pattern, "u_TexelScl");
    static u_offset = shader_get_uniform(shd_pattern, "u_SprOffset");
    
    var _s_pat = shader_get_sampler_index(shd_pattern, "s_Pattern");
    var _tex = sprite_get_texture(_pal_spr, 0);
    var _tex2 = sprite_get_texture(_target_spr, _target_spr_index);
    shader_set(shd_pattern);
    texture_set_stage(_s_pat, _tex);
    shader_set_uniform_f(u_mask, color_get_red(_mask_col) / 255, color_get_green(_mask_col) / 255, color_get_blue(_mask_col) / 255, 1);
    var _uvs = sprite_get_uvs(_target_spr, _target_spr_index);
    shader_set_uniform_f(u_spr, _uvs[0], _uvs[1], _uvs[2], _uvs[3]);
    shader_set_uniform_f(u_offset, _uvs[4] - sprite_get_xoffset(_target_spr), _uvs[5] - sprite_get_yoffset(_target_spr));
    _uvs = sprite_get_uvs(_pal_spr, 0);
    shader_set_uniform_f(u_pat, _uvs[0], _uvs[1], _uvs[2], _uvs[3]);
    shader_set_uniform_f(u_texel, texture_get_texel_width(_tex), texture_get_texel_height(_tex), texture_get_texel_width(_tex2), texture_get_texel_height(_tex2));
}

// used only for peppino cheese clone
function clone_set(_target_spr = sprite_index, _target_spr_index = image_index)
{
    static u_spr = shader_get_uniform(shd_pizzaclone, "u_SprRect");
    static u_pat = shader_get_uniform(shd_pizzaclone, "u_PatRect");
    static u_texel = shader_get_uniform(shd_pizzaclone, "u_TexelScl");
    static u_offset = shader_get_uniform(shd_pizzaclone, "u_SprOffset");
    
    var _s_pat = shader_get_sampler_index(shd_pizzaclone, "s_Pattern");
    var _tex = sprite_get_texture(spr_pizzaclonepattern, 0);
    var _tex2 = sprite_get_texture(_target_spr, _target_spr_index);
    shader_set(shd_pizzaclone);
    texture_set_stage(_s_pat, _tex);
    var _uvs = sprite_get_uvs(_target_spr, _target_spr_index);
    shader_set_uniform_f(u_spr, _uvs[0], _uvs[1], _uvs[2], _uvs[3]);
    shader_set_uniform_f(u_offset, _uvs[4] - sprite_get_xoffset(_target_spr), _uvs[5] - sprite_get_yoffset(_target_spr));
    _uvs = sprite_get_uvs(spr_pizzaclonepattern, 0);
    shader_set_uniform_f(u_pat, _uvs[0], _uvs[1], _uvs[2], _uvs[3]);
    shader_set_uniform_f(u_texel, texture_get_texel_width(_tex), texture_get_texel_height(_tex), texture_get_texel_width(_tex2), texture_get_texel_height(_tex2));
}
