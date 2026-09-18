
script open_dwc_error_dialog 
	if (<dwc_error_code> > 0)
		FormatText TextName = error_msg '%d: %s' d = (<dwc_error_code>) s = (<dwc_error_text>)
	else
		FormatText TextName = error_msg '%s' s = (<dwc_error_text>)
	endif
	destroy_generic_popup
	use_long_text_hack = 0
	if German
		if (<potential_long_text> = 1)
			<use_long_text_hack> = 1
		endif
	elseif Spanish
		if (<potential_long_text> = 1)
			<use_long_text_hack> = 1
		endif
	elseif Italian
		if (<potential_long_text> = 1)
			<use_long_text_hack> = 1
		endif
	endif
	if (<use_long_text_hack> = 1)
		create_generic_popup {
			previous_menu = current_menu
			title = $wii_error
			long_text
			ok_menu
			message = <error_msg>
			ok_eventhandlers = [
				{focus popup_menu_focus}
				{unfocus popup_menu_unfocus}
				{pad_choose destroy_and_allow_home_menu}
			]
		}
	else
		create_generic_popup {
			previous_menu = current_menu
			title = $wii_error
			ok_menu
			message = <error_msg>
			ok_eventhandlers = [
				{focus popup_menu_focus}
				{unfocus popup_menu_unfocus}
				{pad_choose destroy_and_allow_home_menu}
			]
		}
	endif
endscript

script destroy_and_allow_home_menu 
	set_home_button_allowed
	destroy_generic_popup
endscript
kickingToMain = 0

script open_fatal_dwc_error_dialog 
	clear_network_wait_variable
	destroy_generic_popup
	change \{kickingToMain = 1}
	wii_handle_connection_loss
	open_dwc_error_dialog {
		dwc_error_code = <dwc_error_code>
		dwc_error_text = <dwc_error_text>
	}
endscript

script open_non_fatal_dwc_error_dialog 
	clear_network_wait_variable
	destroy_generic_popup
	ok_after_reject
	open_dwc_error_dialog {
		dwc_error_code = <dwc_error_code>
		dwc_error_text = <dwc_error_text>
	}
endscript

script close_dwc_error_dialog 
	destroy_generic_popup
	set_home_button_allowed
	if (<go_to_main_menu> = 1)
		wii_handle_connection_loss
	endif
endscript

script wii_handle_connection_loss 
	sysnotify_wait_until_safe
	cleanup_sessionfuncs
	if ($is_network_game)
		stoprendering
		shutdown_game_for_signin_change \{unloadcontent = 0}
		startrendering
	endif
	CancelEnterWifiMenu
	printf \{'shut_down_flow_manager'}
	enable_pause
	Wait \{5
		gameframes}
	printf \{'start_flow_manager flow_state=main_menu_fs'}
	start_flow_manager \{flow_state = main_menu_fs}
	LaunchEvent \{type = focus
		target = vmenu_main_menu}
	change \{kickingToMain = 0}
endscript

script 0x4758375f 
	printf \{'wii_shutdown_game_for_signin_change'}
	StopAllSounds
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
	UnPauseGame
	printf \{'wii_shutdown_game_for_signin_change end'}
endscript

script failed_connect_to_internet 
	printf \{'--- failed_connect_to_internet'}
	destroy_generic_popup
	create_generic_popup \{title = $wii_error
		ok_menu
		message = $wii_failed_connect
		ok_eventhandlers = [
			{
				focus
				popup_menu_focus
			}
			{
				unfocus
				popup_menu_unfocus
			}
			{
				pad_choose
				destroy_and_allow_home_menu
			}
		]
		previous_menu = vmenu_main_menu}
endscript

script no_profiles_dialog 
	printf '--- no_profiles_dialog nosave = %d' a = ($wii_nosave_onboot)
	if ($wii_nosave_onboot = 1)
		destroy_generic_popup
		create_generic_popup \{title = $wii_no_prof_title
			ok_menu
			message = $wii_no_prof
			ok_eventhandlers = [
				{
					focus
					popup_menu_focus
				}
				{
					unfocus
					popup_menu_unfocus
				}
				{
					pad_choose
					destroy_generic_popup
				}
			]
			previous_menu = vmenu_main_menu}
	endif
endscript

script login_successful 
	destroy_generic_popup
	create_generic_popup \{title = $wii_login
		ok_menu
		message = $wii_connected
		ok_eventhandlers = [
			{
				focus
				popup_menu_focus
			}
			{
				unfocus
				popup_menu_unfocus
			}
			{
				pad_choose
				destroy_generic_popup
			}
		]
		previous_menu = vmenu_main_menu}
endscript

script login_failed 
endscript

script online_log_out 
	LogOut
endscript

script approve_name_dialog 
	enable_network_wait_variable
	destroy_generic_popup
	create_generic_popup \{title = $wii_approving_title
		loading_window
		message = $wii_approving1
		ok_eventhandlers = [
			{
				focus
				popup_menu_focus
			}
			{
				unfocus
				popup_menu_unfocus
			}
		]
		wait_variable = network_wait_var
		previous_menu = ebn_marker}
endscript

script destroy_name_dialog_early 
	KillSpawnedScript \{name = start_loading_process}
	destroy_generic_popup
endscript
leaderboard_refresh = 0

script exit_leaderboard 
	if NetSessionFunc \{obj = stats
			func = cancel_leaderboards}
		destroy_generic_popup
		clean_up_user_control_helpers
		ui_flow_manager_respond_to_action \{action = go_back}
		clear_network_wait_variable
	endif
endscript

script leaderboard_failed 
	destroy_generic_popup
	clear_network_wait_variable
	clean_up_user_control_helpers
	create_generic_popup \{title = $wii_error
		ok_menu
		message = $wii_server_timeout
		ok_eventhandlers = [
			{
				focus
				popup_menu_focus
			}
			{
				unfocus
				popup_menu_unfocus
			}
			{
				pad_choose
				leaderboard_failed_ok
			}
		]}
endscript

script leaderboard_failed_ok 
	destroy_generic_popup
	ui_flow_manager_respond_to_action \{action = go_back}
endscript

script leaderboard_request_dialog 
	change \{leaderboard_refresh = 0}
	destroy_generic_popup
	create_generic_popup \{title = $wii_lb_title
		loading_window
		can_cancel
		message = $wii_lb_waiting
		wait_variable = leaderboard_refresh
		cancel_eventhandlers = [
			{
				focus
				popup_menu_focus
			}
			{
				unfocus
				popup_menu_unfocus
			}
			{
				pad_choose
				exit_leaderboard
			}
		]
		previous_menu = online_leaderboard_vmenu}
endscript

script open_name_approval_timeout_dialog 
	destroy_name_dialog_early
	create_generic_popup \{title = $wii_approval_timeout_title
		ok_menu
		message = $wii_server_unavailable
		previous_menu = ebn_marker
		ok_eventhandlers = [
			{
				focus
				popup_menu_focus
			}
			{
				unfocus
				popup_menu_unfocus
			}
			{
				pad_choose
				destroy_and_allow_home_menu
			}
		]}
endscript
wifi_done_connecting = 0

script wifi_connect_done 
	change \{wifi_done_connecting = 1}
	destroy_generic_popup
endscript

script cancel_wifi_connect 
	set_home_button_allowed
	change \{wifi_done_connecting = 1}
	CancelConnectToWifi
endscript

script open_connect_to_wifi_dialog 
	destroy_generic_popup
	change \{wifi_done_connecting = 0}
	set_home_button_notallowed
	create_generic_popup \{title = $wii_login
		loading_window
		message = $wii_connecting
		wait_variable = wifi_done_connecting
		previous_menu = current_menu}
endscript
