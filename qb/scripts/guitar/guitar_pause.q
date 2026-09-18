
script setup_pause 
	SetScreenElementProps \{id = root_window
		event_handlers = [
			{
				pad_start
				gh3_start_pressed
			}
		]
		replace_handlers}
	LaunchEvent \{type = focus
		target = root_window}
endscript

script disable_pause 
	kill_start_key_binding
endscript

script enable_pause 
	restore_start_key_binding
endscript
homepausegame = 0

script home_menu_pause 



	if NOT IsGamePaused
		if NOT ($homepausegame = 1)
			BroadcastEvent \{type = event_pause_game}
			PauseGame
			if NOT (SkaterCamAnimFinished name = cutscene)
				MovieMembFunc \{name = cutscene
					func = Cut_GEL_Pause}
			endif
			PauseFullScreenMovie
			change \{homepausegame = 1}
		endif
	endif
	PauseAllSoundsHomeMenu
endscript

script home_menu_unpause 



	if NOT ($in_menu_choose_practice_section = 1)
		GetSongTimeMs
		CastToInteger \{time}
		if (<time> > $current_starttime)
			SetSeekPosition_Song position = <time>
		endif
	endif
	waitforseek_song
	if ($homepausegame = 1)
		WaitOneGameFrame
		WaitOneGameFrame
		UnPauseFullScreenMovie
		UnPauseGame
		if NOT (SkaterCamAnimFinished name = cutscene)
			MovieMembFunc \{name = cutscene
				func = Cut_GEL_Pause
				params = {
					off
				}}
		endif
		change \{homepausegame = 0}
	endif
	UnPauseAllSoundsHomeMenu
endscript

script pausegh3 



	BroadcastEvent \{type = event_pause_game}
	WaitOneGameFrame
	WaitOneGameFrame
	PauseGh3Sounds <...>
	PauseFullScreenMovie
	PauseGame
	if IsMoviePlaying \{TextureSlot = 0}
		PauseMovie \{TextureSlot = 0}
	endif
	if IsMoviePlaying \{TextureSlot = 1}
		PauseMovie \{TextureSlot = 1}
	endif
	if NOT (SkaterCamAnimFinished name = cutscene)
		MovieMembFunc \{name = cutscene
			func = Cut_GEL_Pause}
	endif
	ui_flow_manager_respond_to_action \{action = pause_game}
	WaitOneGameFrame
endscript

script unpausegh3 



	if NOT ($in_menu_choose_practice_section = 1)
		if ($is_network_game = 0)
			GetSongTimeMs
			CastToInteger \{time}
			if (<time> > $current_starttime)
				SetSeekPosition_Song position = <time>
			endif
		endif
	endif
	waitforseek_song
	WaitOneGameFrame
	WaitOneGameFrame
	ui_flow_manager_respond_to_action \{action = select_resume}
	WaitOneGameFrame
	UnPauseFullScreenMovie
	UnPauseGame
	WaitOneGameFrame
	UnpauseGh3Sounds <...>
	if IsMoviePlaying \{TextureSlot = 0}
		ResumeMovie \{TextureSlot = 0}
	endif
	if IsMoviePlaying \{TextureSlot = 1}
		ResumeMovie \{TextureSlot = 1}
	endif
	if NOT (SkaterCamAnimFinished name = cutscene)
		MovieMembFunc \{name = cutscene
			func = Cut_GEL_Pause
			params = {
				off
			}}
	endif
	change \{toggleviewmode_enabled = true}
	if NOT IsPs3
		ResumeControllerChecking
	endif
	change \{paused_for_hardware = 0}
endscript
last_start_pressed_device = 0
g_pause_is_busy = 0

script gh3_start_pressed \{device_num = -1}
	printscriptinfo \{'gh3_start_pressed'}
	if (<device_num> = -1)
		if ($player1_status.bot_play = 1)
			start_pressed_device = ($primary_controller)
		else
			start_pressed_device = ($player1_status.controller)
		endif
	else
		if ($is_attract_mode = 1)
			return
		endif
		if ($player1_status.bot_play = 1)
			start_pressed_device = ($primary_controller)
		elseif (<device_num> = ($player1_status.controller))
			start_pressed_device = <device_num>
		elseif ($current_num_players = 2 && $is_network_game = 0 && $boss_battle = 0)
			if (<device_num> = $player2_status.controller)
				start_pressed_device = <device_num>
			else
				return
			endif
		else
			return
		endif
	endif
	if GameIsPaused
		if NOT (<device_num> = -1)
			if NOT (<start_pressed_device> = $last_start_pressed_device)
				return
			endif
		endif
		if NOT (<device_num> = -1)
			SetInput controller = <device_num> pattern = 0 strum = 0
		endif
	else
		change last_start_pressed_device = <start_pressed_device>
	endif
	spawnscriptnow gh3_start_pressed_spawned params = {<...>}
endscript

script gh3_start_pressed_spawned 
	if ($g_pause_is_busy = 1)
		return
	endif
	change \{g_pause_is_busy = 1}
	if NOT ($view_mode = 0)
		if GameIsPaused
			UnpauseGh3Sounds <...>
			UnPauseGame
		else
			PauseGh3Sounds <...>
			PauseGame
			unpausespawnedscript \{update_crowd_model_cam}
		endif
		change \{g_pause_is_busy = 0}
		return
	endif
	if GameIsPaused
		spawnscriptnow \{block_input_on_exit}
		unpausegh3 <...>
		spawnscriptnow \{destroy_gh3_pause_menu}
		BroadcastEvent \{type = event_unpause_game}
		change \{viewer_buttons_enabled = 1}
	else
		if ($ui_flow_manager_state [0] = online_pause_fs)
			net_unpausegh3
			change \{g_pause_is_busy = 0}
			return
		elseif ($is_network_game && $playing_song)
			net_pausegh3
			change \{g_pause_is_busy = 0}
			return
		endif
		pausegh3 <...>
		safe_create_gh3_pause_menu <...>
		change \{viewer_buttons_enabled = 0}
		spawnscriptnow \{block_input}
	endif
	change \{g_pause_is_busy = 0}
endscript
input_blocked = 0

script block_input 
	if ($fade_overlay_count = 0)
		SetButtonEventMappings \{block_menu_input}
		change \{input_blocked = 1}
		Wait \{0.25
			seconds}
		SetButtonEventMappings \{unblock_menu_input}
		change \{input_blocked = 0}
	endif
endscript

script block_input_on_exit 
	if ($fade_overlay_count = 0)
		SetButtonEventMappings \{block_menu_input}
		change \{input_blocked = 1}
		Wait \{1.25
			seconds}
		SetButtonEventMappings \{unblock_menu_input}
		change \{input_blocked = 0}
	endif
endscript

script create_gh3_pause_menu 
	change \{toggleviewmode_enabled = false}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = Pause_Menu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
endscript

script destroy_gh3_pause_menu 
	if ScreenElementExists \{id = Pause_Menu}
		DestroyScreenElement \{id = Pause_Menu}
	endif
	doScreenElementMorph \{id = hud_window
		alpha = 1}
	change \{g_pause_is_busy = 0}
endscript

script safe_create_gh3_pause_menu 
	KillSpawnedScript \{name = destroy_loading_screen_spawned}
	if NOT ScreenElementExists \{id = Pause_Menu}
		create_gh3_pause_menu <...>
	endif
endscript

script create_generic_backdrop 
	if NOT ScreenElementExists \{id = generic_backdrop_container}
		CreateScreenElement \{type = ContainerElement
			parent = root_window
			id = generic_backdrop_container
			pos = (0.0, 0.0)
			just = [
				left
				top
			]}
		CreateScreenElement \{type = SpriteElement
			id = pause_backdrop
			parent = generic_backdrop_container
			texture = Venue_BG
			rgba = [
				255
				255
				255
				255
			]
			pos = (640.0, 360.0)
			dims = (1280.0, 720.0)
			just = [
				center
				center
			]
			z_priority = 0
			alpha = 1}
		doScreenElementMorph \{id = hud_window
			alpha = 0
			time = 0.5}
	endif
endscript

script destroy_generic_backdrop 
	if ScreenElementExists \{id = generic_backdrop_container}
		DestroyScreenElement \{id = generic_backdrop_container}
	endif
endscript

script clear_input_block 
	if ($input_blocked = 1)
		SetButtonEventMappings \{unblock_menu_input}
		change \{input_blocked = 0}
	endif
endscript
