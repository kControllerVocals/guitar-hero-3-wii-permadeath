
script create_strap_screen 
	create_menu_backdrop \{texture = strap_screen
		dims = (1280.0, 720.0)}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = pab_container
		pos = (0.0, 0.0)}
	spawnscriptnow \{strap_screen_check_for_any_input}
endscript

script destroy_strap_screen 
	destroy_menu \{menu_id = pab_container}
	destroy_menu_backdrop
	KillSpawnedScript \{name = strap_screen_check_for_any_input}
endscript

script create_press_any_button_menu 
	ReAcquireControllers
	change \{primary_controller_assigned = 0}
	SoundEvent \{event = Menu_Guitar_Lick_SFX}
	spawnscriptnow \{menu_music_on
		params = {
			waitforguitarlick = 1
			setflag = 1
		}}
	create_menu_backdrop \{texture = bootup_copyright_bg}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = pab_container
		pos = (0.0, 0.0)}
	menu_press_any_button_create_obvious_text
	spawnscriptnow \{check_for_any_input}
	if NotCD
		if ($show_movies = 0)
			return
		endif
	endif
	spawnscriptnow \{attract_mode_spawner}
endscript

script destroy_press_any_button_menu 
	destroy_menu \{menu_id = pab_container}
	destroy_menu_backdrop
	KillSpawnedScript \{name = check_for_any_input}
	KillSpawnedScript \{name = attract_mode_spawner}
endscript

script attract_mode_spawner 
	wait_time = 30
	begin

	if (<wait_time> = 0)
		break
	endif
	Wait \{1
		second}
	wait_time = (<wait_time> - 1)
	repeat
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = enter_attract_mode
			play_sound = 0
		}}
endscript
Attract_Mode_Info = [
	{
		level = load_z_budokan
		song = cherubrock
		mode = p1_quickplay
		p1_character_id = Midori
		p2_character_id = judy
		p1_instrument_id = Instrument_SG_Goddess_Blue
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 2
		p2_outfit = 1
		p1_style = 3
		p2_style = 1
	}
	{
		level = load_z_artdeco
		song = evenflow
		mode = p1_quickplay
		p1_character_id = judy
		p2_character_id = Casey
		p1_instrument_id = Instrument_Firebird_Blue
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 2
		p2_outfit = 1
		p1_style = 3
		p2_style = 1
	}
	{
		level = load_z_wikker
		song = cultofpersonality
		mode = p1_quickplay
		p1_character_id = Xavier
		p2_character_id = judy
		p1_instrument_id = Instrument_focus01
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 1
		p2_outfit = 1
		p1_style = 1
		p2_style = 1
	}
	{
		level = load_z_dive
		song = anarchyintheuk
		mode = p1_quickplay
		p1_character_id = Johnny
		p2_character_id = judy
		p1_instrument_id = Instrument_White_Vee
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 2
		p2_outfit = 1
		p1_style = 1
		p2_style = 1
	}
	{
		level = load_z_artdeco
		song = knightsofcydonia
		mode = p1_quickplay
		p1_character_id = Casey
		p2_character_id = judy
		p1_instrument_id = Instrument_focus01
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 1
		p2_outfit = 1
		p1_style = 1
		p2_style = 1
	}
	{
		level = load_z_party
		song = mynameisjonas
		mode = p1_quickplay
		p1_character_id = judy
		p2_character_id = judy
		p1_instrument_id = Instrument_EpiPaul01
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 1
		p2_outfit = 1
		p1_style = 4
		p2_style = 1
	}
	{
		level = load_z_prison
		song = mississippiqueen
		mode = p1_quickplay
		p1_character_id = Casey
		p2_character_id = judy
		p1_instrument_id = Instrument_wylde
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 2
		p2_outfit = 1
		p1_style = 4
		p2_style = 1
	}
	{
		level = load_z_wikker
		song = paintitblack
		mode = p1_quickplay
		p1_character_id = Johnny
		p2_character_id = judy
		p1_instrument_id = Instrument_ES400_Red
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 1
		p2_outfit = 1
		p1_style = 4
		p2_style = 1
	}
	{
		level = load_z_party
		song = missmurder
		mode = p1_quickplay
		p1_character_id = Lars
		p2_character_id = judy
		p1_instrument_id = Instrument_Silver_Vee
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 2
		p2_outfit = 1
		p1_style = 1
		p2_style = 1
	}
	{
		level = load_z_budokan
		song = sabotage
		mode = p1_quickplay
		p1_character_id = Casey
		p2_character_id = judy
		p1_instrument_id = Instrument_focus02
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 1
		p2_outfit = 1
		p1_style = 4
		p2_style = 1
	}
	{
		level = load_z_artdeco
		song = theseeker
		mode = p1_quickplay
		p1_character_id = Xavier
		p2_character_id = judy
		p1_instrument_id = Instrument_Marauder_NATO
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 1
		p2_outfit = 1
		p1_style = 2
		p2_style = 1
	}
	{
		level = load_z_dive
		song = pridenjoy
		mode = p1_quickplay
		p1_character_id = Xavier
		p2_character_id = judy
		p1_instrument_id = Instrument_focus02
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 1
		p2_outfit = 1
		p1_style = 4
		p2_style = 1
	}
	{
		level = load_z_artdeco
		song = barracuda
		mode = p1_quickplay
		p1_character_id = judy
		p2_character_id = judy
		p1_instrument_id = Instrument_Les_Paul_Black
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 2
		p2_outfit = 1
		p1_style = 1
		p2_style = 1
	}
	{
		level = load_z_dive
		song = bullsonparade
		mode = p1_quickplay
		p1_character_id = Casey
		p2_character_id = judy
		p1_instrument_id = Instrument_focus01
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 1
		p2_outfit = 1
		p1_style = 3
		p2_style = 1
	}
	{
		level = load_z_party
		song = prayeroftherefugee
		mode = p1_quickplay
		p1_character_id = Johnny
		p2_character_id = judy
		p1_instrument_id = Instrument_Les_Paul_Red
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 1
		p2_outfit = 1
		p1_style = 1
		p2_style = 1
	}
	{
		level = load_z_dive
		song = laydown
		mode = p1_quickplay
		p1_character_id = axel
		p2_character_id = judy
		p1_instrument_id = Instrument_focus01
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 2
		p2_outfit = 1
		p1_style = 1
		p2_style = 1
	}
	{
		level = load_z_wikker
		song = threesandsevens
		mode = p1_quickplay
		p1_character_id = judy
		p2_character_id = judy
		p1_instrument_id = Instrument_Explorer_Black
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 1
		p2_outfit = 1
		p1_style = 3
		p2_style = 1
	}
	{
		level = load_z_budokan
		song = mycurse
		mode = p1_quickplay
		p1_character_id = axel
		p2_character_id = judy
		p1_instrument_id = Instrument_wyldeb
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 1
		p2_outfit = 1
		p1_style = 1
		p2_style = 1
	}
	{
		level = load_z_prison
		song = paranoid
		mode = p1_quickplay
		p1_character_id = Lars
		p2_character_id = judy
		p1_instrument_id = Instrument_Ebony_Vee
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 2
		p2_outfit = 1
		p1_style = 2
		p2_style = 1
	}
	{
		level = load_z_prison
		song = TalkDirtyToMe
		mode = p1_quickplay
		p1_character_id = Izzy
		p2_character_id = judy
		p1_instrument_id = Instrument_Firebird_Cherry
		p2_instrument_id = Instrument_Les_Paul_Black
		p1_difficulty = easy
		p2_difficulty = easy
		p1_outfit = 1
		p2_outfit = 1
		p1_style = 1
		p2_style = 1
	}
]
last_attract_mode = -1
is_attract_mode = 0
attract_mode_counter = 0

script create_attract_mode 
	change \{is_attract_mode = 1}
	change \{attract_mode_counter = 0}
	create_loading_screen
	Menu_Music_Off \{setflag = 1}
	SoundBussUnlock \{Guitar_Balance}
	SoundBussUnlock \{Band_Balance}
	SetSoundBussParams \{Guitar_Balance = {
			vol = -100.0
		}
		time = 1.5}
	SetSoundBussParams \{Band_Balance = {
			vol = -100.0
		}
		time = 1.5}
	SoundBussLock \{Guitar_Balance}
	SoundBussLock \{Band_Balance}
	kill_start_key_binding
	GetArraySize \{$Attract_Mode_Info}
	if (<array_size> = 1)
		attract_mode_index = 0
	else
		if ($last_attract_mode >= 0)
			GetRandomValue name = attract_mode_index Integer a = 0 b = (<array_size> - 2)
			if (<attract_mode_index> >= $last_attract_mode)
				attract_mode_index = (<attract_mode_index> + 1)
			endif
		else
			GetRandomValue name = attract_mode_index Integer a = 0 b = (<array_size> - 1)
		endif
		change last_attract_mode = <attract_mode_index>
	endif
	p1_outfit = 1
	p2_outfit = 1
	p1_style = 1
	p2_style = 1
	AddParams ($Attract_Mode_Info [<attract_mode_index>])
	change \{structurename = player1_status
		bot_play = 1}
	change \{structurename = player2_status
		bot_play = 1}
	change current_level = <level>
	change game_mode = <mode>
	if ($game_mode = p2_faceoff || $game_mode = p2_pro_faceoff)
		change \{current_num_players = 2}
	else
		change \{current_num_players = 1}
	endif
	change structurename = player1_status character_id = <p1_character_id>
	change structurename = player2_status character_id = <p2_character_id>
	change structurename = player1_status instrument_id = <p1_instrument_id>
	change structurename = player2_status instrument_id = <p2_instrument_id>
	change structurename = player1_status outfit = <p1_outfit>
	change structurename = player2_status outfit = <p2_outfit>
	change structurename = player1_status style = <p1_style>
	change structurename = player2_status style = <p2_style>
	SoundBussUnlock \{Master}
	SetSoundBussParams \{Master = {
			vol = -11.0
		}
		time = 0.5}
	SoundBussLock \{Master}
	mark_unsafe_for_shutdown
	UnPauseGame
	Load_Venue
	start_song song_name = <song> difficulty = <p1_difficulty> difficulty2 = <p2_difficulty> StartTime = 0 device_num = ($player1_status.controller)
	create_attract_mode_text
	stoprendering
	destroy_loading_screen
	SoundBussUnlock \{Guitar_Balance}
	SoundBussUnlock \{Band_Balance}
	SetSoundBussParams {Guitar_Balance = {vol = (($Default_BussSet.Guitar_Balance.vol) - 1.5)}}
	SetSoundBussParams {Band_Balance = {vol = (($Default_BussSet.Band_Balance.vol) - 1.5)}}
	SoundBussLock \{Guitar_Balance}
	SoundBussLock \{Band_Balance}
	spawnscriptnow \{check_for_attract_mode_input}
endscript

script create_attract_mode_text 
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = am_container
		pos = (0.0, 0.0)}
	text = 'PRESS ANY BUTTON TO ROCK...'
	text_pos = (640.0, 637.0)
	CreateScreenElement {
		type = TextElement
		text = <text>
		pos = <text_pos>
		parent = am_container
		rgba = [220 220 220 255]
		font = fontgrid_title_gh3
		just = [center bottom]
		scale = 1.2
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [110 20 80 250]
	}
	CreateScreenElement \{type = SpriteElement
		parent = am_container
		texture = logo_GH3_LoR_128
		dims = (225.0, 225.0)
		pos = (640.0, 490.0)
		just = [
			center
			center
		]}
endscript

script destroy_attract_mode_text 
	destroy_menu \{menu_id = am_container}
	StopAllSounds
	SoundBussUnlock \{Master}
	SetSoundBussParams {Master = {vol = ($Default_BussSet.Master.vol)}}
	SoundBussLock \{Master}
endscript

script check_for_attract_mode_input 
	begin
	if ($attract_mode_counter > 30)
		GetButtonsPressed
		if NOT (<makes> = 0)
			break
		endif
		if NOT ($invite_controller = -1)
			break
		endif
	endif
	WaitOneGameFrame
	change attract_mode_counter = ($attract_mode_counter + 1)
	repeat
	wait_for_safe_shutdown
	BlankScreen
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = exit_attract_mode
		}}
endscript

script destroy_attract_mode 
	PauseGame
	destroy_attract_mode_text
	KillSpawnedScript \{name = check_for_attract_mode_input}
	kill_gem_scroller
	change \{structurename = player1_status
		bot_play = 0}
	change \{structurename = player2_status
		bot_play = 0}
	UnPauseGame
	kill_start_key_binding
	change \{is_attract_mode = 0}
endscript

script strap_screen_check_for_any_input 
	Wait \{1
		seconds}
	waited = 0.0
	begin
	GetButtonsPressed
	if NOT (<makes> = 0)
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = continue
			}}
		break
	endif
	Wait \{1
		gameframe}
	GetDeltaTime
	<waited> = (<waited> + <delta_time>)
	if (<waited> > 14.0)
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = continue
			}}
		break
	endif
	repeat
endscript

script check_for_any_input \{mode = {
		}}
	begin
	GetButtonsPressed
	if (<makes> = 0)
		break
	endif
	WaitOneGameFrame
	repeat
	begin
	GetButtonsPressed <mode>
	if NOT ($invite_controller = -1)
		spawnscriptnow ui_flow_manager_respond_to_action params = {action = continue flow_state_func_params = {device_num = ($invite_controller)}}
		break
	endif
	if NOT (<makes> = 0)
		spawnscriptnow ui_flow_manager_respond_to_action params = {action = continue flow_state_func_params = {device_num = <device_num>}}
		break
	endif
	WaitOneGameFrame
	repeat
endscript

script menu_press_any_button_create_obvious_text 
	text = 'PRESS ANY BUTTON TO ROCK...'
	text_pos = (620.0, 425.0)
	CreateScreenElement {
		type = TextBlockElement
		parent = pab_container
		font = text_a6
		text = <text>
		dims = (500.0, 200.0)
		pos = <text_pos>
		just = [left top]
		internal_just = [center top]
		rgba = [215 120 40 255]
		scale = 0.9
		allow_expansion
	}
endscript
