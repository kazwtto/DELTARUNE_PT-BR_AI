switch (_current_state)
{
    case "ASKING":
        if (_ui_alpha < 1)
            _ui_alpha = lerp(_ui_alpha, 1, 0.1);
        
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_up))
        {
            var _prev = _choice_selected;
            _choice_selected = max(_choice_selected - 1, 0);
            
            if (_prev != _choice_selected)
                audio_play_sound(snd_menumove, 50, 0);
        }
        
        if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_down))
        {
            var _prev = _choice_selected;
            _choice_selected = min(_choice_selected + 1, _choice_count - 1);
            
            if (_prev != _choice_selected)
                audio_play_sound(snd_menumove, 50, 0);
        }
        
        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z")))
        {
            audio_play_sound(snd_select, 50, 0);
            process_choice(_choice_selected);
        }
        
        break;
    
    case "IDLE":
        break;
    
    case "CHECKING":
        break;
    
    case "DOWNLOADING":
        break;
    
    case "COMPLETE":
        break;
    
    case "ERROR":
        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space))
            cleanup();
        
        break;
}
