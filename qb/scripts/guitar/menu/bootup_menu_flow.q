respond_to_signin_changed = 0
bootup_sequence_fs = {
	create = start_bootup_sequence
	destroy = end_bootup_sequence
	actions = [
		{
			action = skip_bootup_sequence
			flow_state_func = skipped_bootup_sequence
		}
	]
}

script bootup_press_any_button 
	Wait \{2
		seconds}
	return \{flow_state = bootup_press_any_button_fs}
endscript

script skipped_bootup_sequence 
	if IsNgc
		wii_memcard_load \{boot = 1}
		return flow_state = <flow_state>
	else
		return \{flow_state = ps2_memcard_autosave_warning_boot_fs}
	endif
endscript
strap_screen_fs = {
	create = create_strap_screen
	destroy = destroy_strap_screen
	actions = [
		{
			action = continue
			flow_state = ps2_memcard_load_boot_fs
		}
	]
}
bootup_press_any_button_fs = {
	create = create_press_any_button_menu
	destroy = destroy_press_any_button_menu
	actions = [
		{
			action = enter_attract_mode
			flow_state = bootup_attract_mode_fs
		}
		{
			action = continue
			flow_state_func = bootup_check_for_sign_in
		}
	]
}
bootup_attract_mode_fs = {
	create = create_attract_mode
	destroy = destroy_attract_mode
	actions = [
		{
			action = exit_attract_mode
			flow_state = bootup_press_any_button_fs
		}
	]
}
legal_timer = 0

script start_legal_timer 
	change \{legal_timer = 0}
	Wait \{6
		seconds}
	change \{legal_timer = 1}
endscript

script wait_for_legal_timer 
	if NotCD
		if ($show_movies = 0)
			return
		endif
	endif
	begin
	if ($legal_timer = 1)
		break
	endif
	WaitOneGameFrame
	repeat
endscript

script bootup_sequence 
	pre_movie_cleanup
	if NOT IsNgc
		wait_for_legal_timer
	endif
	startrendering
	Hideloadingscreen
	PlayMovieAndWait \{movie = 'atvi'}
	if NOT WasMovieAborted
		PlayMovieAndWait \{movie = 'ro_logo'}
	endif
	if NOT WasMovieAborted
		PlayMovieAndWait \{movie = 'ns_logo'}
	endif
	if IsNgc
		if NOT WasMovieAborted
			PlayMovieAndWait \{movie = 'vvisions'}
		endif
	endif
	if NOT WasMovieAborted
		PlayMovieAndWait \{movie = 'budcat'}
	endif
	PlayMovieAndWait \{movie = 'intro'}
	MoviePlayerAllowController2
	post_movie_reset reset_state = <reset_state>
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = skip_bootup_sequence
			play_sound = 0
		}}
endscript

script play_all_movies 
	PlayMovieAndWait \{movie = 'singleplayer_01'}
	PlayMovieAndWait \{movie = 'singleplayer_02'}
	PlayMovieAndWait \{movie = 'singleplayer_03'}
	PlayMovieAndWait \{movie = 'singleplayer_04'}
	PlayMovieAndWait \{movie = 'singleplayer_05'}
	PlayMovieAndWait \{movie = 'singleplayer_06'}
	PlayMovieAndWait \{movie = 'singleplayer_07'}
	PlayMovieAndWait \{movie = 'singleplayer_08'}
	PlayMovieAndWait \{movie = 'singleplayer_end'}
	PlayMovieAndWait \{movie = 'coop_01'}
	PlayMovieAndWait \{movie = 'coop_02'}
	PlayMovieAndWait \{movie = 'coop_03'}
	PlayMovieAndWait \{movie = 'coop_04'}
	PlayMovieAndWait \{movie = 'coop_05'}
	PlayMovieAndWait \{movie = 'coop_06'}
	PlayMovieAndWait \{movie = 'sexpistols'}
	PlayMovieAndWait \{movie = 'brettmichaels'}
	PlayMovieAndWait \{movie = 'slash'}
	PlayMovieAndWait \{movie = 'tommorello'}
endscript

script start_bootup_sequence 
	if NotCD
		if ($show_movies = 0)
			startrendering
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = skip_bootup_sequence
					play_sound = 0
				}}
			return
		endif
	endif
	spawnscriptnow \{bootup_sequence}
endscript

script end_bootup_sequence 
endscript

script check_signin_change_monitor_flag 
	if ($respond_to_signin_changed = 0)
		ScriptAssert \{'check_signin_change_monitor_flag failed'}
	endif
endscript

script start_checking_for_signin_change 

	printscriptinfo \{'start_checking_for_signin_change'}

	KillSpawnedScript \{name = sysnotify_handle_signin_change}

	change \{respond_to_signin_changed = 1}
	change \{menu_select_difficulty_first_time = 1}
endscript

script bootup_check_for_sign_in 
	KillSpawnedScript \{name = attract_mode_spawner}
	change \{enable_saving = 1}
	if GotParam \{device_num}
		change primary_controller = <device_num>
		change \{primary_controller_assigned = 1}
		change structurename = player1_status controller = ($primary_controller)
	endif
	return \{flow_state = main_menu_fs}
	if NOT CheckForSignIn local controller_index = <device_num>
		if isXenon
			NetSessionFunc \{func = showsigninui}
		else
			change \{ps3_signin_complete = 0}
			xenon_singleplayer_session_init \{ps3_signin_callback = signin_complete_callback}
		endif
		wait_for_blade_complete
		if NOT CheckForSignIn \{local}
			return \{flow_state = bootup_signin_warning_fs}
		endif
	endif
	if CheckForSignIn
		NetSessionFunc \{func = stats_uninit}
		NetSessionFunc \{func = stats_init}
		NetSessionFunc \{func = motd_uninit}
		NetSessionFunc \{func = motd_init}
		NetSessionFunc \{func = get_demonware_splash
			obj = motd
			params = {
				callback = splash_callback
			}}
		NetSessionFunc \{func = GetBeatADevList}
	endif
	if isXenon
		process_signin_complete
		return flow_state = <flow_state>
	else
		return \{flow_state = bootup_signin_complete_message}
	endif
endscript

script process_signin_complete 
	RefreshSigninStatus
	if isXenon
		StartGameProfileSettingsRead
		begin
		if GameProfileSettingsFinished
			break
		endif
		repeat
	endif
	start_checking_for_signin_change
	return \{flow_state = bootup_do_memcard_sequence_fs}
endscript
ps3_signin_complete = 0

script wait_for_blade_complete 
	if isXenon
		wait_for_sysnotify_unpause
	else
		begin
		if (1 = $ps3_signin_complete)
			break
		endif
		Wait \{1
			frame}
		repeat
	endif
endscript

script signin_complete_callback 
	change \{ps3_signin_complete = 1}
endscript
bootup_signin_warning_fs = {
	create = create_signin_warning_menu
	destroy = destroy_signin_warning_menu
	actions = [
		{
			action = select_continue_without_saving
			flow_state_func = choose_proper_using_guitar_screen
		}
		{
			action = select_choose_storage_device
			flow_state_func = bootup_check_for_sign_in
		}
		{
			action = select_continue_without_signing_in
			flow_state = bootup_signin_complete_message
		}
		{
			action = corrupted_data
			flow_state = bootup_corrupted_data
		}
	]
}
bootup_do_memcard_sequence_fs = {
	create = memcard_sequence_begin_bootup
	destroy = memcard_sequence_cleanup_generic
	actions = [
		{
			action = memcard_sequence_save_success
			flow_state_func = choose_proper_using_guitar_screen
		}
		{
			action = memcard_sequence_save_failed
			flow_state_func = choose_proper_using_guitar_screen
		}
		{
			action = memcard_sequence_load_success
			flow_state = choose_proper_using_guitar_screen
		}
		{
			action = memcard_sequence_load_failed
			flow_state_func = choose_proper_using_guitar_screen
		}
	]
}

script choose_proper_using_guitar_screen 
	if IsNgc
		return \{flow_state = bootup_using_guitar_controller_wii_fs}
	else
		return \{flow_state = bootup_using_guitar_controller_fs}
	endif
endscript
bootup_using_guitar_controller_wii_fs = {
	create = create_using_guitar_controller_wii_menu
	destroy = destroy_using_guitar_controller_wii_menu
	actions = [
		{
			action = continue
			flow_state = bootup_press_any_button_fs
		}
	]
}
bootup_using_guitar_controller_fs = {
	create = create_using_guitar_controller_menu
	destroy = destroy_using_guitar_controller_menu
	actions = [
		{
			action = continue
			flow_state = bootup_press_any_button_fs
		}
	]
}
bootup_download_scan_fs = {
	create = create_download_scan_menu
	destroy = destroy_download_scan_menu
	actions = [
		{
			action = continue
			flow_state = main_menu_fs
		}
	]
}
bootup_signin_complete_message = {
	create = create_signin_complete_menu
	destroy = destroy_signin_complete_menu
	actions = [
		{
			action = continue
			flow_state_func = process_signin_complete
		}
	]
}
is_shutdown_safe = 1

script mark_unsafe_for_shutdown 
	change \{is_shutdown_safe = 0}
endscript

script mark_safe_for_shutdown 
	change \{is_shutdown_safe = 1}
	unpausespawnedscript \{wait_for_safe_shutdown}
endscript

script wait_for_safe_shutdown 
	begin
	if ($is_shutdown_safe = 1)
		break
	endif
	WaitOneGameFrame
	repeat
endscript

script handle_signin_changed 

	change \{respond_to_signin_changed = 0}
	wait_for_safe_shutdown

	disable_pause
	stoprendering
	shutdown_game_for_signin_change \{signin_change = 1}
	LaunchEvent \{type = unfocus
		target = root_window}
	create_signin_changed_menu
	startrendering

endscript

script signing_change_confirm_reboot 

	destroy_signin_changed_menu
	enable_pause
	Wait \{5
		gameframes}
	start_flow_manager \{flow_state = bootup_press_any_button_fs}

endscript
shutdown_game_for_signin_change_flag = 0

script shutdown_game_for_signin_change \{unloadcontent = 1
		signin_change = 0}

	change \{shutdown_game_for_signin_change_flag = 1}
	StopAllSounds
	KillSpawnedScript \{name = online_menu_init}
	KillSpawnedScript \{name = host_handle_dropped_client}
	set_demonware_failed
	shutdown_options_video_monitor
	destroy_alert_popup \{force = 1}
	end_practice_song_slomo
	if ScreenElementExists \{id = loading_screen_container}
		destroy_loading_screen
	endif
	memcard_sequence_cleanup_generic
	destroy_leaving_lobby_dialog
	menu_store_go_back
	shut_down_character_hub
	tutorial_shutdown
	shut_down_flow_manager \{player = 1}
	shut_down_flow_manager \{player = 2}
	store_monitor_goal_guitar_finish
	DeRegisterAtoms
	quit_network_game_early \{signin_change}
	kill_gem_scroller \{no_render = 1}
	progression_push_current \{force = 1}
	clean_up_user_control_helpers
	Menu_Music_Off \{setflag = 1}
	unload_songqpak
	SetPakManCurrentBlock \{map = zones
		pak = none
		block_scripts = 1}
	destroy_band \{unload_paks}
	destroy_downloads_EnumContent
	if (<unloadcontent> = 1)
		Downloads_UnloadContent
		ClearGlobalTags
		setup_globaltags
	endif
	if (<signin_change> = 1)
		clear_cheats
	endif
	if ScreenElementExists \{id = ready_container_p2}
		DestroyScreenElement \{id = ready_container_p2}
	endif
	set_default_misc_globals
	cleanup_songwon_event
	destroy_menu_transition
	UnPauseGame
	change \{shutdown_game_for_signin_change_flag = 0}

endscript

script cleanup_songwon_event 
	destroy_menu \{menu_id = yourock_text}
	destroy_menu \{menu_id = yourock_text_2}
	destroy_menu \{menu_id = yourock_text_legend}
	KillSpawnedScript \{name = jiggle_text_array_elements}
	KillSpawnedScript \{name = You_Rock_Waiting_Crowd_SFX}
	KillSpawnedScript \{name = GuitarEvent_SongWon_Spawned}
endscript

script set_default_misc_globals 
	change \{show_boss_helper_screen = 0}
	change \{use_last_player_scores = 0}
	change \{old_song = none}
	change \{devil_finish = 0}
	change \{battle_sudden_death = 0}
	change \{menu_flow_locked = 0}
endscript
