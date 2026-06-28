if (ds_map_find_value(async_load, "id") == _http_request)
{
    var _status = ds_map_find_value(async_load, "status");
    
    if (_status == 0)
    {
        _remote_json_string = ds_map_find_value(async_load, "result");
        
        if (compare_jsons())
        {
            _target_state = "COMPLETE";
            _is_checking = false;
        }
        else
        {
            _target_state = "ASKING";
            show_choice_ui();
            _is_checking = false;
        }
    }
    else if (_status < 0)
    {
        _target_state = "COMPLETE";
        _is_checking = false;
    }
}
