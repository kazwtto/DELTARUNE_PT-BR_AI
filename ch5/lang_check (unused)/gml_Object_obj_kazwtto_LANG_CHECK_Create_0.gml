_http_request = -1;
_json_url = "https://raw.githubusercontent.com/kazwtto/DELTARUNE_PT-BR_AI/refs/heads/main/ch5/langs/lang_en.json";
_json_local_path = working_directory + "lang/lang_en.json";
_local_json_string = "";
_remote_json_string = "";
_json_matches = false;
_download_in_progress = false;
_current_state = "IDLE";
_choice_selected = 0;
_choice_count = 2;
_ui_alpha = 0;
_fade_in_speed = 0.05;
_show_ui = false;
_error_message = "";
_is_checking = false;
_was_ignored = false;
global.lang_checked = false;

init = function()
{
    _current_state = "CHECKING";
    _is_checking = true;
    _local_json_string = "";
    _remote_json_string = "";
    
    if (file_exists(_json_local_path))
    {
        var _buff = buffer_load(_json_local_path);
        var _read = buffer_read(_buff, buffer_string);
        buffer_delete(_buff);
        _local_json_string = _read;
    }
    
    _http_request = http_get(_json_url);
};

compare_jsons = function()
{
    _json_matches = _remote_json_string == _local_json_string;
    return _json_matches;
};

save_json = function()
{
    var _buff = buffer_create(string_byte_length(_remote_json_string) + 1, buffer_grow, 1);
    buffer_write(_buff, buffer_string, _remote_json_string);
    var _result = buffer_save(_buff, _json_local_path);
    
    if (_result < 0)
    {
        _error_message = "Falha ao salvar: " + _json_local_path;
        return false;
    }
    
    scr_84_lang_load();
    return true;
};

show_choice_ui = function()
{
    _show_ui = true;
    _choice_selected = 0;
    _ui_alpha = 0;
};

process_choice = function(arg0)
{
    if (arg0 == 0)
    {
        _download_in_progress = true;
        
        if (save_json())
            _target_state = "COMPLETE";
        else
            _target_state = "ERROR";
        
        _download_in_progress = false;
    }
    else
    {
        _was_ignored = true;
        _current_state = "COMPLETE";
        _target_state = "";
    }
    
    _show_ui = false;
};

cleanup = function()
{
    instance_destroy();
};
