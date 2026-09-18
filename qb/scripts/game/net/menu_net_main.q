info_text = [
	$wii_net_info1
	$wii_net_info2
	$wii_net_info3
	$wii_net_info4
	$wii_net_info5
	$wii_net_info6
	$wii_net_info7
	$wii_net_info8
	$wii_net_info9
	$wii_net_info10
]
online_main_menu_pos = (470.0, 110.0)
online_info_pane_pos = (890.0, 150.0)
agora_motd = 'Message of the Day'

script set_motd \{motd = 'Message of the Day'}
	if GotParam \{motd}
		change \{retrieved_message_of_the_day = 1}
		change message_of_the_day = <motd>
		if ScreenElementExists \{id = motd_ticker_text_block}
			motd_ticker_text_block :SetProps text = ($message_of_the_day)
			spawnscriptnow \{scroll_motd_ticker
				params = {
					id = motd_ticker_text_block
				}}
		endif
	endif
endscript

script create_online_main_menu \{menu_title_xenon = 'Xbox LIVE Main Menu'
		menu_title_ps3 = 'Online Main Menu'
		menu_id = online_main_menu
		vmenu_id = online_main_vmenu}
	set_home_button_notallowed
	online_menu_init
	change \{select_diff_to_char_render_stall = 1}
	change \{rich_presence_context = presence_main_menu}
	spawnscriptnow \{menu_music_on
		params = {
			setflag = 1
		}}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = main_menu_anchor
		pos = (0.0, 0.0)}
	change \{choose_specific_friend = 0}
	CreateScreenElement {
		type = VScrollingMenu
		parent = main_menu_anchor
		id = <menu_id>
		just = [center top]
		dims = (400.0, 480.0)
		pos = (($online_main_menu_pos) + (0.0, 85.0))
		z_priority = 1
	}
	CreateScreenElement {
		type = VMenu
		parent = <menu_id>
		id = <vmenu_id>
		pos = (47.5, 0.0)
		just = [left top]
		internal_just = [center top]
		dims = (400.0, 480.0)
		event_handlers = [
			{pad_back return_from_online_main_menu}
			{pad_back generic_menu_pad_back}
			{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
		]
		dont_allow_wrap
		exclusive_device = ($primary_controller)
	}
	CreateScreenElement \{type = ContainerElement
		parent = main_menu_anchor
		id = online_main_menu_container
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = ContainerElement
		parent = online_main_menu_container
		id = online_main_menu_text_container
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = ContainerElement
		parent = main_menu_anchor
		id = online_info_pane_container
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = ContainerElement
		parent = online_info_pane_container
		id = online_info_pane_text_container
		pos = (0.0, 0.0)}
	create_menu_backdrop \{texture = Online_Background}
	displaySprite id = online_frame parent = online_main_menu_container tex = Online_Frame_Large pos = ($online_main_menu_pos) dims = (660.0, 480.0) just = [center top] z = 2
	displaySprite id = online_frame_crown parent = online_main_menu_container tex = online_frame_crown pos = (($online_main_menu_pos) + (0.0, -62.0)) dims = (256.0, 105.0) just = [center top] z = 3
	displaySprite id = motd_top parent = online_info_pane_container tex = window_frame_cap rgba = ($online_medium_blue) pos = ($online_info_pane_pos) dims = (320.0, 64.0) just = [center top] z = 5
	displaySprite id = motd_top_fill parent = online_info_pane_container tex = window_fill_cap rgba = [0 0 0 200] pos = ($online_info_pane_pos) dims = (320.0, 64.0) just = [center top] z = 5
	displaySprite id = motd_body parent = online_info_pane_container tex = window_frame_body_tall rgba = ($online_medium_blue) pos = (($online_info_pane_pos) + (0.0, 64.0)) dims = (320.0, 256.0) just = [center top] z = 5 flip_h
	displaySprite id = motd_body_fill parent = online_info_pane_container tex = window_fill_body_large rgba = [0 0 0 200] pos = (($online_info_pane_pos) + (0.0, 64.0)) dims = (320.0, 256.0) just = [center top] z = 5 flip_h
	displaySprite id = motd_end parent = online_info_pane_container tex = window_frame_cap rgba = ($online_medium_blue) pos = (($online_info_pane_pos) + (0.0, 320.0)) dims = (320.0, 64.0) just = [center top] z = 5 flip_h
	displaySprite id = motd_end_fill parent = online_info_pane_container tex = window_fill_cap rgba = [0 0 0 200] pos = (($online_info_pane_pos) + (0.0, 320.0)) dims = (320.0, 64.0) just = [center top] z = 5 flip_h
	displaySprite id = info_divide parent = online_info_pane_text_container tex = store_frame_bottom_bg rgba = ($online_light_blue) pos = (($online_info_pane_pos) + (-5.0, 240.0)) dims = (320.0, 56.0) just = [center center] z = 6
	if isXenon
		CreateScreenElement {
			type = TextElement
			parent = online_main_menu_text_container
			id = online_title
			font = fontgrid_title_gh3
			scale = 0.85
			rgba = ($online_dark_purple)
			pos = (($online_main_menu_pos) + (0.0, 35.0))
			text = <menu_title_xenon>
			just = [center top]
			z_priority = 4.0
		}
	else
		CreateScreenElement {
			type = TextElement
			parent = online_main_menu_text_container
			id = online_title
			font = fontgrid_title_gh3
			scale = 0.85
			rgba = ($online_dark_purple)
			pos = (($online_main_menu_pos) + (0.0, 35.0))
			text = <menu_title_ps3>
			just = [center top]
			z_priority = 4.0
		}
	endif
	GetScreenElementDims id = <id>
	if (<width> > 420)
		SetScreenElementProps {
			id = <id>
			scale = 1.0
		}
		scale_element_to_size {
			id = <id>
			target_width = 420
			target_height = <Height>
		}
	endif
	if isXenon
		net_add_item_to_main_menu {
			VMenu = <vmenu_id>
			text = 'Quick Match: Player Match'
			info_text_index = 0
			pad_choose_script = online_menu_select_quickmatch_player
		}
		net_add_item_to_main_menu {
			VMenu = <vmenu_id>
			text = 'Quick Match: Ranked Match'
			info_text_index = 1
			pad_choose_script = online_menu_select_quickmatch_ranked
		}
	else
		net_add_item_to_main_menu {
			VMenu = <vmenu_id>
			text = $wii_auto_match_text
			info_text_index = 0
			pad_choose_script = online_menu_select_join_friend
		}
	endif
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = $wii_strangers_match
		info_text_index = 1
		pad_choose_script = online_menu_select_custom_match
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = 'Create Match'
		info_text_index = 2
		pad_choose_script = online_menu_select_create_match
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = 'Leaderboards'
		info_text_index = 4
		pad_choose_script = ui_flow_manager_respond_to_action
		choose_script_params = {action = select_leaderboards}
	}
	if isXenon
		net_add_item_to_main_menu {
			VMenu = <vmenu_id>
			text = 'Downloadable Content'
			info_text_index = 6
			pad_choose_script = online_select_downloads
			pad_choose_script2 = SoundEvent
			choose_script_params2 = {event = ui_sfx_select}
		}
	endif
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = 'www.guitarhero.com'
		info_text_index = 6
		pad_choose_script = online_menu_select_website
		pad_choose_script2 = SoundEvent
		choose_script_params2 = {event = ui_sfx_select}
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = 'Message Of The Day'
		info_text_index = 7
		pad_choose_script = online_menu_select_motd
		pad_choose_script2 = SoundEvent
		choose_script_params2 = {event = ui_sfx_select}
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = $wii_show_friends_list
		info_text_index = 8
		pad_choose_script = launch_friends_list
		pad_choose_script2 = SoundEvent
		choose_script_params2 = {event = ui_sfx_select}
	}
	net_add_item_to_main_menu {
		VMenu = <vmenu_id>
		text = $wii_sign_out
		info_text_index = 9
		pad_choose_script = online_menu_select_log_out
		pad_choose_script2 = SoundEvent
		choose_script_params2 = {event = ui_sfx_select}
	}
	displaySprite id = profile_display_top parent = online_info_pane_text_container tex = window_frame_cap rgba = ($online_medium_blue) pos = (($online_info_pane_pos) + (0.0, 400.0)) dims = (360.0, 25.0) just = [center top] z = 5
	displaySprite id = profile_display_top_fill parent = online_info_pane_text_container tex = window_fill_cap rgba = [0 0 0 200] pos = (($online_info_pane_pos) + (0.0, 400.0)) dims = (360.0, 25.0) just = [center top] z = 5
	displaySprite id = profile_display_body parent = online_info_pane_text_container tex = window_frame_body_tall rgba = ($online_medium_blue) pos = (($online_info_pane_pos) + (0.0, 425.0)) dims = (360.0, 25.0) just = [center top] z = 5 flip_h
	displaySprite id = profile_display_body_fill parent = online_info_pane_text_container tex = window_fill_body_large rgba = [0 0 0 200] pos = (($online_info_pane_pos) + (0.0, 425.0)) dims = (360.0, 25.0) just = [center top] z = 5 flip_h
	displaySprite id = profile_display_end parent = online_info_pane_text_container tex = window_frame_cap rgba = ($online_medium_blue) pos = (($online_info_pane_pos) + (0.0, 450.0)) dims = (360.0, 25.0) just = [center top] z = 5 flip_h
	displaySprite id = profile_display_end_fill parent = online_info_pane_text_container tex = window_fill_cap rgba = [0 0 0 200] pos = (($online_info_pane_pos) + (0.0, 450.0)) dims = (360.0, 25.0) just = [center top] z = 5 flip_h
	GetActiveProfileName
	CreateScreenElement {
		type = TextElement
		parent = online_info_pane_text_container
		id = profile_display
		font = text_a4
		text = <profile_name>
		scale = 0.6
		rgba = ($online_light_blue)
		pos = (($online_info_pane_pos) + (0.0, 425.0))
		just = [center top]
		z_priority = 6.0
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = online_info_pane_text_container
		id = help_info_text_block
		font = text_a4
		scale = (0.75, 0.65000004)
		rgba = ($online_light_blue)
		text = ($info_text [0])
		just = [center top]
		internal_just = [center top]
		z_priority = 6.0
		pos = (($online_info_pane_pos) + (-4.0, 20.0))
		dims = (320.0, 370.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = online_info_pane_text_container
		id = motd_info_pane_title
		font = text_a4
		text = 'Message of the Day'
		scale = 0.65000004
		rgba = ($online_light_blue)
		pos = (($online_info_pane_pos) + (0.0, 264.0))
		just = [center top]
		z_priority = 6.0
	}
	CreateScreenElement {
		type = WindowElement
		parent = online_info_pane_text_container
		id = motd_ticker_window
		pos = (($online_info_pane_pos) + (0.0, 312.0))
		dims = (248.0, 32.0)
		just = [center top]
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = motd_ticker_window
		id = motd_ticker_text_block
		just = [left top]
		internal_just = [left top]
		pos = (0.0, 0.0)
		scale = (0.75, 0.55)
		text = ''
		font = text_a4
		rgba = ($online_light_blue)
		z_priority = 100
		dims = (670.0, 1500.0)
		line_spacing = 1.0
	}
	spawnscriptnow \{get_motd_and_start_ticker}
	set_focus_color rgba = ($online_dark_purple)
	set_unfocus_color rgba = ($online_light_blue)
	create_online_main_menu_helper_buttons
	LaunchEvent type = focus target = <vmenu_id>
endscript

script launch_friends_list 
	enable_network_wait_variable
	UpdateFriendsList
	create_generic_popup \{loading_window
		message = $wii_loading_friends_list
		wait_variable = network_wait_var
		z = 200
		previous_menu = online_main_vmenu}
	ui_flow_manager_respond_to_action \{action = friend_list}
endscript

script destroy_online_main_menu 
	clean_up_user_control_helpers
	destroy_menu_backdrop
	if ScreenElementExists \{id = main_menu_anchor}
		DestroyScreenElement \{id = main_menu_anchor}
	endif
	KillSpawnedScript \{name = scroll_motd_ticker}
endscript

script create_online_main_menu_helper_buttons 
	change \{user_control_pill_text_color = [
			255
			255
			255
			255
		]}
	change \{user_control_pill_color = [
			0
			0
			0
			255
		]}
	add_user_control_helper \{text = 'SELECT'
		button = green
		z = 100}
	add_user_control_helper \{text = 'BACK'
		button = red
		z = 100}
	add_user_control_helper \{text = 'UP/DOWN'
		button = strumbar
		z = 100}
endscript

script get_motd_and_start_ticker 
	if ($retrieved_message_of_the_day = 0)
		NetSessionFunc \{obj = motd
			func = get_demonware_motd
			params = {
				callback = motd_callback
			}}
	else
		motd_ticker_text_block :SetProps text = ($message_of_the_day)
		spawnscriptnow \{scroll_motd_ticker
			params = {
				id = motd_ticker_text_block
			}}
	endif
endscript

script motd_callback 
	if GotParam \{motd_text}
		change \{retrieved_message_of_the_day = 1}
		change message_of_the_day = <motd_text>
		if ScreenElementExists \{id = motd_ticker_text_block}
			motd_ticker_text_block :SetProps text = ($message_of_the_day)
			spawnscriptnow \{scroll_motd_ticker
				params = {
					id = motd_ticker_text_block
				}}
		endif
	endif
endscript

script scroll_motd_ticker \{scroll_time = 20}
	<end_pos> = (-1000.0, 0.0)
	<this_id> = <id>
	GetScreenElementChildren id = <this_id>
	if GotParam \{children}
		begin
		begin
		Wait \{2
			seconds}
		doScreenElementMorph id = <this_id> pos = <end_pos> time = <scroll_time>
		Wait \{5
			seconds}
		GetScreenElementProps id = <this_id>
		SetScreenElementProps id = <this_id> pos = <pos>
		Wait \{2.0
			seconds}
		<this_id> :DoMorph alpha = 0 time = 0.2
		<this_id> :SetProps pos = (0.0, 0.0)
		Wait \{0.5
			seconds}
		<this_id> :DoMorph alpha = 1 time = 0.2
		break
		repeat
		repeat
	endif
endscript

script return_from_online_main_menu 

	shut_down_net_play
	ui_flow_manager_respond_to_action \{action = go_back}
endscript

script online_menu_select_quickmatch_player 
	change \{match_type = player}
	set_network_preferences
	ui_flow_manager_respond_to_action \{action = select_quickmatch_player}
endscript

script online_menu_select_quickmatch_ranked 
	change \{match_type = ranked}
	set_network_preferences
	ui_flow_manager_respond_to_action \{action = select_quickmatch_ranked}
endscript

script online_menu_select_custom_match 
	ui_flow_manager_respond_to_action \{action = select_custom_match
		create_params = {
			menu_type = custom_match
		}}
endscript

script online_menu_select_create_match 
	ui_flow_manager_respond_to_action \{action = select_create_match
		create_params = {
			menu_type = create_match
		}}
endscript

script online_menu_select_options 
	ui_flow_manager_respond_to_action \{action = select_online_options}
endscript

script online_menu_select_join_friend 
	DWCJoinGame <...> join_friends = 1
	if (<join_result> = 1)
		ui_flow_manager_respond_to_action \{action = select_join_friend}
	endif
endscript

script online_menu_select_join_strangers 
	destroy_generic_popup
	DWCJoinGame <...> join_friends = 0
	if (<join_result> = 1)
		ui_flow_manager_respond_to_action \{action = select_join_friend}
	endif
endscript

script online_menu_select_log_out 
	shut_down_net_play
	ui_flow_manager_respond_to_action \{action = log_out}
endscript

script lobby_connection_lost 

	EndGameNetScriptPump
	if NOT (IsHost)
		quit_network_game
		setup_sessionfuncs
		destroy_net_popup
		ui_flow_manager_respond_to_action \{action = connection_lost}
	endif
endscript

script online_menu_select_website 
	create_link_text
	hide_unhide_menu_elements \{id = online_info_pane_container
		time = 0.2
		hide}
	Wait \{0.1
		seconds}
	hide_unhide_menu_elements \{id = online_main_menu_text_container
		time = 0.2
		hide}
	hide_unhide_menu_elements \{id = online_main_vmenu
		time = 0.2
		hide}
	translate_and_scale_online_menu
	Wait \{0.3
		seconds}
	if ScreenElementExists \{id = gh_link_container}
		RunScriptOnScreenElement \{id = gh_link_container
			doScreenElementMorph
			params = {
				id = gh_link_container
				alpha = 1.0
				time = 0.2
			}}
	endif
	ghlink_vmenu :SetProps \{enable_pad_handling}
	LaunchEvent \{type = focus
		target = ghlink_vmenu}
	if IsNgc
		if NOT ReportingStats
			create_generic_popup \{title = $wii_error
				ok_menu
				message = $wii_website_nostats
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
						back_from_website
					}
				]}
		endif
	endif
endscript

script back_from_website 
	destroy_generic_popup
	online_menu_unselect_website
endscript

script online_menu_unselect_website 
	if ScreenElementExists \{id = gh_link_container}
		RunScriptOnScreenElement \{id = gh_link_container
			doScreenElementMorph
			params = {
				id = gh_link_container
				alpha = 0.0
				time = 0.2
			}}
	endif
	Wait \{0.3
		seconds}
	if ScreenElementExists \{id = gh_link_container}
		DestroyScreenElement \{id = gh_link_container}
	endif
	translate_and_scale_online_menu \{revert}
	hide_unhide_menu_elements \{id = online_main_menu_text_container
		time = 0.2}
	hide_unhide_menu_elements \{id = online_main_vmenu
		time = 0.2}
	Wait \{0.1
		seconds}
	hide_unhide_menu_elements \{id = online_info_pane_container
		time = 0.2}
	Wait \{0.3
		seconds}
	LaunchEvent \{type = focus
		target = online_main_vmenu}
endscript

script create_link_text 
	CreateScreenElement \{type = ContainerElement
		parent = online_main_menu_container
		id = gh_link_container
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = VScrollingMenu
		parent = gh_link_container
		id = ghlink
		just = [
			center
			top
		]
		dims = (400.0, 480.0)
		pos = (320.0, 200.0)
		z_priority = 1}
	CreateScreenElement {
		type = VMenu
		parent = ghlink
		id = ghlink_vmenu
		pos = (0.0, 0.0)
		just = [left top]
		internal_just = [center top]
		dims = (400.0, 480.0)
		exclusive_device = ($primary_controller)
		event_handlers = [
			{pad_back SoundEvent params = {event = Generic_Menu_Back_SFX}}
			{pad_back online_menu_unselect_website}
			{pad_back clean_up_user_control_helpers}
			{pad_back create_online_main_menu_helper_buttons}
		]
	}
	<id> :SetProps disable_pad_handling
	CreateScreenElement {
		type = TextElement
		parent = gh_link_container
		id = gh_link_title
		font = fontgrid_title_gh3
		scale = 0.85
		rgba = ($online_dark_purple)
		text = 'www.guitarhero.com'
		just = [center top]
		pos = (640.0, 111.0)
		z_priority = 4.0
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = gh_link_container
		font = text_a4
		scale = (0.75, 0.75)
		rgba = ($online_light_blue)
		text = 'Ready to Be A Guitar Hero? \\nHere\'s how to link your stats to the web community:'
		just = [center top]
		internal_just = [center top]
		z_priority = 6.0
		pos = (640.0, 160.0)
		dims = (950.0, 200.0)
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = gh_link_container
		font = text_a4
		scale = (0.75, 0.75)
		rgba = ($online_light_blue)
		text = '- Go to www.guitarhero.com\\n- Create a New Account or Login\\n- Click \'Link Account\'\\n- Enter the following VIP Passcode'
		just = [center top]
		internal_just = [left top]
		z_priority = 6.0
		pos = (640.0, 240.0)
		dims = (1010.0, 600.0)
	}
	NetSessionFunc \{func = get_agora_token}
	FormatText TextName = vip_code '%a' a = <token>
	CreateScreenElement {
		type = TextElement
		parent = gh_link_container
		font = text_a4
		scale = 1.25
		rgba = ($online_light_blue)
		text = <vip_code>
		just = [center top]
		z_priority = 6.0
		pos = (640.0, 410.0)
		font_spacing = 5
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = gh_link_container
		font = text_a4
		scale = (0.75, 0.75)
		rgba = ($online_light_blue)
		text = 'On the web you can personalize your profile, browse leaderboards, jam with an online band, collect groupies, and rock out in tournaments!'
		just = [center top]
		internal_just = [left top]
		z_priority = 6.0
		pos = (648.0, 460.0)
		dims = (1010.0, 600.0)
	}
	if ScreenElementExists \{id = gh_link_container}
		RunScriptOnScreenElement \{id = gh_link_container
			doScreenElementMorph
			params = {
				id = gh_link_container
				alpha = 0.0
			}}
	endif
	clean_up_user_control_helpers
	change \{user_control_pill_text_color = [
			255
			255
			255
			255
		]}
	change \{user_control_pill_color = [
			0
			0
			0
			255
		]}
	add_user_control_helper \{text = 'BACK'
		button = red
		z = 100}
	LaunchEvent \{type = unfocus
		target = online_main_vmenu}
endscript

script online_menu_select_motd 
	create_motd_text
	hide_unhide_menu_elements \{id = online_main_menu_container
		time = 0.2
		hide}
	hide_unhide_menu_elements \{id = online_main_vmenu
		time = 0.2
		hide}
	Wait \{0.1
		seconds}
	hide_unhide_menu_elements \{id = online_info_pane_text_container
		time = 0.2
		hide}
	translate_and_scale_info_pane
	Wait \{0.3
		seconds}
	if ScreenElementExists \{id = MOTD_Container}
		RunScriptOnScreenElement \{id = MOTD_Container
			doScreenElementMorph
			params = {
				id = MOTD_Container
				alpha = 1.0
				time = 0.2
			}}
	endif
	LaunchEvent \{type = focus
		target = motd_vmenu}
	motd_vmenu :SetProps \{enable_pad_handling}
endscript

script online_menu_unselect_motd 
	if ScreenElementExists \{id = MOTD_Container}
		RunScriptOnScreenElement \{id = MOTD_Container
			doScreenElementMorph
			params = {
				id = MOTD_Container
				alpha = 0.0
				time = 0.2
			}}
	endif
	Wait \{0.3
		seconds}
	destroy_menu \{menu_id = motd_scroller}
	if ScreenElementExists \{id = MOTD_Container}
		DestroyScreenElement \{id = MOTD_Container}
	endif
	translate_and_scale_info_pane \{revert}
	hide_unhide_menu_elements \{id = online_info_pane_text_container
		time = 0.2}
	Wait \{0.1
		seconds}
	hide_unhide_menu_elements \{id = online_main_vmenu
		time = 0.2}
	hide_unhide_menu_elements \{id = online_main_menu_container
		time = 0.2}
	Wait \{0.3
		seconds}
	LaunchEvent \{type = focus
		target = online_main_vmenu}
endscript

script create_motd_text 
	CreateScreenElement \{type = ContainerElement
		parent = online_info_pane_container
		id = MOTD_Container
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = VScrollingMenu
		parent = MOTD_Container
		id = motd_scroller
		just = [
			center
			top
		]
		dims = (400.0, 480.0)
		pos = (640.0, 0.0)
		z_priority = 1}
	CreateScreenElement {
		type = VMenu
		parent = motd_scroller
		id = motd_vmenu
		pos = (0.0, 0.0)
		just = [left top]
		internal_just = [center top]
		dims = (400.0, 480.0)
		exclusive_device = ($primary_controller)
		event_handlers = [
			{pad_back SoundEvent params = {event = Generic_Menu_Back_SFX}}
			{pad_back online_menu_unselect_motd}
			{pad_back clean_up_user_control_helpers}
			{pad_back create_online_main_menu_helper_buttons}
		]
	}
	<id> :SetProps disable_pad_handling
	CreateScreenElement {
		type = TextElement
		parent = MOTD_Container
		id = gh_link_title
		font = fontgrid_title_gh3
		scale = 0.85
		rgba = ($online_light_blue)
		text = 'Message Of The Day'
		just = [center top]
		pos = (640.0, 160.0)
		z_priority = 10.0
	}
	CreateScreenElement \{type = WindowElement
		parent = MOTD_Container
		id = motd_info_scroll_window
		pos = (633.0, 220.0)
		dims = (500.0, 300.0)
		just = [
			center
			top
		]}
	CreateScreenElement {
		type = TextBlockElement
		parent = motd_info_scroll_window
		id = motd_info_text_block
		just = [left top]
		internal_just = [left top]
		pos = (0.0, 0.0)
		scale = (0.75, 0.55)
		text = ($message_of_the_day)
		font = text_a4
		rgba = ($online_light_blue)
		z_priority = 100
		dims = (670.0, 1500.0)
		line_spacing = 1.0
	}
	spawnscriptnow \{scroll_motd_info
		params = {
			id = motd_info_text_block
		}}
	if ScreenElementExists \{id = MOTD_Container}
		MOTD_Container :SetProps \{alpha = 0.0}
	endif
	clean_up_user_control_helpers
	change \{user_control_pill_text_color = [
			255
			255
			255
			255
		]}
	change \{user_control_pill_color = [
			0
			0
			0
			255
		]}
	add_user_control_helper \{text = 'BACK'
		button = red
		z = 100}
	LaunchEvent \{type = unfocus
		target = online_main_vmenu}
endscript

script scroll_motd_info \{scroll_time = 60}
	<end_pos> = (0.0, -1000.0)
	<this_id> = <id>
	GetScreenElementChildren id = <this_id>
	if GotParam \{children}
		GetArraySize (<children>)
		<line_nums> = <array_size>
	else
		return
	endif
	if (<line_nums> > 10)
		begin
		begin
		Wait \{5
			seconds}
		doScreenElementMorph id = <this_id> pos = <end_pos> time = <scroll_time>
		Wait ((<line_nums> - 10) * 1.8) seconds
		GetScreenElementProps id = <this_id>
		SetScreenElementProps id = <this_id> pos = <pos>
		Wait \{4.0
			seconds}
		<this_id> :DoMorph alpha = 0 time = 0.2
		<this_id> :SetProps pos = (0.0, 0.0)
		Wait \{0.5
			seconds}
		<this_id> :DoMorph alpha = 1 time = 0.2
		break
		repeat
		repeat
	endif
endscript

script translate_and_scale_online_menu 
	if NOT GotParam \{revert}
		RunScriptOnScreenElement id = online_frame doScreenElementMorph params = {id = online_frame pos = (($online_main_menu_pos) + (170.0, -35.0)) time = 0.2}
		RunScriptOnScreenElement id = online_frame_crown doScreenElementMorph params = {id = online_frame_crown pos = (($online_main_menu_pos) + (180.0, -88.0)) time = 0.2}
		RunScriptOnScreenElement \{id = online_frame
			scale_element_to_size
			params = {
				id = online_frame
				target_width = 760
				target_height = 500
				time = 0.2
			}}
	else
		RunScriptOnScreenElement id = online_frame doScreenElementMorph params = {id = online_frame pos = ($online_main_menu_pos) time = 0.2}
		RunScriptOnScreenElement id = online_frame_crown doScreenElementMorph params = {id = online_frame_crown pos = (($online_main_menu_pos) + (0.0, -62.0)) time = 0.2}
		online_frame :SetProps \{scale = 1.0}
		RunScriptOnScreenElement \{id = online_frame
			scale_element_to_size
			params = {
				id = online_frame
				target_width = 660
				target_height = 480
				time = 0.2
			}}
	endif
endscript

script translate_and_scale_info_pane 
	if NOT GotParam \{revert}
		RunScriptOnScreenElement id = motd_top doScreenElementMorph params = {id = motd_top pos = (($online_info_pane_pos) + (-250.0, -32.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_top_fill doScreenElementMorph params = {id = motd_top_fill pos = (($online_info_pane_pos) + (-250.0, -32.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_body doScreenElementMorph params = {id = motd_body pos = (($online_info_pane_pos) + (-250.0, 64.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_body_fill doScreenElementMorph params = {id = motd_body_fill pos = (($online_info_pane_pos) + (-250.0, 64.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_end doScreenElementMorph params = {id = motd_end pos = (($online_info_pane_pos) + (-250.0, 320.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_end_fill doScreenElementMorph params = {id = motd_end_fill pos = (($online_info_pane_pos) + (-250.0, 320.0)) time = 0.2}
		RunScriptOnScreenElement \{id = motd_top
			scale_element_to_size
			params = {
				id = motd_top
				target_width = 800
				target_height = 96
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_top_fill
			scale_element_to_size
			params = {
				id = motd_top_fill
				target_width = 800
				target_height = 96
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_body
			scale_element_to_size
			params = {
				id = motd_body
				target_width = 800
				target_height = 256
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_body_fill
			scale_element_to_size
			params = {
				id = motd_body_fill
				target_width = 800
				target_height = 256
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_end
			scale_element_to_size
			params = {
				id = motd_end
				target_width = 800
				target_height = 96
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_end_fill
			scale_element_to_size
			params = {
				id = motd_end_fill
				target_width = 800
				target_height = 96
				time = 0.2
			}}
	else
		RunScriptOnScreenElement id = motd_top doScreenElementMorph params = {id = motd_top pos = ($online_info_pane_pos) time = 0.2}
		RunScriptOnScreenElement id = motd_top_fill doScreenElementMorph params = {id = motd_top_fill pos = ($online_info_pane_pos) time = 0.2}
		RunScriptOnScreenElement id = motd_body doScreenElementMorph params = {id = motd_body pos = (($online_info_pane_pos) + (0.0, 64.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_body_fill doScreenElementMorph params = {id = motd_body_fill pos = (($online_info_pane_pos) + (0.0, 64.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_end doScreenElementMorph params = {id = motd_end pos = (($online_info_pane_pos) + (0.0, 320.0)) time = 0.2}
		RunScriptOnScreenElement id = motd_end_fill doScreenElementMorph params = {id = motd_end_fill pos = (($online_info_pane_pos) + (0.0, 320.0)) time = 0.2}
		RunScriptOnScreenElement \{id = motd_top
			scale_element_to_size
			params = {
				id = motd_top
				target_width = 800
				target_height = 96
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_top_fill
			scale_element_to_size
			params = {
				id = motd_top_fill
				target_width = 800
				target_height = 96
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_body
			scale_element_to_size
			params = {
				id = motd_body
				target_width = 800
				target_height = 256
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_body_fill
			scale_element_to_size
			params = {
				id = motd_body_fill
				target_width = 800
				target_height = 256
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_end
			scale_element_to_size
			params = {
				id = motd_end
				target_width = 800
				target_height = 96
				time = 0.2
			}}
		RunScriptOnScreenElement \{id = motd_end_fill
			scale_element_to_size
			params = {
				id = motd_end_fill
				target_width = 800
				target_height = 96
				time = 0.2
			}}
	endif
endscript

script hide_unhide_menu_elements \{time = 0.0}
	if ScreenElementExists id = <id>
		if GotParam \{hide}
			RunScriptOnScreenElement id = <id> doScreenElementMorph params = {alpha = 0.0 time = <time> id = <id>}
		else
			RunScriptOnScreenElement id = <id> doScreenElementMorph params = {alpha = 1.0 time = <time> id = <id>}
		endif
	endif
endscript
select_diff_to_char_render_stall = 0
main_menu_to_nintendo_wfc_render_stall = 0
joining_to_char_render_stall = 1
host_venue_to_char_select_render_stall = 1
host_invite_friend_to_char_select_render_stall = 1

script create_net_play_song_menu 
	change \{select_diff_to_char_render_stall = 1}
	change \{main_menu_to_nintendo_wfc_render_stall = 1}
	change \{joining_to_char_render_stall = 1}
	change \{host_venue_to_char_select_render_stall = 1}
	change \{host_invite_friend_to_char_select_render_stall = 1}
endscript

script destroy_net_play_song_menu 
	if ScreenElementExists \{id = notify_controller_static_text_container}
		sysnotify_handle_unpause_controller
	endif
endscript

script online_select_downloads 
	NetSessionFunc \{func = ShowMarketPlaceUI}
	wait_for_blade_complete
	SetPakManCurrentBlock \{map = zones
		pak = none
		block_scripts = 1}
	destroy_band
	Downloads_UnloadContent
	ui_flow_manager_respond_to_action \{action = select_downloadable_content}
endscript

script net_add_item_to_main_menu 
	if isXenon
		line_spacing = 40
	else
		line_spacing = 40
	endif
	CreateScreenElement {
		type = ContainerElement
		parent = <VMenu>
		dims = ((100.0, 0.0) + (0.0, 1.0) * <line_spacing>)
		event_handlers = [
			{focus net_main_menu_focus}
			{focus SetScreenElementProps params = {id = help_info_text_block text = ($info_text [<info_text_index>])}}
			{unfocus net_main_menu_unfocus}
		]
	}
	menu_item_container = <id>
	if GotParam \{pad_choose_script}
		if GotParam \{choose_script_params}
			<menu_item_container> :SetProps event_handlers = [{pad_choose <pad_choose_script> params = {<choose_script_params>}}]
		else
			<menu_item_container> :SetProps event_handlers = [{pad_choose <pad_choose_script>}]
		endif
	endif
	if GotParam \{pad_choose_script2}
		if GotParam \{choose_script_params2}
			<menu_item_container> :SetProps event_handlers = [{pad_choose <pad_choose_script2> params = {<choose_script_params2>}}]
		else
			<menu_item_container> :SetProps event_handlers = [{pad_choose <pad_choose_script2>}]
		endif
	endif
	CreateScreenElement {
		type = SpriteElement
		parent = <menu_item_container>
		local_id = highlightbar
		texture = white
		dims = (450.0, 40.0)
		rgba = ($online_light_blue)
		pos = (0.0, 7.5)
		just = [center top]
		z_priority = 3
		alpha = 0.0
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <menu_item_container>
		local_id = left_bookend
		texture = character_hub_hilite_bookend
		dims = (50.0, 50.0)
		rgba = ($online_light_blue)
		pos = (-227.0, 3.0)
		just = [center top]
		z_priority = 3
		alpha = 0.0
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <menu_item_container>
		local_id = right_bookend
		texture = character_hub_hilite_bookend
		dims = (50.0, 50.0)
		rgba = ($online_light_blue)
		pos = (240.0, 3.0)
		just = [center top]
		z_priority = 3
		alpha = 0.0
	}
	CreateScreenElement {
		type = TextElement
		parent = <menu_item_container>
		local_id = text
		font = text_a4
		scale = 0.75
		rgba = ($online_light_blue)
		text = <text>
		pos = (0.0, 10.0)
		just = [center top]
		z_priority = 4.0
	}
	GetScreenElementDims id = <id>
	if (<width> > 420)
		SetScreenElementProps {
			id = <id>
			scale = 1.0
		}
		scale_element_to_size {
			id = <id>
			target_width = 420
			target_height = <Height>
		}
	endif
	if (<text> = 'Quick Match: Ranked Match')
		GetGlobalTags \{user_options}
		if (<online_game_mode> = 4)
			SetScreenElementProps {
				id = <menu_item_container>
				not_focusable
			}
			SetScreenElementProps {
				id = {<menu_item_container> child = text}
				rgba = ($online_grey)
			}
		endif
	endif
endscript

script net_main_menu_focus 
	Obj_GetID
	if ScreenElementExists id = {<ObjID> child = highlightbar}
		SetScreenElementProps {
			id = {<ObjID> child = highlightbar}
			alpha = 1.0
		}
	endif
	if ScreenElementExists id = {<ObjID> child = left_bookend}
		SetScreenElementProps {
			id = {<ObjID> child = left_bookend}
			alpha = 1.0
		}
	endif
	if ScreenElementExists id = {<ObjID> child = right_bookend}
		SetScreenElementProps {
			id = {<ObjID> child = right_bookend}
			alpha = 1.0
		}
	endif
	if ScreenElementExists id = {<ObjID> child = text}
		SetScreenElementProps {
			id = {<ObjID> child = text}
			rgba = ($online_dark_purple)
		}
	endif
endscript

script net_main_menu_unfocus 
	Obj_GetID
	if ScreenElementExists id = {<ObjID> child = highlightbar}
		SetScreenElementProps {
			id = {<ObjID> child = highlightbar}
			alpha = 0.0
		}
	endif
	if ScreenElementExists id = {<ObjID> child = left_bookend}
		SetScreenElementProps {
			id = {<ObjID> child = left_bookend}
			alpha = 0.0
		}
	endif
	if ScreenElementExists id = {<ObjID> child = right_bookend}
		SetScreenElementProps {
			id = {<ObjID> child = right_bookend}
			alpha = 0.0
		}
	endif
	if ScreenElementExists id = {<ObjID> child = text}
		SetScreenElementProps {
			id = {<ObjID> child = text}
			rgba = ($online_light_blue)
		}
	endif
endscript
