button_values = [
	65536
	4096
	256
	16
	1
	0
]
hammer_on_measure_scale = 0

script check_buttons_fast 
	get_song_prefix song = <song_name>
	FormatText checksumname = guitar_stream '%s_guitar' s = <song_prefix> AddToStringLookup
	GuitarInputLogicInit player_status = <player_status> guitar_stream = <guitar_stream> time_offset = <time_offset>
	begin
	if ($ui_flow_manager_state [(<player> -1)] = online_pause_fs)
		SetInput controller = ($<player_status>.controller) pattern = 0 strum = 0
	endif
	if NOT GuitarInputLogicPerFrame player = <player>
		break
	endif
	WaitOneGameFrame
	repeat
endscript
p1_star_ready = 0
p2_star_ready = 0

script bot_star_power \{player_status = player1_status}
	change structurename = <player_status> bot_star_power = 1
endscript

script strip_single_note_strum 
	stripped_strum = <pattern>
	if (<required_pattern> && 4096)
		<stripped_strum> = (<pattern> && 4369)
	endif
	if (<required_pattern> && 256)
		<stripped_strum> = (<pattern> && 273)
	endif
	if (<required_pattern> && 16)
		<stripped_strum> = (<pattern> && 17)
	endif
	if (<required_pattern> && 1)
		<stripped_strum> = (<pattern> && 1)
	endif
	return stripped_strum = <stripped_strum>
endscript
button_up_pixel_arrayp1 = [
	0.0
	0.0
	0.0
	0.0
	0.0
]
button_up_pixel_arrayp2 = [
	0.0
	0.0
	0.0
	0.0
	0.0
]

script button_checker 
	ButtonCheckerInit <...>
	begin
	ButtonCheckerPerFrame
	if ($display_debug_input = 1)
		input_debug <...>
	endif
	WaitOneGameFrame
	repeat
	ButtonCheckerCleanup
endscript
currently_holding = [
	0
	0
]

script check_note_hold 
	<index> = (<player> - 1)
	begin
	if ($currently_holding [<index>] = 0)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	SetArrayElement ArrayName = currently_holding GlobalArray index = <index> newvalue = 1
	CheckNoteHoldInit player = <player> player_status = <player_status> array_entry = <array_entry> time = <time> guitar_stream = <guitar_stream> song = <song> pattern = <pattern>
	begin
	if NOT CheckNoteHoldWait player = <player>
		break
	endif
	WaitOneGameFrame
	repeat
	CheckNoteHoldStart player = <player>
	begin
	if NOT CheckNoteHoldPerFrame player = <player>
		break
	endif
	WaitOneGameFrame
	repeat
	CheckNoteHoldEnd player = <player>
	SetArrayElement ArrayName = currently_holding GlobalArray index = <index> newvalue = 0
endscript

script single_note 
	if (<pattern> = 65536)
		return \{true}
	endif
	if (<pattern> = 4096)
		return \{true}
	endif
	if (<pattern> = 256)
		return \{true}
	endif
	if (<pattern> = 16)
		return \{true}
	endif
	if (<pattern> = 1)
		return \{true}
	endif
	return \{false}
endscript

script check_for_star_power_fast 
	change \{p1_star_ready = 0}
	change \{p2_star_ready = 0}
	change structurename = <player_status> star_power_usable = 1
	CheckForStarPowerInit <...>
	begin
	if NOT ($game_mode = p2_career || $game_mode = p2_coop)
		begin
		if ($<player_status>.star_power_usable = 1)
			break
		endif
		WaitOneGameFrame
		repeat
	endif
	WaitOneGameFrame
	if NOT ($ui_flow_manager_state [(<player> -1)] = online_pause_fs)
		CheckForStarPowerPerFrame <...>
	endif
	repeat
endscript

script check_for_star_power 
	check_for_star_power_cfunc_setup
	begin
	if check_for_star_power_cfunc
		break
	else
		if GotParam \{ScriptToRun}
			<ScriptToRun> <ScriptToRun_Params>
		else
			Wait \{1
				gameframe}
		endif
	endif
	repeat
	check_for_star_power_cfunc_cleanup
endscript

script print_guitar_analogue_info 
	GuitarGetAnalogueInfo controller = ($primary_controller)

endscript

script wait_for_inactive 
	change structurename = <player_status> star_power_usable = 0
	<frames_under> = 0
	controller = ($<player_status>.controller)
	if IsGuitarController controller = <controller>
		if (<guitar_used_select> = 0)
			begin
			WaitOneGameFrame
			if GuitarGetAnalogueInfo controller = <controller>
				if (<VerticalDist> > 128.0)
					Increment \{frames_under}
					if (<frames_under> >= 30)
						break
					endif
				endif
			endif
			repeat
		else
			<guitar_used_select> = 0
		endif
	endif
	change structurename = <player_status> star_power_usable = 1
endscript

script star_power_activate_and_drain 
	change structurename = <player_status> star_power_used = 1
	change structurename = <player_status> num_star_power_used = ($<player_status>.num_star_power_used + 1)
	if IsNgc
		ActivateStarPowerPulse player = ($<player_status>.controller) num = 1 length = 40 strength = 8 priority = 100
	endif
	spawnscriptnow hud_activated_star_power params = {player = <player>}
	WaitOneGameFrame
	LaunchGemEvent event = star_power_on player = <player>
	ExtendCRC star_power_on <player_text> out = type
	BroadcastEvent type = <type> data = {player_text = <player_text> player = <player> player_status = <player_status>}
	spawnscriptnow \{Crowd_AllPlayAnim
		params = {
			Anim = starpower
		}}
	begin
	WaitOneGameFrame
	if ($game_mode = p2_career || $game_mode = p2_coop)
		drain = ($star_power_drain_rate_coop * 1000.0 * ($current_deltatime / $<player_status>.playline_song_measure_time))
	elseif ($game_mode = tutorial)
		drain = 0
	else
		drain = ($star_power_drain_rate * 1000.0 * ($current_deltatime / $<player_status>.playline_song_measure_time))
	endif
	change structurename = <player_status> star_power_amount = ($<player_status>.star_power_amount - <drain>)
	if ($<player_status>.star_power_amount <= 0)
		change structurename = <player_status> star_power_amount = 0
		break
	endif
	repeat
	spawnscriptnow \{Crowd_AllPlayAnim
		params = {
			Anim = Idle
		}}
	if ($<player_status>.controller = $primary_controller)
		change gStar_Power_Triggered = ($gStar_Power_Triggered + 1)
	endif
	change structurename = <player_status> star_power_used = 0
	UpdateNixie player = <player>
	WaitOneGameFrame
	LaunchGemEvent event = star_power_off player = <player>
	ExtendCRC star_power_off <player_text> out = type
	BroadcastEvent type = <type> data = {player_text = <player_text> player_status = <player_status>}
	<do_star> = 0
	return <...>
endscript
g_bot_whammy_theta = 0.0
g_bot_whammy_theta_add = 0.0

script control_whammy_pitchshift 
	if ($boss_battle = 1)
		if (($<player_status>.player) = 2)
			return
		endif
	endif
	<set_pitch> = 0
	if GotParam \{net_whammy_length}
		<len> = <net_whammy_length>
		<set_pitch> = 1
	else
		if GuitarGetAnalogueInfo controller = ($<player_status>.controller)
			<set_pitch> = 1
			if ($<player_status>.bot_play = 1)
				<len> = 0.0
				if ($g_bot_whammy_theta_add > 0.0)
					change g_bot_whammy_theta = ($g_bot_whammy_theta + $g_bot_whammy_theta_add)
					sin \{$g_bot_whammy_theta}
					<len> = ((<sin> + 1.0) / 2.0)
				endif
			elseif IsGuitarController controller = ($<player_status>.controller)
				<len> = ((<rightx> - $<player_status>.resting_whammy_position) / (1.0 - $<player_status>.resting_whammy_position))
				if (<len> < 0.0)
					<len> = 0.0
				endif
			else
				if IsNgc
					<len> = (<rightx>)
				else
					if (<leftlength> > 0)
						<len> = <leftlength>
					else
						if (<rightlength> > 0)
							<len> = <rightlength>
						else
							<len> = 0
						endif
					endif
				endif
			endif
			if (($is_network_game) && ($<player_status>.player = 1))
				change structurename = <player_status> net_whammy = <len>
			endif
		endif
	endif
	if (<set_pitch> = 1)
		set_whammy_pitchshift control = <len> player_status = <player_status>
		<whammy_scale> = (((<len> * 0.5) + 0.5) * 2.0)
		SetNewWhammyValue value = <whammy_scale> time_remaining = <time> player_status = <player_status> player = (<player_status>.player)
	endif
endscript

script reset_whammy_pitchshift 
	set_whammy_pitchshift control = 0.0 player_status = <player_status>
	SetAllWhammyValues value = 1.0 player = <player>
	ResetWhammyPitchShift \{$guitar_player1_unique_id}
endscript

script boss_play_on 
	change \{boss_play = 1}
	vol = 0
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player> AddToStringLookup
	change structurename = <player_status> guitar_volume = 100
	player = (<player> + 1)
	repeat $current_num_players
	update_guitar_volume_cfunc
endscript

script boss_play_off 
	change \{boss_play = 0}
endscript

script record_input 
	if GameIsPaused
		return
	endif
	GetDeltaTime
	DataBufferPutFloat name = replay value = <delta_time>
	RecordInput \{name = replay}
endscript

script playback_timer 
	if ($replay_suspend = 1)
		return
	endif
	if GameIsPaused
		return
	endif
	if DataBufferGetFloat \{name = replay}
		SetDeltaTime delta_time = <float>
	endif
endscript

script save_replay 
	destroy_debugging_menu
	CreateScreenElement \{type = TextElement
		parent = root_window
		id = info_text
		font = text_a1
		pos = (640.0, 32.0)
		just = [
			center
			top
		]
		scale = 1.0
		rgba = [
			210
			210
			210
			250
		]
		text = 'Saving replay'
		z_priority = 1.0}
	Wait \{2
		gameframes}
	get_difficulty_text_nl difficulty = ($current_difficulty)
	get_song_prefix song = ($current_song)
	FormatText TextName = filename 'replay_%s_%d' s = <song_prefix> d = <difficulty_text_nl>
	WriteDataBuffer name = replay filename = <filename>
	DestroyScreenElement \{id = info_text}
	create_debugging_menu
endscript

script autodetectleftys 
	change structurename = <player_status> lefthanded = 0
	change structurename = <player_status> lefthanded_gems = ($<player_status>.lefthanded)
	change structurename = <player_status> lefthanded_button_ups = ($<player_status>.lefthanded)
endscript
resting_whammy_tolerance = 0.1

script is_whammy_resting 
	if GotParam \{controller}
		get_resting_whammy_position <...>
	else
		controller = ($<player_status>.controller)
		resting_whammy_position = ($<player_status>.resting_whammy_position)
	endif
	if GuitarGetAnalogueInfo controller = <controller>
		if (<rightx> < <resting_whammy_position>)
			return \{true}
		elseif ((<rightx> - <resting_whammy_position>) < ($resting_whammy_tolerance))
			return \{true}
		endif
	endif
	return \{false}
endscript

script get_resting_whammy_position 
	GetGlobalTags \{user_options}
	switch (<controller>)
		case 0
		return resting_whammy_position = <resting_whammy_position_device_0>
		case 1
		return resting_whammy_position = <resting_whammy_position_device_1>
		case 2
		return resting_whammy_position = <resting_whammy_position_device_2>
		case 3
		return resting_whammy_position = <resting_whammy_position_device_3>
		case 4
		return resting_whammy_position = <resting_whammy_position_device_4>
		case 5
		return resting_whammy_position = <resting_whammy_position_device_5>
		case 6
		return resting_whammy_position = <resting_whammy_position_device_6>
	endswitch
endscript

script get_star_power_position 
	GetGlobalTags \{user_options}
	switch (<controller>)
		case 0
		return star_power_position = <star_power_position_device_0>
		case 1
		return star_power_position = <star_power_position_device_1>
		case 2
		return star_power_position = <star_power_position_device_2>
		case 3
		return star_power_position = <star_power_position_device_3>
		case 4
		return star_power_position = <star_power_position_device_4>
		case 5
		return star_power_position = <star_power_position_device_5>
		case 6
		return star_power_position = <star_power_position_device_6>
	endswitch
endscript

script dragonforce_hack_on 
	change \{dragonforce_hack = 1}
endscript

script dragonforce_hack_off 
	change \{dragonforce_hack = 0}
endscript
