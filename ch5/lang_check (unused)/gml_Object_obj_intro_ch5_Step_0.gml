if (_current_state == "LANG_CHECK")
{
    if (!global.lang_checked)
    {
        if (_lang_checker._current_state == "COMPLETE" || _lang_checker._current_state == "ERROR")
        {
            instance_destroy(_lang_checker);
            global.lang_checked = true;
            _lang_checker = -4;
        }
        else
        {
            exit;
        }
    }
}

if (bgm != -1)
    bgmPos = audio_sound_get_track_position(bgm);

if (scr_debug() && keyboard_check_pressed(ord("R")))
{
    sound_stop_all();
    room_restart();
}

skip_safety++;

if (button1_p() && !skipped && skip_safety > 6)
{
    scr_lerp_instance_var(black_all, "image_alpha", black_all.image_alpha, 1, skip_time);
    mus_fade(global.currentsong[1], skip_time);
    skipped = true;
    alarm[0] = skip_time + 5;
}

if (con == 0)
{
    timeDel = 0.65;
    timeTa = 1.3;
    timeRune = 2;
    timeDelF = ceil(timeDel * 30);
    timeTaF = ceil(timeTa * 30) - timeDelF;
    timeRuneF = ceil(timeRune * 30) - timeDelF - timeTaF;
    con = 1;
    bgm = mus_play(snd_init("deltarune_logo_ch5_itoki.ogg"));
    scr_lerp_instance_var(logoDel, "image_alpha", 0, 1, timeDelF div 3, 2, "out");
}

if (con == 1)
{
    if (bgmPos >= timeDel)
    {
        con = 2;
        logoDel.sparkling = false;
        scr_lerp_instance_var(logoTa, "image_alpha", 0, 1, timeTaF div 3, 2, "out");
    }
}

if (con == 2)
{
    if (bgmPos >= timeTa)
    {
        logoTa.sparkling = false;
        con = 3;
        scr_lerp_instance_var(logoRune, "image_alpha", 0, 1, timeRuneF div 3, 2, "out");
    }
}

if (con == 3)
{
    if (bgmPos >= timeRune)
    {
        logoRune.sparkling = false;
        con = 4;
        scr_lerp_instance_var(logoDel, "image_alpha", 1, 0, 25, 2, "out");
        scr_lerp_instance_var(logoTa, "image_alpha", 1, 0, 25, 2, "out");
        scr_lerp_instance_var(logoHeart, "image_alpha", 0, 1, 25, 2, "out");
        scr_lerp_instance_var(logoRune, "image_alpha", 1, 0, 25, 2, "out");
        scr_lerp_instance_var(logoAll, "timerPace", 0.035, 0, 120, 2, "out");
        
        for (var i = 0; i < array_length(bigSparkles); i++)
            scr_lerp_instance_var(bigSparkles[i], "main_alpha", 0, 0.7, 25, 2, "out");
        
        logoAll.image_alpha = 1;
    }
}

if (con == 4)
{
    if (timer++ >= 120)
    {
        scr_lerp_instance_var(black_all, "image_alpha", 0, 1, 90, 2, "out");
        timer = 0;
        con = 10;
    }
}

if (con == 10)
{
    if (timer++ >= 100)
    {
        timer = 0;
        con = 99;
    }
}

if (con == 99)
{
    room_goto(PLACE_MENU);
    con = 999;
}
