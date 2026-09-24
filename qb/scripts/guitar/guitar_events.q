guitar_events = [
	{
		event = missed_note
		Scr = GuitarEvent_MissedNote
	}
	{
		event = unnecessary_note
		Scr = GuitarEvent_UnnecessaryNote
	}
	{
		event = hit_notes
		Scr = GuitarEvent_HitNotes
	}
	{
		event = hit_note
		Scr = GuitarEvent_HitNote
	}
	{
		event = star_power_on
		Scr = GuitarEvent_StarPowerOn
	}
	{
		event = star_power_off
		Scr = GuitarEvent_StarPowerOff
	}
	{
		event = song_failed
		Scr = GuitarEvent_SongFailed
	}
	{
		event = song_won
		Scr = GuitarEvent_SongWon
	}
	{
		event = star_hit_note
		Scr = GuitarEvent_StarHitNote
	}
	{
		event = star_sequence_bonus
		Scr = GuitarEvent_StarSequenceBonus
	}
	{
		event = star_miss_note
		Scr = GuitarEvent_StarMissNote
	}
	{
		event = whammy_on
		Scr = GuitarEvent_WhammyOn
	}
	{
		event = whammy_off
		Scr = GuitarEvent_WhammyOff
	}
	{
		event = star_whammy_on
		Scr = GuitarEvent_StarWhammyOn
	}
	{
		event = star_whammy_off
		Scr = GuitarEvent_StarWhammyOff
	}
	{
		event = note_window_open
		Scr = GuitarEvent_Note_Window_Open
	}
	{
		event = note_window_close
		Scr = GuitarEvent_Note_Window_Close
	}
	{
		event = crowd_poor_medium
		Scr = GuitarEvent_crowd_poor_medium
	}
	{
		event = crowd_medium_good
		Scr = GuitarEvent_crowd_medium_good
	}
	{
		event = crowd_medium_poor
		Scr = GuitarEvent_crowd_medium_poor
	}
	{
		event = crowd_good_medium
		Scr = GuitarEvent_crowd_good_medium
	}
	{
		event = first_gem
		Scr = GuitarEvent_CreateFirstGem
	}
	{
		event = firstnote_window_open
		Scr = GuitarEvent_FirstNote_Window_Open
	}
]

script create_guitar_events 

	GetArraySize \{$guitar_events}
	array_entry = 0
	begin

	event = ($guitar_events [<array_entry>].event)
	ExtendCRC <event> <player_text> out = event
	SetEventHandler response = cfunc event = <event> Scr = event_spawner_cfunc params = {event_spawned = <array_entry>}
	array_entry = (<array_entry> + 1)
	repeat <array_size>
	Block
endscript

script event_iterator 

	get_song_prefix song = <song_name>
	FormatText checksumname = song '%s_%e' s = <song_prefix> e = <event_string> AddToStringLookup
	array_entry = 0
	GetArraySize $<song>
	if (<array_size> = 0)
		return
	endif
	GetSongTimeMs time_offset = <time_offset>
	begin
	if ((<time> - <skipleadin>) < (($<song> [<array_entry>]).time))
		break
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
	array_size = (<array_size> - <array_entry>)
	if (<array_size> = 0)
		return
	endif
	begin
	TimeMarkerReached_SetParams time_offset = <time_offset> array = <song> array_entry = <array_entry> ArrayOfStructures
	begin
	if TimeMarkerReached
		GetSongTimeMs time_offset = <time_offset>
		break
	endif
	WaitOneGameFrame
	repeat
	TimeMarkerReached_ClearParams
	ScriptName = ($<song> [<array_entry>].Scr)
	if ScriptExists <ScriptName>
		spawnscriptnow <ScriptName> params = {time = <time> ($<song> [<array_entry>].params)} id = song_event_scripts
	elseif SymbolIsCFunc <ScriptName>
		<ScriptName> {time = <time> ($<song> [<array_entry>].params)}
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
endscript

script wait_for_correct_frame 
	if NOT ($playing_song_for_real = 1)
		return
	endif
	if wait_for_correct_frame_cfunc
		WaitOneGameFrame
	endif
endscript

script wait_for_correct_frame_obj 
	if NOT ($playing_song_for_real = 1)
		return
	endif
	if (<id> = vocalist || <id> = Drummer)
		return
	endif
	if (<id> = Guitarist)
		if ($current_frame_toggle = 1)
			Wait \{1
				gameframe}
		endif
	else
		if ($current_frame_toggle = 0)
			Wait \{1
				gameframe}
		endif
	endif
endscript

script GuitarEvent_MissedNote 
	GuitarEvent_MissedNote_CFunc_Setup
	begin
	if GuitarEvent_MissedNote_CFunc
		break
	endif
	WaitOneGameFrame
	repeat
	GuitarEvent_MissedNote_CFunc_Cleanup
endscript

script highway_pulse_black 
	<half_time> = ($highway_pulse_time / 2.0)
	FormatText checksumname = highway 'Highway_2D%p' p = <player_text> AddToStringLookup = true
	doScreenElementMorph id = <highway> rgba = ($highway_pulse) time = <half_time>
	Wait <half_time> seconds
	doScreenElementMorph id = <highway> rgba = ($highway_normal) time = <half_time>
endscript

script GuitarEvent_UnnecessaryNote 
	GuitarEvent_UnnecessaryNote_CFunc_Setup
	begin
	if GuitarEvent_UnnecessaryNote_CFunc
		break
	endif
	WaitOneGameFrame
	repeat
	GuitarEvent_UnnecessaryNote_CFunc_Cleanup
endscript

script GuitarEvent_HitNotes 
	wait_for_correct_frame player = ($<player_status>.player)
	if GuitarEvent_HitNotes_CFunc
		update_guitar_volume_cfunc
	endif
endscript

script GuitarEvent_HitNote 
	wait_for_correct_frame player = <player>
	if ($game_mode = p2_battle || $boss_battle = 1)
		change structurename = <player_status> last_hit_note = <color>
	endif
	WaitOneGameFrame
	hit_note_fx name = <fx_id> pos = <pos> player_text = <player_text> star = ($<player_status>.star_power_used) player = <player>
endscript
hit_particle_params = {
	z_priority = 8.0
	material = sys_Particle_Spark01_sys_Particle_Spark01
	start_color = [
		255
		128
		0
		255
	]
	end_color = [
		255
		0
		0
		0
	]
	start_scale = (2.0, 2.0)
	end_scale = (1.0, 1.0)
	start_angle_spread = 0.0
	min_rotation = 0.0
	max_rotation = 0.0
	emit_start_radius = 0.0
	emit_radius = 1.0
	emit_rate = 0.02
	emit_dir = 0.0
	emit_spread = 160.0
	velocity = 10.0
	friction = (0.0, 50.0)
	time = 0.25
}
star_hit_particle_params = {
	z_priority = 8.0
	material = sys_Particle_Spark01_sys_Particle_Spark01
	start_color = [
		0
		255
		255
		255
	]
	end_color = [
		0
		255
		255
		0
	]
	start_scale = (2.0, 2.0)
	end_scale = (1.0, 1.0)
	start_angle_spread = 0.0
	min_rotation = 0.0
	max_rotation = 0.0
	emit_start_radius = 0.0
	emit_radius = 1.0
	emit_rate = 0.02
	emit_dir = 0.0
	emit_spread = 160.0
	velocity = 10.0
	friction = (0.0, 50.0)
	time = 0.25
}
whammy_particle_params = {
	z_priority = 8.0
	material = sys_Particle_Spark01_sys_Particle_Spark01
	start_color = [
		255
		128
		0
		255
	]
	end_color = [
		255
		0
		0
		0
	]
	start_scale = (1.0, 1.0)
	end_scale = (0.5, 0.5)
	start_angle_spread = 0.0
	min_rotation = 0.0
	max_rotation = 0.0
	emit_start_radius = 0.0
	emit_radius = 1.0
	emit_rate = 0.02
	emit_dir = 0.0
	emit_spread = 160.0
	velocity = 10.0
	friction = (0.0, 50.0)
	time = 0.5
}

script hit_note_fx 
	NoteFX
	Wait \{15
		gameframes}
	if ScreenElementExists id = <fx_id>
		DestroyScreenElement id = <fx_id>
	endif
endscript

script GuitarEvent_StarPowerOn 
	wait_for_correct_frame player = <player>
	GH_Star_Power_Verb_On
	StarPowerOn player = <player>
endscript

script GuitarEvent_StarPowerOff 
	wait_for_correct_frame player = ($<player_status>.player)
	GH_Star_Power_Verb_Off
	spawnscriptnow rock_meter_star_power_off params = {player_text = <player_text>}
	SpawnScriptLater Kill_StarPower_StageFX params = {<...>}
	FormatText checksumname = cont 'starpower_container_left%p' p = <player_text> AddToStringLookup = true
	if ScreenElementExists id = <cont>
		doScreenElementMorph id = <cont> alpha = 0
	endif
	FormatText checksumname = cont 'starpower_container_right%p' p = <player_text> AddToStringLookup = true
	if ScreenElementExists id = <cont>
		doScreenElementMorph id = <cont> alpha = 0
	endif
	FormatText checksumname = highway 'Highway_2D%p' p = <player_text> AddToStringLookup = true
	if ScreenElementExists id = <highway>
		SetScreenElementProps id = <highway> rgba = ($highway_normal)
	endif
	spawnscriptnow \{Kill_StarPower_Camera}
endscript

script GuitarEvent_PreFretbar 
	waittime = 0.18
	Wait <waittime> seconds
	if IsNgc
		if ($player1_status.star_power_used = 1)
			ActivateStarPowerPulse player = ($player1_status.controller) num = 1 length = 10 strength = 11 priority = 1
		endif
		if ($player2_status.star_power_used = 1)
			ActivateStarPowerPulse player = ($player2_status.controller) num = 1 length = 10 strength = 11 priority = 1
		endif
	endif
	if ($<player_status>.star_power_used = 1)
		if ($game_mode != tutorial)
			SoundEvent \{event = Crowd_Individual_Clap_To_Beat}
		endif
	else
		if ($CrowdListenerStateClapOn1234 = 1)
			SoundEvent \{event = Crowd_Individual_Clap_To_Beat}
		endif
	endif
endscript
beat_flip = 0

script GuitarEvent_Fretbar 
	if ($current_num_players = 2)
		if ($game_mode = p2_battle || $boss_battle)
			<dying> = 0
			if (($player1_status.current_health) <= $crowd_poor_medium * $highway_flash_dying)
				<dying> = 1
			endif
			set_sidebar_flash dying = <dying> player_status = player1_status
			<dying> = 0
			if (($player2_status.current_health) <= $crowd_poor_medium * $highway_flash_dying)
				<dying> = 1
			endif
			if NOT ($player1_status.highway_layout = solo_highway)
				set_sidebar_flash dying = <dying> player_status = player2_status
			endif
		else
			<dying> = 0
			if ($current_crowd <= $crowd_poor_medium * $highway_flash_dying)
				<dying> = 1
			endif
			if ($game_mode = p2_faceoff)
				<dying> = 0
			endif
			if ($game_mode = p2_pro_faceoff)
				<dying> = 0
			endif
			set_sidebar_flash dying = <dying> player_status = player1_status
			if NOT ($player1_status.highway_layout = solo_highway)
				set_sidebar_flash dying = <dying> player_status = player2_status
			endif
		endif
	else
		<dying> = 0
		if ($current_crowd <= $crowd_poor_medium * $highway_flash_dying)
			<dying> = 1
		endif
		set_sidebar_flash dying = <dying> player_status = player1_status
	endif
	change beat_flip = (1 - $beat_flip)
endscript

script set_sidebar_flash 
	FormatText checksumname = left 'sidebar_left%p' p = ($<player_status>.text) AddToStringLookup = true
	FormatText checksumname = right 'sidebar_right%p' p = ($<player_status>.text) AddToStringLookup = true
	if ($<player_status>.star_power_used = 1)
		if ($beat_flip = 0)
			SetScreenElementProps id = <left> rgba = ($sidebar_starpower0)
			SetScreenElementProps id = <right> rgba = ($sidebar_starpower0)
		else
			SetScreenElementProps id = <left> rgba = ($sidebar_starpower1)
			SetScreenElementProps id = <right> rgba = ($sidebar_starpower1)
		endif
	else
		if (<dying> = 1)
			if ($beat_flip = 0)
				SetScreenElementProps id = <left> rgba = ($sidebar_dying0)
				SetScreenElementProps id = <right> rgba = ($sidebar_dying0)
			else
				SetScreenElementProps id = <left> rgba = ($sidebar_dying1)
				SetScreenElementProps id = <right> rgba = ($sidebar_dying1)
			endif
		else
			if ($<player_status>.star_power_amount >= 50.0)
				if ($beat_flip = 0)
					SetScreenElementProps id = <left> rgba = ($sidebar_starready0)
					SetScreenElementProps id = <right> rgba = ($sidebar_starready0)
				else
					SetScreenElementProps id = <left> rgba = ($sidebar_starready1)
					SetScreenElementProps id = <right> rgba = ($sidebar_starready1)
				endif
			else
				if ($beat_flip = 0)
					SetScreenElementProps id = <left> rgba = ($sidebar_normal0)
					SetScreenElementProps id = <right> rgba = ($sidebar_normal0)
				else
					SetScreenElementProps id = <left> rgba = ($sidebar_normal1)
					SetScreenElementProps id = <right> rgba = ($sidebar_normal1)
				endif
			endif
		endif
	endif
endscript

script GuitarEvent_Fretbar_Early 
endscript

script GuitarEvent_Fretbar_Late 
endscript

script check_first_note_formed 
	GetSongTime
	<StartTime> = (<songtime> - 0.0167)
	duration = ($<player_status>.check_time_early + $<player_status>.check_time_late)
	begin
	GetHeldPattern controller = ($<player_status>.controller) player_status = <player_status>
	if (<strum> = <hold_pattern>)
		change structurename = <player_status> guitar_volume = 100
		update_guitar_volume_cfunc
	endif
	WaitOneGameFrame
	GetSongTime
	if ((<songtime> - <StartTime>) >= <duration>)
		break
	endif
	repeat
endscript

script GuitarEvent_FirstNote_Window_Open 
	if IsGuitarController controller = ($<player_status>.controller)
		GetStrumPattern entry = 0 song = <song>
		spawnscriptnow check_first_note_formed params = {strum = <strum> player_status = <player_status>}
	else
		change structurename = <player_status> guitar_volume = 100
		update_guitar_volume_cfunc
	endif
endscript

script GuitarEvent_Note_Window_Open 
	GuitarEvent_Note_Window_Open_CFunc_Setup
	begin
	if GuitarEvent_Note_Window_Open_CFunc
		break
	endif
	WaitOneGameFrame
	repeat
	GuitarEvent_Note_Window_Open_CFunc_Cleanup
endscript

script GuitarEvent_Note_Window_Close 
	if ($Debug_Audible_Close = 1)
		SoundEvent \{event = GH_SFX_BeatWindowCloseSoundEvent}
	endif
endscript
blueWhammyFXID01p1 = JOW_NIL
blueWhammyFXID02p1 = JOW_NIL
greenWhammyFXID01p1 = JOW_NIL
greenWhammyFXID02p1 = JOW_NIL
orangeWhammyFXID01p1 = JOW_NIL
orangeWhammyFXID02p1 = JOW_NIL
redWhammyFXID01p1 = JOW_NIL
redWhammyFXID02p1 = JOW_NIL
yellowWhammyFXID01p1 = JOW_NIL
yellowWhammyFXID02p1 = JOW_NIL
blueWhammyFXID01p2 = JOW_NIL
blueWhammyFXID02p2 = JOW_NIL
greenWhammyFXID01p2 = JOW_NIL
greenWhammyFXID02p2 = JOW_NIL
orangeWhammyFXID01p2 = JOW_NIL
orangeWhammyFXID02p2 = JOW_NIL
redWhammyFXID01p2 = JOW_NIL
redWhammyFXID02p2 = JOW_NIL
yellowWhammyFXID01p2 = JOW_NIL
yellowWhammyFXID02p2 = JOW_NIL

script Destroy_AllWhammyFX 
	WhammyFXOffAll \{player_status = player1_status}
	WhammyFXOffAll \{player_status = player2_status}
endscript

script GuitarEvent_WhammyOn 
	if (<player> = 1)
		lock = whammyon_lockp1
	else
		lock = whammyon_lockp2
	endif
	change globalname = <lock> newvalue = 1
	wait_for_correct_frame player = <player>
	WhammyFXOn <...>
	change globalname = <lock> newvalue = 0
endscript

script GuitarEvent_WhammyOff 
	if (<player> = 1)
		lock = whammyon_lockp1
	else
		lock = whammyon_lockp2
	endif
	begin
	if NOT ($<lock>)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	wait_for_correct_frame player = <player>
	WhammyFXOff <...>
endscript

script GuitarEvent_StarWhammyOn 
endscript

script GuitarEvent_StarWhammyOff 
endscript

script GuitarEvent_SongFailed 
	change \{check_for_unplugged_controllers = 0}
	if ($game_mode = training || $game_mode = tutorial)
		return
	endif
	if ($is_network_game)
		spawnscriptnow \{online_fail_song}
		return
	endif
	if ($game_mode = p2_battle)
		GuitarEvent_SongWon \{battle_win = 1}
	else
		KillSpawnedScript \{name = GuitarEvent_SongWon_Spawned}
		spawnscriptnow \{GuitarEvent_SongFailed_Spawned}
	endif
endscript

script GuitarEvent_SongFailed_Spawned 
	if NOT ($boss_battle = 1)
		disable_highway_prepass
		disable_bg_viewport
	endif
	if ($is_network_game)
		KillSpawnedScript \{name = dispatch_player_state}
		kill_start_key_binding
		if ($ui_flow_manager_state [0] = online_pause_fs)
			net_unpausegh3
		endif
		mark_unsafe_for_shutdown
	endif
	GetSongTimeMs
	change failed_song_time = <time>
	Achievements_SongFailed
	PauseGame
	Progression_SongFailed
	if ($boss_battle = 1)
		kill_start_key_binding
		if ($current_song = bossdevil)
			preload_movie = 'Satan-Battle_LOSS'
		else
			preload_movie = 'Player2_wins'
		endif
		KillMovie \{TextureSlot = 1}
		FormatText checksumname = preload_movie_checksum '%s' s = <preload_movie>
		change g_you_rock_movie = <preload_movie_checksum>
		FormatText TextName = winner_text '%s Rocks!' s = ($current_boss.character_name)
		winner_space_between = (50.0, 0.0)
		winner_scale = 1.0
		if ($current_boss.character_profile = morello)
			<winner_space_between> = (40.0, 0.0)
			<winner_scale> = 1.0
		endif
		if ($current_boss.character_profile = slash)
			<winner_space_between> = (40.0, 0.0)
			<winner_scale> = 1.0
			<winner_space_between> = (<winner_space_between> * 1.3)
			<winner_scale> = (<winner_scale> * 1.6)
		endif
		if ($current_boss.character_profile = satan)
			<winner_space_between> = (40.0, 0.0)
			<winner_scale> = 1.0
			<winner_space_between> = (<winner_space_between> * 1.8)
			<winner_scale> = (<winner_scale> * 1.7)
		endif
		spawnscriptnow \{wait_and_play_you_rock_movie}
		Wait \{0.2
			seconds}
		destroy_menu \{menu_id = yourock_text}
		destroy_menu \{menu_id = yourock_text_2}
		StringLength string = <winner_text>
		<fit_dims> = (<str_len> * (23.0, 0.0))
		if (<fit_dims>.(1.0, 0.0) >= 350)
			<fit_dims> = (350.0, 0.0)
		endif
		winner_space_between = (45.0, 0.0)
		winner_scale = 2.5
		if (<str_len> > 24)
			winner_space_between = (15.0, 0.0)
			winner_scale = 0.7
		elseif (<str_len> > 19)
			winner_space_between = (20.0, 0.0)
			winner_scale = 1.1
		elseif (<str_len> > 12)
			winner_space_between = (25.0, 0.0)
			winner_scale = 1.3
		elseif (<str_len> > 10)
			winner_space_between = (36.0, 0.0)
			winner_scale = 2.2
		endif
		split_text_into_array_elements {
			id = yourock_text
			text = <winner_text>
			text_pos = (640.0, 360.0)
			space_between = (<winner_space_between> * 2.0)
			just = [center center]
			flags = {
				rgba = [255 255 255 255]
				scale = (<winner_scale> * 2.0)
				z_priority = 95
				font = text_a10_large
				rgba = [223 223 223 255]
				just = [center center]
				alpha = 1
			}
			centered
		}
		spawnscriptnow \{waitAndKillHighway}
		KillSpawnedScript \{name = jiggle_text_array_elements}
		spawnscriptnow \{jiggle_text_array_elements
			params = {
				id = yourock_text
				time = 1.0
				wait_time = 3000
				explode = 1
			}}
	endif
	if ($is_network_game = 0)
		xenon_singleplayer_session_begin_uninit
		spawnscriptnow \{xenon_singleplayer_session_complete_uninit}
	endif
	UnPauseGame
	SoundEvent \{event = Crowd_Fail_Song_SFX}
	SoundEvent \{event = GH_SFX_You_Lose_Single_Player}
	Transition_Play \{type = songlost}
	Transition_Wait
	change \{current_transition = none}
	PauseGame
	restore_start_key_binding
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = fail_song
		}}
	if ($current_num_players = 1)
		SoundEvent \{event = Crowd_Fail_Song_SFX}
	else
		SoundEvent \{event = Crowd_Med_To_Good_SFX}
	endif
	if ($is_network_game)
		mark_safe_for_shutdown
	endif
endscript

script GuitarEvent_SongWon \{battle_win = 0}
	change \{check_for_unplugged_controllers = 0}
	if NotCD
		if ($output_gpu_log = 1)
			if IsPs3
				FormatText \{TextName = filename
					'%s_gpu_ps3'
					s = $current_level
					DontAssertForChecksums}
			else
				FormatText \{TextName = filename
					'%s_gpu'
					s = $current_level
					DontAssertForChecksums}
			endif
			TextOutputEnd output_text filename = <filename>
		endif
		if ($output_song_stats = 1)
			FormatText \{TextName = filename
				'%s_stats'
				s = $current_song
				DontAssertForChecksums}
			TextOutputStart
			TextOutput \{text = 'Player 1'}
			FormatText TextName = text 'Score: %s' s = ($player1_status.score) DontAssertForChecksums
			TextOutput text = <text>
			FormatText TextName = text 'Notes Hit: %n of %t' n = ($player1_status.notes_hit) t = ($player1_status.total_notes) DontAssertForChecksums
			TextOutput text = <text>
			FormatText TextName = text 'Best Run: %r' r = ($player1_status.best_run) DontAssertForChecksums
			TextOutput text = <text>
			FormatText TextName = text 'Max Notes: %m' m = ($player1_status.max_notes) DontAssertForChecksums
			TextOutput text = <text>
			FormatText TextName = text 'Base score: %b' b = ($player1_status.base_score) DontAssertForChecksums
			TextOutput text = <text>
			if (($player1_status.base_score) = 0)
				FormatText \{TextName = text
					'Score Scale: n/a'}
			else
				FormatText TextName = text 'Score Scale: %s' s = (($player1_status.score) / ($player1_status.base_score)) DontAssertForChecksums
			endif
			TextOutput text = <text>
			if (($player1_status.total_notes) = 0)
				FormatText \{TextName = text
					'Notes Hit Percentage: n/a'}
			else
				FormatText TextName = text 'Notes Hit Percentage: %s' s = ((($player1_status.notes_hit) / ($player1_status.total_notes)) * 100.0) DontAssertForChecksums
			endif
			TextOutput text = <text>
			TextOutputEnd output_text filename = <filename>
		endif
	endif
	if ($current_num_players = 2)
		GetSongTimeMs
		if ($last_time_in_lead_player = 0)
			change structurename = player1_status time_in_lead = ($player1_status.time_in_lead + <time> - $last_time_in_lead)
		elseif ($last_time_in_lead_player = 1)
			change structurename = player2_status time_in_lead = ($player2_status.time_in_lead + <time> - $last_time_in_lead)
		endif
		change \{last_time_in_lead_player = -1}
	endif
	if ($game_mode = p2_battle)
		if NOT (<battle_win> = 1)
			change \{save_current_powerups_p1 = $current_powerups_p1}
			change \{save_current_powerups_p2 = $current_powerups_p2}
			change \{current_powerups_p1 = [
					0
					0
					0
				]}
			change \{current_powerups_p2 = [
					0
					0
					0
				]}
			change structurename = player1_status save_num_powerups = ($player1_status.current_num_powerups)
			change structurename = player2_status save_num_powerups = ($player2_status.current_num_powerups)
			change \{structurename = player1_status
				current_num_powerups = 0}
			change \{structurename = player2_status
				current_num_powerups = 0}
			p1_health = ($player1_status.current_health)
			p2_health = ($player2_status.current_health)
			change structurename = player1_status save_health = <p1_health>
			change structurename = player2_status save_health = <p2_health>
			battlemode_killspawnedscripts
			if ScreenElementExists \{id = battlemode_container}
				DestroyScreenElement \{id = battlemode_container}
			endif
			change \{battle_sudden_death = 1}
		else
			battlemode_killspawnedscripts
			change \{battle_sudden_death = 0}
		endif
	endif
	KillSpawnedScript \{name = GuitarEvent_SongFailed_Spawned}
	spawnscriptnow \{GuitarEvent_SongWon_Spawned}
endscript

script GuitarEvent_SongWon_Spawned 
	if ($is_network_game)
		mark_unsafe_for_shutdown
		if ($shutdown_game_for_signin_change_flag = 1)
			return
		endif
		if ($ui_flow_manager_state [0] = online_pause_fs)
			net_unpausegh3
		endif
		KillSpawnedScript \{name = dispatch_player_state}
		if ($player2_present)
			SendNetMessage {
				type = net_win_song
				stars = ($player1_status.stars)
				note_streak = ($player1_status.best_run)
				notes_hit = ($player1_status.notes_hit)
				total_notes = ($player1_status.total_notes)
			}
		endif
		if NOT ($game_mode = p2_battle || $Cheat_NoFail = 1 || $Cheat_EasyExpert = 1)
			if ($game_mode = p2_coop)
				online_song_end_write_stats \{song_type = coop}
			else
				online_song_end_write_stats \{song_type = single}
			endif
		endif
	endif
	if ($is_attract_mode = 1)
		BlankScreen
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = exit_attract_mode
				play_sound = 0
			}}
		return
	endif
	if ($game_mode = training || $game_mode = tutorial)
		return
	endif
	if ($current_song = bossdevil && $devil_finish = 0)
		change \{devil_finish = 1}
	else
		change \{devil_finish = 0}
	endif
	Progression_EndCredits_Done
	PauseGame
	kill_start_key_binding
	if ($battle_sudden_death = 1)
		SoundEvent \{event = GH_SFX_BattleMode_Sudden_Death}
	else
		if ($game_mode = p1_career || $game_mode = p2_career || $game_mode = p2_coop || $game_mode = p1_quickplay)
			SoundEvent \{event = You_Rock_End_SFX}
		endif
	endif
	spawnscriptnow \{You_Rock_Waiting_Crowd_SFX}
	if ($game_mode = p2_battle || $boss_battle = 1)
		if ($player1_status.current_health >= $player2_status.current_health)
			if ($current_song = bossdevil)
				preload_movie = 'Satan-Battle_WIN'
			else
				SoundEvent \{event = GH_SFX_BattleMode_DeathOf_P2}
				preload_movie = 'Player1_wins'
			endif
		else
			if ($current_song = bossdevil)
				preload_movie = 'Satan-Battle_LOSS'
			else
				SoundEvent \{event = GH_SFX_BattleMode_DeathOf_P1}
				preload_movie = 'Player2_wins'
			endif
		endif
		if ($current_song = bossdevil && $devil_finish = 0)
			preload_movie = 'Golden_Guitar'
		endif
		if ($battle_sudden_death = 1)
			preload_movie = 'Fret_Flames'
		endif
		KillMovie \{TextureSlot = 1}
		FormatText checksumname = preload_movie_checksum '%s' s = <preload_movie>
		change g_you_rock_movie = <preload_movie_checksum>
	endif
	if NOT ($devil_finish = 1 || $battle_sudden_death = 1)
		spawnscriptnow \{wait_and_play_you_rock_movie}
	endif
	destroy_menu \{menu_id = yourock_text}
	destroy_menu \{menu_id = yourock_text_2}
	tie = false
	text_pos = (640.0, 360.0)
	rock_legend = 0
	fit_dims = (350.0, 0.0)
	if ($battle_sudden_death = 1)
		winner_text = 'Sudden Death!'
		winner_space_between = (30.0, 0.0)
		winner_scale = 1.3
	else
		if ($game_mode = p2_battle)
			p1_health = ($player1_status.current_health)
			p2_health = ($player2_status.current_health)
			if (<p2_health> > <p1_health>)
				winner = 'Two'
				SoundEvent \{event = UI_2ndPlayerWins_SFX}
			else
				winner = 'One'
				SoundEvent \{event = UI_1stPlayerWins_SFX}
			endif
			if ($is_network_game)
				if (<p2_health> > <p1_health>)
					name = ($opponent_gamertag)
				else
					NetSessionFunc \{obj = match
						func = get_gamertag}
				endif
				FormatText TextName = winner_text <name>
				<text_pos> = (640.0, 240.0)
			else
				FormatText TextName = winner_text 'Player %s Rocks!' s = <winner>
			endif
			winner_space_between = (25.0, 0.0)
			winner_scale = 1.0
		elseif ($game_mode = p2_faceoff || $game_mode = p2_pro_faceoff)
			p1_score = ($player1_status.score)
			p2_score = ($player2_status.score)
			if (<p2_score> > <p1_score>)
				winner = 'Two'
				SoundEvent \{event = UI_2ndPlayerWins_SFX}
			elseif (<p1_score> > <p2_score>)
				winner = 'One'
				SoundEvent \{event = UI_1stPlayerWins_SFX}
			else
				<tie> = true
				SoundEvent \{event = You_Rock_End_SFX}
			endif
			if (<tie> = true)
				winner_text = 'TIE!'
				winner_space_between = (40.0, 0.0)
				winner_scale = 2.0
			else
				if ($is_network_game)
					if (<p2_score> > <p1_score>)
						name = ($opponent_gamertag)
					else
						NetSessionFunc \{obj = match
							func = get_gamertag}
					endif
					FormatText TextName = winner_text <name>
					<text_pos> = (640.0, 240.0)
				else
					FormatText TextName = winner_text 'Player %s Rocks!' s = <winner>
				endif
				winner_space_between = (25.0, 0.0)
				winner_scale = 1.0
			endif
		else
			winner_text = 'You Rock!'
			winner_space_between = (45.0, 0.0)
			fit_dims = (350.0, 0.0)
			winner_scale = 3.5
		endif
		if ($devil_finish = 1)
			winner_text = 'Now Finish Him!'
			winner_space_between = (55.0, 0.0)
			winner_scale = 1.0
			winner_space_between = (<winner_space_between> * 0.5)
		endif
		if ($current_song = bossdevil && $devil_finish = 0)
			<rock_legend> = 1
			winner_text = 'YOU\'RE A'
			winner_space_between = (40.0, 0.0)
			winner_scale = 1.1
		endif
	endif
	StringLength string = <winner_text>
	<fit_dims> = (<str_len> * (23.0, 0.0))
	if (<fit_dims>.(1.0, 0.0) >= 350)
		<fit_dims> = (350.0, 0.0)
	endif
	if NOT English
		winner_space_between = (45.0, 0.0)
		winner_scale = 2.5
		if (<str_len> > 24)
			winner_space_between = (15.0, 0.0)
			winner_scale = 0.7
		elseif (<str_len> > 19)
			winner_space_between = (20.0, 0.0)
			winner_scale = 1.1
		elseif (<str_len> > 12)
			winner_space_between = (25.0, 0.0)
			winner_scale = 1.3
		elseif (<str_len> > 10)
			winner_space_between = (36.0, 0.0)
			winner_scale = 2.2
		endif
	endif
	split_text_into_array_elements {
		id = yourock_text
		text = <winner_text>
		text_pos = <text_pos>
		space_between = (<winner_space_between> * 2.0)
		flags = {
			rgba = [255 255 255 255]
			scale = (<winner_scale> * 2.0)
			z_priority = 95
			font = text_a10_large
			rgba = [223 223 223 255]
			just = [center center]
			alpha = 1
		}
		centered
	}
	if (<rock_legend> = 1)
		if NOT English
			temp_string = 'ROCK LEGEND!'
			StringLength string = <temp_string>
			winner_space_between = (47.0, 0.0)
			winner_scale = 2.6
			if (<str_len> > 24)
				winner_space_between = (15.0, 0.0)
				winner_scale = 0.7
			elseif (<str_len> > 19)
				winner_space_between = (20.0, 0.0)
				winner_scale = 1.1
			elseif (<str_len> > 12)
				winner_space_between = (25.0, 0.0)
				winner_scale = 1.3
			elseif (<str_len> > 10)
				winner_space_between = (36.0, 0.0)
				winner_scale = 2.2
			endif
		endif
		split_text_into_array_elements {
			id = yourock_text_legend
			text = 'ROCK LEGEND!'
			text_pos = (<text_pos> + (0.0, 120.0))
			space_between = (<winner_space_between> * 1.7)
			flags = {
				rgba = [255 255 255 255]
				scale = (<winner_scale> * 1.7)
				z_priority = 95
				font = text_a10_large
				rgba = [223 223 223 255]
				just = [center center]
				alpha = 1
			}
			centered
		}
	endif
	if (($is_network_game) && ($battle_sudden_death = 0) && (<tie> = false))
		if NOT ($game_mode = p2_coop)
			split_text_into_array_elements {
				id = yourock_text_2
				text = 'Rocks!'
				text_pos = (640.0, 380.0)
				fit_dims = <fit_dims>
				space_between = <winner_space_between>
				flags = {
					rgba = [255 255 255 255]
					scale = <winner_scale>
					z_priority = 95
					font = text_a10_large
					rgba = [223 223 223 255]
					just = [center center]
					alpha = 1
				}
				centered
			}
		endif
	endif
	if NOT ($devil_finish = 1 || $battle_sudden_death = 1)
		if ($current_song = bossslash || $current_song = bosstom || $current_song = bossdevil)
			boss_character = -1
			if ($current_song = bossslash)
				<boss_character> = 0
			elseif ($current_song = bosstom)
				<boss_character> = 1
			elseif ($current_song = bossdevil)
				<boss_character> = 2
			endif
			if (<boss_character> >= 0)
				unlocked_for_purchase = 1
				GetGlobalTags ($Secret_Characters [<boss_character>].id)
				if (<unlocked_for_purchase> = 0)
					spawnscriptnow \{Boss_Unlocked_Text
						params = {
							parent_id = yourock_text
						}}
					SetGlobalTags ($Secret_Characters [<boss_character>].id) params = {unlocked_for_purchase = 1}
				endif
			endif
		endif
	endif
	statsVenue = (($LevelZones.$current_level).name)
	statsSong = ($current_song)
	change \{old_song = none}
	if NOT ($devil_finish = 1)
		if NOT ($battle_sudden_death = 1)
			Progression_SongWon
			if ($current_transition = preencore)
				end_song
				UnPauseGame
				Transition_Play \{type = preencore}
				Transition_Wait
				change \{current_transition = none}
				PauseGame
				ui_flow_manager_respond_to_action \{action = preencore_win_song}
				encore_transition = 1
			elseif ($current_transition = preboss)
				end_song
				UnPauseGame
				Transition_Play \{type = preboss}
				Transition_Wait
				change \{current_transition = none}
				PauseGame
				change \{use_last_player_scores = 1}
				change old_song = ($current_song)
				change \{show_boss_helper_screen = 1}
				ui_flow_manager_respond_to_action \{action = preboss_win_song}
				if ($is_network_game = 0)
					if NOT ($boss_battle = 1)
						if NOT ($devil_finish)
							agora_write_stats
						endif
					endif
					net_write_single_player_stats
					SpawnScriptLater \{xenon_singleplayer_session_complete_uninit}
				endif
				return
			else
				UnPauseGame
				Transition_Play \{type = songwon}
				Transition_Wait
				change \{current_transition = none}
				PauseGame
			endif
		else
			UnPauseGame
			Transition_Play \{type = songwon}
			spawnscriptnow \{wait_and_play_you_rock_movie}
			KillSpawnedScript \{name = jiggle_text_array_elements}
			spawnscriptnow \{jiggle_text_array_elements
				params = {
					id = yourock_text
					time = 1.0
					wait_time = 3000
					explode = 1
				}}
			spawnscriptnow \{Sudden_Death_Helper_Text
				params = {
					parent_id = yourock_text
				}}
			Wait \{0.1
				seconds}
			spawnscriptnow \{waitAndKillHighway}
			Wait \{4
				seconds}
			change \{current_transition = none}
			PauseGame
		endif
	else
		UnPauseGame
		Transition_Play \{type = songwon}
		spawnscriptnow \{wait_and_play_you_rock_movie}
		KillSpawnedScript \{name = jiggle_text_array_elements}
		spawnscriptnow \{jiggle_text_array_elements
			params = {
				id = yourock_text
				time = 1.0
				wait_time = 2000
				explode = 1
			}}
		devil_finish_anim
		Wait \{0.15
			seconds}
		spawnscriptnow \{waitAndKillHighway}
		Wait \{2.5
			seconds}
		Wait \{0.5
			seconds}
		change \{current_transition = none}
		create_loading_screen
		PauseGame
	endif
	if ($end_credits = 1 && $current_song = bossdevil)
		Menu_Music_Off \{setflag = 1}
		get_movie_id_by_name \{movie = 'singleplayer_end'}
		SetGlobalTags <id> params = {unlocked = 1}
	endif
	if ($battle_sudden_death = 1)
		StopSoundEvent \{GH_SFX_BattleMode_Sudden_Death}

		change \{battle_sudden_death = 1}
		if ($is_network_game)
			ui_flow_manager_respond_to_action \{action = sudden_death_begin}
			SpawnScriptLater \{load_and_sync_timing
				params = {
					start_delay = 4000
					player_status = player1_status
				}}
		else
			ui_flow_manager_respond_to_action \{action = select_retry}
			spawnscriptnow \{restart_song
				params = {
					sudden_death = 1
				}}
		endif
		if ScreenElementExists \{id = yourock_text}
			DestroyScreenElement \{id = yourock_text}
		endif
	elseif ($end_credits = 1 && $current_song = impulse)
		destroy_menu \{menu_id = yourock_text}
		destroy_menu \{menu_id = yourock_text_2}
		change \{end_credits = 0}
		career_song_ended_select_quit
		start_flow_manager \{flow_state = career_credits_autosave_fs}
	elseif ($devil_finish = 1)
		start_devil_finish
	else
		destroy_menu \{menu_id = yourock_text}
		destroy_menu \{menu_id = yourock_text_2}
		destroy_menu \{menu_id = yourock_text_legend}
		BlankScreen
		ui_flow_manager_respond_to_action \{action = win_song}
	endif
	if ($is_network_game)

		WriteAchievements \{achievement = COMPLETEONLINE}
	endif
	if IsNgc
		if (($game_mode = p1_career) || ($game_mode = p2_career))
			agora_update
		endif
		if ($is_network_game && ($ranked_match = ranked))
			if IsHost
				agora_write_stats venue = <statsVenue> song = <statsSong>
			endif
		elseif NOT ($boss_battle = 1)
			if NOT ($devil_finish)
				agora_write_stats venue = <statsVenue> song = <statsSong>
			endif
		endif
		if ($is_network_game = 0)
			net_write_single_player_stats
		endif
	endif
	if (IsNgc)
		if ($is_network_game = 0)
			if NOT ($devil_finish = 1)
				if NOT ($battle_sudden_death = 1)
					if NOT GotParam \{encore_transition}
						spawnscriptnow \{xenon_singleplayer_session_complete_uninit}
					endif
				endif
			endif
		endif
	endif
	SoundEvent \{event = Crowd_Med_To_Good_SFX}
	if ($is_network_game)
		mark_safe_for_shutdown
	endif
endscript

script Sudden_Death_Helper_Text 
	FormatText \{checksumname = text_checksum
		'sudden_death_helper'}
	CreateScreenElement {
		type = TextElement
		id = <text_checksum>
		parent = <parent_id>
		pos = (640.0, 500.0)
		text = 'All powerups are death drain attacks!'
		font = text_a4
		scale = 0.8
		rgba = [255 255 255 255]
		just = [center bottom]
		z_priority = 500
	}
	FormatText \{checksumname = text_checksum2
		'sudden_death_helper2'}
	CreateScreenElement {
		type = TextElement
		id = <text_checksum2>
		parent = <parent_id>
		pos = (640.0, 540.0)
		text = 'Launch a devastating DEATH DRAIN!'
		font = text_a4
		scale = 0.8
		rgba = [255 255 255 255]
		just = [center bottom]
		z_priority = 500
	}
	Wait \{3
		seconds}
	doScreenElementMorph {
		id = <text_checksum>
		alpha = 0
		time = 1
	}
	doScreenElementMorph {
		id = <text_checksum2>
		alpha = 0
		time = 1
	}
endscript

script Boss_Unlocked_Text 
	if ($current_song = bosstom)
		FormatText \{TextName = boss
			'Tom Morello'}
		pos = (634.0, 580.0)
	elseif ($current_song = bossslash)
		pos = (634.0, 580.0)
		FormatText \{TextName = boss
			'Slash'}
	elseif ($current_song = bossdevil)
		pos = (800.0, 580.0)
		FormatText \{TextName = boss
			'Lou'}
	endif
	FormatText \{TextName = unlocked
		'unlocked'}
	FormatText \{TextName = visit_store
		'VISIT STORE'}
	FormatText TextName = text '%s %b, %v' s = <boss> b = <unlocked> v = <visit_store>
	FormatText \{checksumname = boss_unlocked
		'boss_unlocked'}
	if ScreenElementExists id = <boss_unlocked>
		DestroyScreenElement id = <boss_unlocked>
	endif
	CreateScreenElement {
		type = TextElement
		id = <boss_unlocked>
		parent = <parent_id>
		pos = <pos>
		text = <text>
		font = text_a11
		scale = 1.1
		rgba = [255 255 255 255]
		just = [center bottom]
		z_priority = 500
		shadow
		shadow_offs = (1.0, 1.0)
		shadow_rgba = [0 0 0 255]
	}
	Wait \{3
		seconds}
	if ScreenElementExists id = <boss_unlocked>
		doScreenElementMorph {
			id = <boss_unlocked>
			alpha = 0
			time = 1
		}
	endif
endscript
devil_die_unique_id = null

script start_devil_finish 
	change \{end_credits = 0}
	marker_count = 37
	get_song_prefix song = ($current_song)
	FormatText checksumname = marker_array '%s_markers' s = <song_prefix>
	StartTime = ($<marker_array> [<marker_count>].time)
	startmarker = <marker_count>
	change \{CameraCuts_ForceTime = 0}
	stoprendering
	restart_gem_scroller song_name = ($current_song) difficulty = ($current_difficulty) difficulty2 = ($current_difficulty2) StartTime = <StartTime> startmarker = <startmarker> no_render = 1 devil_finish_restart = 1
	destroy_loading_screen
	PreloadSoundStream \{filename = 'OTHER\\WLA\\DEVILDIE'
		samplerate = 33075
		stereo = true}
	change devil_die_unique_id = <unique_id>
	waitforpreload_stream \{stream = devil_die_unique_id}
	StartPreloadedStream \{$devil_die_unique_id}
	devil_lose_anim
	Wait \{20
		frames}
	startrendering
	if ScreenElementExists \{id = yourock_text}
		DestroyScreenElement \{id = yourock_text}
	endif
	if ScreenElementExists \{id = yourock_text_legend}
		DestroyScreenElement \{id = yourock_text_legend}
	endif
endscript

script devil_finish_anim 
	WaitOneGameFrame
	bassist :Obj_SwitchScript \{Transition_PlayAnim_Spawned
		params = {
			Anim = GH3_Guit_Satn_A_Lose02
		}}
	change \{CameraCuts_AllowNoteScripts = false}
	change \{CameraCuts_ForceTime = 3.2}
	CameraCuts_SetArrayPrefix \{prefix = 'cameras_boss_finish'
		length = 0
		changenow}
	spawnscriptnow \{devil_camera_flash}
endscript

script devil_camera_flash 
	Wait \{2.7
		seconds}
	fadetoblack \{on
		time = 0.03
		alpha = 1.0
		z_priority = 1000
		texture = white
		rgba = [
			255
			255
			255
			255
		]}
	Wait \{0.04
		seconds}
	SoundEvent \{event = Song_Intro_Kick_SFX}
	SoundEvent \{event = Practice_Mode_Crash2}
	fadetoblack \{off}
endscript

script devil_lose_anim 
	change \{CameraCuts_AllowNoteScripts = false}
	CameraCuts_SetArrayPrefix \{prefix = 'cameras_boss_dead'
		length = 0
		changenow}
	bassist :Obj_SwitchScript \{Transition_PlayAnim_Spawned
		params = {
			Cycle = 1
			stance = lose
			Anim = GH3_Guit_Satn_A_Lose03
		}}
endscript
g_you_rock_movie = none

script create_you_rock_effect \{player_status = player1_status}
	CreateScreenElement \{type = ContainerElement
		id = you_rock_effect_container
		parent = root_window
		pos = (0.0, 0.0)}
	you_rock_effect_time = 0.8
	htx = (640.0 - ($highway_top_width / 2.0))
	gts = ($highway_top_width / 5.0)
	gsx = (<htx> + (<gts> / 2.0) + (<gts> * 0.0))
	rsx = (<htx> + (<gts> / 2.0) + (<gts> * 1.0))
	ysx = (<htx> + (<gts> / 2.0) + (<gts> * 2.0))
	bsx = (<htx> + (<gts> / 2.0) + (<gts> * 3.0))
	osx = (<htx> + (<gts> / 2.0) + (<gts> * 4.0))
	hbw = ($highway_top_width + ($highway_top_width * $widthOffsetFactor))
	hbx = (640.0 - (<hbw> / 2.0))
	gbs = (<hbw> / 5.0)
	gex = (<hbx> + (<gbs> / 2.0) + (<gbs> * 0.0))
	rex = (<hbx> + (<gbs> / 2.0) + (<gbs> * 1.0))
	yex = (<hbx> + (<gbs> / 2.0) + (<gbs> * 2.0))
	bex = (<hbx> + (<gbs> / 2.0) + (<gbs> * 3.0))
	oex = (<hbx> + (<gbs> / 2.0) + (<gbs> * 4.0))
	begin_x_positions = [0.0 0.0 0.0 0.0 0.0]
	end_x_positions = [0.0 0.0 0.0 0.0 0.0]
	SetArrayElement ArrayName = begin_x_positions index = 0 newvalue = <gsx>
	SetArrayElement ArrayName = begin_x_positions index = 1 newvalue = <rsx>
	SetArrayElement ArrayName = begin_x_positions index = 2 newvalue = <ysx>
	SetArrayElement ArrayName = begin_x_positions index = 3 newvalue = <bsx>
	SetArrayElement ArrayName = begin_x_positions index = 4 newvalue = <osx>
	SetArrayElement ArrayName = end_x_positions index = 0 newvalue = <gex>
	SetArrayElement ArrayName = end_x_positions index = 1 newvalue = <rex>
	SetArrayElement ArrayName = end_x_positions index = 2 newvalue = <yex>
	SetArrayElement ArrayName = end_x_positions index = 3 newvalue = <bex>
	SetArrayElement ArrayName = end_x_positions index = 4 newvalue = <oex>
	flame_colors = [[255 255 255 255] [255 64 64 255] [255 156 93 255] [180 100 30 255] [170 26 26 255]]
	flame_frame_length = [0.25 0.1 0.15 0.3 0.05]
	flame_scales = [(1.2, 0.8) (1.8, 1.2) (0.8, 0.4) (1.0, 0.9) (0.7, 0.7)]
	flame_z_priorities = [9.1 9.2 9.3 9.4 9.5]
	you_rock_effects = [flames flames]
	p1_score = ($player1_status.score)
	p2_score = ($player2_status.score)
	if ($current_num_players = 2)
		if NOT (($game_mode = p2_career) || ($battle_sudden_death = 1))
			if (<p1_score> < <p2_score>)
				SetArrayElement \{ArrayName = you_rock_effects
					index = 0
					newvalue = lightning}
			endif
			if (<p2_score> < <p1_score>)
				SetArrayElement \{ArrayName = you_rock_effects
					index = 1
					newvalue = lightning}
			endif
		endif
	endif
	spawnscriptnow you_rock_wait_and_kill_highway params = {wait_time = <you_rock_effect_time>}
	player = 0
	player_count = ($current_num_players)
	begin
	if ($current_num_players = 1)
		effect_x_offset = 0
	else
		if (<player> = 0)
			effect_x_offset = (0 - $x_offset_p2)
		else
			effect_x_offset = ($x_offset_p2)
		endif
	endif
	if (<you_rock_effects> [<player>] = flames)
		index = 0
		count = 5
		begin
		flame_begin_pos = ((1.0, 0.0) * (<begin_x_positions> [<index>] + <effect_x_offset>) + (0.0, 1.0) * ($highway_playline - $highway_height))
		flame_end_pos = ((1.0, 0.0) * (<end_x_positions> [<index>] + <effect_x_offset>) + (0.0, 1.0) * (720))
		GetRandomValue \{name = flame_random_index
			a = 1
			b = 4
			Integer}
		flame_scale = (1.8, 1.2)
		CreateScreenElement {
			type = SpriteElement
			parent = you_rock_effect_container
			use_animated_uvs = true
			top_down_v
			frame_length = (<flame_frame_length> [<flame_random_index>])
			num_uv_frames = (2.0, 2.0)
			dims = (96.0, 192.0)
			just = [center bottom]
			pos = <flame_begin_pos>
			scale = (<flame_scale> * 0.25)
			z_priority = (<flame_z_priorities> [0])
			rgba = (<flame_colors> [<flame_random_index>])
			texture = JOW_StatueFlames01_Sprite
		}
		RunScriptOnScreenElement id = <id> you_rock_flame_script params = {time = <you_rock_effect_time> pos = <flame_end_pos> scale = (<flame_scale> * 4.2 * 0.25)}
		flame_index = 1
		flame_count = 4
		begin
		GetRandomValue \{name = flame_random_index
			a = 0
			b = 4
			Integer}
		flame_scale = (<flame_scales> [<flame_index>])
		CreateScreenElement {
			type = SpriteElement
			parent = you_rock_effect_container
			blend = Add
			use_animated_uvs = true
			top_down_v
			frame_length = (<flame_frame_length> [<flame_random_index>])
			num_uv_frames = (2.0, 2.0)
			dims = (96.0, 192.0)
			just = [center bottom]
			pos = <flame_begin_pos>
			scale = (<flame_scale> * 0.25)
			z_priority = (<flame_z_priorities> [<flame_index>])
			rgba = (<flame_colors> [<flame_random_index>])
			texture = JOW_StatueFlames01_Sprite
		}
		RunScriptOnScreenElement id = <id> you_rock_flame_script params = {time = <you_rock_effect_time> pos = <flame_end_pos> scale = (<flame_scale> * 3.8 * 0.25)}
		flame_index = (<flame_index> + 1)
		repeat <flame_count>
		index = (<index> + 1)
		repeat <count>
	else
		spawnscriptnow you_rock_lightning_effect params = {<...>}
	endif
	player = (<player> + 1)
	repeat <player_count>
	Wait (<you_rock_effect_time> + 0.6) seconds
	KillSpawnedScript \{name = you_rock_lightning_effect}
	DestroyScreenElement \{id = you_rock_effect_container}
endscript

script you_rock_lightning_effect 
	if (<player> = 0)
		highway_container = gem_containerp1
	else
		highway_container = gem_containerp2
	endif
	GetScreenElementPosition id = <highway_container>
	start_highway_y = ((0.0, 1.0).<screenelementpos>)
	spawnscriptnow lightning_effect_jitter_highway params = {highway_id = <highway_container> time = <you_rock_effect_time>}
	lightning_delay = 0.02
	lightning_strikes = (<you_rock_effect_time> / <lightning_delay>)
	CastToInteger \{lightning_strikes}
	y_diff = (720 - ($highway_playline - $highway_height))
	begin
	GetRandomValue \{name = lightning_strike_x_index
		a = 0
		b = 4
		Integer}
	GetRandomValue \{name = lightning_strike_y_ratio
		a = 0
		b = 1}
	x_diff = (<end_x_positions> [<lightning_strike_x_index>] - <begin_x_positions> [<lightning_strike_x_index>])
	x_pos = (<begin_x_positions> [<lightning_strike_x_index>] + <lightning_strike_y_ratio> * <x_diff>)
	x_pos = (<x_pos> + <effect_x_offset>)
	y_pos = (($highway_playline - $highway_height) + <lightning_strike_y_ratio> * <y_diff>)
	GetScreenElementPosition id = <highway_container>
	additional_y_offset = (<start_highway_y> - <screenelementpos>.(0.0, 1.0))
	y_pos = (<y_pos> + <additional_y_offset>)
	CreateScreenElement {
		type = SpriteElement
		parent = you_rock_effect_container
		use_animated_uvs = true
		blend = Add
		top_down_v
		frame_length = 0.005
		num_uv_frames = (8.0, 1.0)
		just = [center bottom]
		pos = ((1.0, 0.0) * <x_pos> + (0.0, 1.0) * <y_pos>)
		z_priority = 10
		texture = sys_Big_Bolt01_sys_Big_Bolt01
	}
	Wait (<lightning_delay>) seconds
	if ScreenElementExists id = <id>
		DestroyScreenElement id = <id>
	endif
	repeat <lightning_strikes>
endscript

script you_rock_wait_and_kill_highway \{wait_time = 0.0}
	if NOT ($devil_finish = 1 || $battle_sudden_death = 1)
		KillSpawnedScript \{name = jiggle_text_array_elements}
		SpawnScriptLater \{jiggle_text_array_elements
			params = {
				id = yourock_text
				time = 1.0
				wait_time = 3000
				explode = 1
			}}
		if ($current_song = bossdevil && $devil_finish = 0)
			SpawnScriptLater \{jiggle_text_array_elements
				params = {
					id = yourock_text_legend
					time = 1.0
					wait_time = 3000
					explode = 1
				}}
		endif
		if ($is_network_game)
			SpawnScriptLater \{jiggle_text_array_elements
				params = {
					id = yourock_text_2
					time = 1.0
					wait_time = 3000
					explode = 1
				}}
		endif
		Wait (<wait_time>) seconds
		spawnscriptnow \{instantKillHighway}
	endif
endscript

script you_rock_flame_script 
	DoMorph time = <time> pos = <pos> scale = <scale>
	Wait \{0.4
		seconds}
	DoMorph \{time = 0.2
		alpha = 0
		scale = 0.001}
endscript

script lightning_effect_jitter_highway 
	spawnscriptnow lightning_effect_jitter_highway_spawned params = {highway_id = <highway_id>}
	Wait <time> seconds
	KillSpawnedScript \{name = lightning_effect_jitter_highway_spawned}
endscript

script lightning_effect_jitter_highway_spawned 
	begin
	GetScreenElementPosition id = <highway_id>
	GetRandomValue \{name = x_offset
		a = -10
		b = 10}
	GetRandomValue \{name = y_offset
		a = 0
		b = 10}
	<screenelementpos> = (<screenelementpos> + (1.0, 0.0) * <x_offset> + (0.0, 1.0) * (<y_offset>))
	doScreenElementMorph time = 0 id = <highway_id> pos = <screenelementpos>
	Wait \{0.05
		seconds}
	repeat
endscript

script wait_and_play_you_rock_movie 
	if ($is_network_game = 1)
		if ($player2_present = 1)
			create_you_rock_effect
		endif
	else
		create_you_rock_effect
	endif
endscript

script waitAndKillHighway \{wait_time = 0.5}
	Wait (<wait_time>) seconds
	SoundEvent \{event = Crowd_Fast_Surge_Cheer}
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player> AddToStringLookup
	FormatText TextName = player_text 'p%i' i = <player> AddToStringLookup
	move_highway_camera_to_default_off <...> time = ($current_intro.highway_move_time / 1000.0)
	player = (<player> + 1)
	repeat $current_num_players
endscript

script instantKillHighway 
	SoundEvent \{event = Crowd_Fast_Surge_Cheer}
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player> AddToStringLookup
	FormatText TextName = player_text 'p%i' i = <player> AddToStringLookup
	move_highway_camera_to_default_off <...> time = 0.005
	player = (<player> + 1)
	repeat $current_num_players
endscript

script GuitarEvent_crowd_poor_medium 
endscript

script GuitarEvent_crowd_medium_good 
endscript

script GuitarEvent_crowd_medium_poor 
endscript

script GuitarEvent_crowd_good_medium 
endscript

script GuitarEvent_StarHitNote 
endscript

script GuitarEvent_StarSequenceBonus 
	wait_for_correct_frame player = ($<player_status>.player)
	if ($is_attract_mode = 1)
		return
	endif
	change structurename = <player_status> sp_phrases_hit = ($<player_status>.sp_phrases_hit + 1)
	SoundEvent \{event = Star_Power_Awarded_SFX}
	FormatText checksumname = container_id 'gem_container%p' p = ($<player_status>.text) AddToStringLookup = true
	GetArraySize \{$gem_colors}
	gem_count = 0
	begin
	<note> = ($<song> [<array_entry>] [(<gem_count> + 1)])
	if (<note> > 0)
		color = ($gem_colors [<gem_count>])
		if ($<player_status>.lefthanded_button_ups = 1)
			<pos2d> = ($button_up_models.<color>.left_pos_2d)
			<Angle> = ($button_models.<color>.Angle)
		else
			<pos2d> = ($button_up_models.<color>.pos_2d)
			<Angle> = ($button_models.<color>.left_angle)
		endif
		FormatText checksumname = name 'big_bolt%p%e' p = ($<player_status>.text) e = <gem_count> AddToStringLookup = true
		CreateScreenElement {
			type = SpriteElement
			id = <name>
			parent = <container_id>
			material = sys_Big_Bolt01_sys_Big_Bolt01
			blend = Add
			use_animated_uvs = true
			top_down_v
			frame_length = 0.005
			num_uv_frames = (8.0, 1.0)
			rgba = [255 255 255 255]
			pos = <pos2d>
			rot_angle = <Angle>
			scale = (0.5 * $star_power_bolt_scale)
			just = [center bottom]
			z_priority = 6
		}
	endif
	gem_count = (<gem_count> + 1)
	repeat <array_size>
	Wait \{$star_power_bolt_time
		seconds}
	gem_count = 0
	begin
	<note> = ($<song> [<array_entry>] [(<gem_count> + 1)])
	if (<note> > 0)
		FormatText checksumname = name 'big_bolt%p%e' p = ($<player_status>.text) e = <gem_count> AddToStringLookup = true
		DestroyScreenElement id = <name>
		WaitOneGameFrame
	endif
	gem_count = (<gem_count> + 1)
	repeat <array_size>
endscript

script GuitarEvent_StarMissNote 
endscript

script GuitarEvent_Multiplier4xOn 
endscript

script GuitarEvent_Multiplier4xOn_Spawned 
endscript

script GuitarEvent_Multiplier3xOn 
endscript

script GuitarEvent_Multiplier2xOn 
endscript

script kill_4x_fx 
endscript

script GuitarEvent_Multiplier4xOff 
	SoundEvent \{event = UI_SFX_Lose_Multiplier_4X}
	SoundEvent \{event = Lose_Multiplier_Crowd}
	spawnscriptnow highway_pulse_multiplier_loss params = {player_text = ($<player_status>.text) multiplier = 4}
	kill_4x_fx <...>
endscript

script GuitarEvent_Multiplier3xOff 
	SoundEvent \{event = UI_SFX_Lose_Multiplier_3X}
	spawnscriptnow highway_pulse_multiplier_loss params = {player_text = ($<player_status>.text) multiplier = 3}
endscript

script GuitarEvent_Multiplier2xOff 
	SoundEvent \{event = UI_SFX_Lose_Multiplier_2X}
	spawnscriptnow highway_pulse_multiplier_loss params = {player_text = ($<player_status>.text) multiplier = 2}
endscript

script GuitarEvent_KillSong 
	GH3_SFX_Stop_Sounds_For_KillSong
	GH_Star_Power_Verb_Off
	FormatText \{checksumname = player_status
		'player1_status'}
	kill_4x_fx player_status = <player_status>
	FormatText \{checksumname = player_status
		'player2_status'}
	kill_4x_fx player_status = <player_status>
endscript

script GuitarEvent_EnterVenue 
	GetPakManCurrentName \{map = zones}
	FormatText checksumname = echo_params 'Echo_Crowd_Buss_%s' s = <pakname>
	FormatText checksumname = reverb_params 'Reverb_Crowd_Buss_%s' s = <pakname>
	if NOT GlobalExists name = <echo_params>
		echo_params = Echo_Crowd_Buss_Default
	endif
	if NOT GlobalExists name = <reverb_params>
		reverb_params = Reverb_Crowd_Buss_Default
	endif
	setsoundbusseffects effect = $<echo_params>
	setsoundbusseffects effect = $<reverb_params>
endscript

script GuitarEvent_ExitVenue 
	setsoundbusseffects \{effect = $Echo_Crowd_Buss}
	setsoundbusseffects \{effect = $Reverb_Crowd_Buss}
endscript

script GuitarEvent_CreateFirstGem 
endscript

script destroy_first_gem_fx 
endscript

script GuitarEvent_GemStarPowerOn 
endscript

script GuitarEvent_BattleAttackFinished 
	GH3_Battle_Attack_Finished_SFX <...>
	Reset_Battle_DSP_Effects <...>
endscript

script GuitarEvent_TransitionIntro 
endscript

script GuitarEvent_TransitionFastIntro 
endscript

script GuitarEvent_TransitionPreEncore 
endscript

script GuitarEvent_TransitionEncore 
endscript

script GuitarEvent_TransitionPreBoss 
endscript

script GuitarEvent_TransitionBoss 
endscript
