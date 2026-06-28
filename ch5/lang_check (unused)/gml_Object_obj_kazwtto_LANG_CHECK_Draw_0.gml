if (!variable_instance_exists(id, "_global_alpha"))
    _global_alpha = 0;

if (!variable_instance_exists(id, "_target_state"))
    _target_state = "";

if (_target_state != "")
{
    _global_alpha = lerp(_global_alpha, 0, 0.2);
    
    if (_global_alpha < 0.05)
    {
        _global_alpha = 0;
        _current_state = _target_state;
        _target_state = "";
    }
}
else
{
    _global_alpha = lerp(_global_alpha, 1, 0.1);
}

var _gui_width = display_get_gui_width();
var _gui_height = display_get_gui_height();
var _box_width = 400;
var _box_height = 200;
var _box_x = (_gui_width - _box_width) / 2;
var _box_y = (_gui_height - _box_height) / 2;
var _text_color = 16777215;
var _highlight_color = 65535;
draw_set_font(fnt_mainbig);
draw_set_alpha(_global_alpha);

if (_is_checking)
{
    draw_set_color(_text_color);
    draw_sprite_ext(spr_ralsei_jump_ball, current_time / 100, _gui_width / 2, (_gui_height / 2) - 60, 2, 2, 0, c_white, _global_alpha);
    var _str = "Verificando atualização da tradução";
    var _scale = 0.8;
    var _char_x = (_gui_width / 2) - ((string_width(_str) * _scale) / 2);
    var _text_y = (_gui_height / 2) + 20;
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    
    for (var i = 1; i <= string_length(_str); i++)
    {
        var _char = string_char_at(_str, i);
        var _wave_y = sin((current_time / 150) + (i * 0.4)) * 5;
        draw_text_transformed(_char_x, _text_y + _wave_y, _char, _scale, _scale, 0);
        _char_x += (string_width(_char) * _scale);
    }
}

if (_show_ui && _current_state == "ASKING")
{
    draw_set_alpha(_ui_alpha * 0.8 * _global_alpha);
    draw_rectangle_color(0, 0, _gui_width, _gui_height, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(_global_alpha);
    draw_set_color(_text_color);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    var _text_y = _box_y + 20;
    draw_text_ext_transformed(_gui_width / 2, _text_y, "Arquivos desatualizados detectados.\nDeseja baixar a versão mais recente?", -1, (_gui_width - 40) / 0.8, 0.8, 0.8, 0);
    var _choices = ["Baixar", "Ignorar"];
    var _choice_y = _box_y + 120;
    var _choice_spacing = 150;
    var _choice_x_start = (_gui_width - (_choice_spacing * (_choice_count - 1))) / 2;
    
    for (var i = 0; i < _choice_count; i++)
    {
        var _choice_x = _choice_x_start + (i * _choice_spacing);
        var _is_selected = i == _choice_selected;
        
        if (_is_selected)
        {
            draw_set_color(_highlight_color);
            var _text_w = string_width(_choices[i]) * 0.8;
            draw_sprite_ext(spr_heart, 0, _choice_x - (_text_w / 2) - 25, _choice_y - 8, 1, 1, 0, c_white, _global_alpha);
        }
        else
        {
            draw_set_color(_text_color);
        }
        
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text_transformed(_choice_x, _choice_y, _choices[i], 0.8, 0.8, 0);
    }
    
    draw_set_color(c_gray);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text_transformed(_gui_width / 2, _gui_height - 20, "[SETAS] Selecionar | [Enter] Confirmar", 0.6, 0.6, 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

if (_current_state == "DOWNLOADING")
{
    draw_set_color(_text_color);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(_gui_width / 2, _gui_height / 2, "Baixando arquivos...\nNão feche o jogo.", 0.8, 0.8, 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

if (_current_state == "COMPLETE" && !_show_ui && !_is_checking && !_was_ignored)
{
    draw_set_color(_text_color);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    if (_json_matches)
        draw_text_transformed(_gui_width / 2, _gui_height / 2, "Arquivos estão sincronizados.", 0.8, 0.8, 0);
    else
        draw_text_transformed(_gui_width / 2, _gui_height / 2, "Download concluído!", 0.8, 0.8, 0);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

if (_current_state == "ERROR")
{
    draw_set_color(c_red);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text_ext(_gui_width / 2, _box_y, "ERRO:#" + _error_message, -1, _gui_width - 40);
    draw_set_color(c_gray);
    draw_set_valign(fa_bottom);
    draw_text(_gui_width / 2, _gui_height - 20, "[Enter] Fechar");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

draw_set_alpha(1);
draw_set_color(c_white);
