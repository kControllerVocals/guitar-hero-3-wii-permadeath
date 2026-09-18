loading_screen_tips = [
	$string_ps2_loading_screen_tip_01
	$string_ps2_loading_screen_tip_01
	$string_ps2_loading_screen_tip_02
	$string_ps2_loading_screen_tip_02
	$string_ps2_loading_screen_tip_03
	$string_ps2_loading_screen_tip_03
	$string_ps2_loading_screen_tip_04
	$string_ps2_loading_screen_tip_04
	$string_ps2_loading_screen_tip_05
	$string_ps2_loading_screen_tip_06
	$string_ps2_loading_screen_tip_07
	$string_ps2_loading_screen_tip_08
	$string_ps2_loading_screen_tip_09
	$string_ps2_loading_screen_tip_10
	$string_ps2_loading_screen_tip_11
	$string_ps2_loading_screen_tip_12
	$string_ps2_loading_screen_tip_13
	$string_ps2_loading_screen_tip_14
	$string_ps2_loading_screen_tip_15
	$string_ps2_loading_screen_tip_16
	$string_ps2_loading_screen_tip_17
	$string_ps2_loading_screen_tip_18
	$string_ps2_loading_screen_tip_19
	$string_ps2_loading_screen_tip_20
	$string_ps2_loading_screen_tip_21
	$string_ps2_loading_screen_tip_22
	$string_ps2_loading_screen_tip_23
	$string_ps2_loading_screen_tip_24
	$string_ps2_loading_screen_tip_25
	$string_ps2_loading_screen_tip_26
	$string_ps2_loading_screen_tip_27
	$string_ps2_loading_screen_tip_28
	$string_ps2_loading_screen_tip_29
	$string_ps2_loading_screen_tip_30
	$string_ps2_loading_screen_tip_31
	$string_ps2_loading_screen_tip_32
	$string_ps2_loading_screen_tip_33
	$string_ps2_loading_screen_tip_35
	$string_ps2_loading_screen_tip_36
	$string_ps2_loading_screen_tip_37
]
g_loading_screen_split_container_id = id

script create_loading_screen \{mode = play_song}
	PreDisplayLoadingScreen
	Menu_Music_Off \{setflag = 1}
	kill_start_key_binding
	if ($is_changing_levels = 1)
		return
	endif
	change \{is_changing_levels = 1}
	GetArraySize ($loading_screen_tips)
	GetRandomValue name = rand_num a = 0 b = (<array_size> - 1) Integer
	rand_tip = ($loading_screen_tips [<rand_num>])
	if (($game_mode = p2_career) && (<rand_tip> = $string_ps2_loading_screen_tip_03))
		rand_tip = $string_ps2_loading_screen_tip_38
	endif
	if (($current_song = thrufireandflames) && ($current_difficulty = expert))
		rand_tip = $string_ps2_loading_screen_tip_39
	endif
	KillSpawnedScript \{name = destroy_loading_screen_spawned}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = loading_screen_container
		pos = (0.0, 0.0)}
	LoadPak \{'pak/loading_screen/loading_screen.pak'}
	GetLanguage
	switch <language>
		case LANGUAGE_FRENCH
		loading_text_tex = loading_text_fr
		case LANGUAGE_GERMAN
		loading_text_tex = loading_text_de
		case LANGUAGE_SPANISH
		loading_text_tex = loading_text_sp
		case LANGUAGE_ITALIAN
		loading_text_tex = loading_text_it
		default
		loading_text_tex = loading_text
	endswitch
	CreateScreenElement {
		type = SpriteElement
		parent = loading_screen_container
		texture = <loading_text_tex>
		pos = (241.0, 80.0)
		just = [left left]
		dims = (412.0, 206.0)
		z_priority = 4500
	}
	CreateScreenElement \{type = SpriteElement
		parent = loading_screen_container
		texture = loading_background
		pos = (640.0, 360.0)
		just = [
			center
			center
		]
		dims = (1280.0, 720.0)
		z_priority = 4000}
	CreateScreenElement {
		type = TextBlockElement
		parent = loading_screen_container
		id = loading_tip_text
		text = <rand_tip>
		font = text_a4
		scale = 1.1
		just = [center center]
		dims = (350.0, 500.0)
		pos = (910.0, 250.0)
		rgba = [255 255 255 255]
		z_priority = 4999
		shadow
		shadow_offs = (5.0, 5.0)
		shadow_rgba = [0 0 0 255]
	}
	Wait \{5
		gameframes}
	DisplayLoadingScreen \{no_back
		animate}
endscript

script destroy_loading_screen 
	destroy_menu \{menu_id = loading_tip_text}
	KillSpawnedScript \{name = jiggle_text_array_elements}
	if ScreenElementExists \{id = $g_loading_screen_split_container_id}
		DestroyScreenElement \{id = $g_loading_screen_split_container_id}
	endif
	if IsMoviePlaying \{TextureSlot = 2}
		KillMovie \{TextureSlot = 2}
	endif
	spawnscriptnow \{destroy_loading_screen_spawned}
	Hideloadingscreen
	if ($playing_song = 0)
		change \{is_changing_levels = 0}
	endif
	change \{is_changing_levels = 0}
endscript

script destroy_loading_screen_spawned \{time = 0.3}
	OnExitRun \{destroy_loading_screen_finish}
	if (<time> > 0)
		if ScreenElementExists \{id = menu_backdrop_container}
			doScreenElementMorph id = menu_backdrop_container alpha = 0 time = <time>
		endif
		if ScreenElementExists \{id = loading_screen_container}
			doScreenElementMorph id = loading_screen_container alpha = 0 time = <time>
		endif
		Wait <time> seconds
	endif
endscript

script destroy_loading_screen_finish 
	Hideloadingscreen
	if ScreenElementExists \{id = loading_screen_container}
		DestroyScreenElement \{id = loading_screen_container}
	endif
	destroy_menu_backdrop
	UnloadPak \{'pak/loading_screen/loading_screen.pak'}
endscript

script refresh_screen 
	destroy_loading_screen
	create_loading_screen
endscript
