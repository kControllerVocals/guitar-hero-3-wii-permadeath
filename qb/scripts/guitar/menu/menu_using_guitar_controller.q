
script create_using_guitar_controller_wii_menu 
	if English
		using_guitar_tex = using_guitar1_en
	elseif French
		using_guitar_tex = using_guitar1_fr
	elseif Spanish
		using_guitar_tex = using_guitar1_sp
	elseif German
		using_guitar_tex = using_guitar1_de
	elseif Italian
		using_guitar_tex = using_guitar1_it
	endif
	create_menu_backdrop texture = <using_guitar_tex>
	waited = 0.0
	guitar_plugin_time = 10000.0
	i = 0
	should_break = 0
	begin
	<i> = 0
	begin
	if IsGuitarController controller = <i>
		if (<guitar_plugin_time> = 10000.0)
			<guitar_plugin_time> = <waited>
		endif
		if ((<waited> - <guitar_plugin_time>) > 4.0)
			<should_break> = 1
		endif
		if ControllerMake x <i>
			<should_break> = 1
		endif
	else
		GetHeldPattern controller = <i> nobrokenstring
		<check_buttons> = 65792
		if (<hold_pattern> = <check_buttons>)
			<should_break> = 1
		endif
	endif
	<i> = (<i> + 1)
	repeat 2
	if (<should_break> > 0)
		break
	endif
	GetDeltaTime
	<waited> = (<waited> + <delta_time>)
	Wait \{1
		gameframes}
	repeat
	destroy_menu_backdrop
	if English
		<using_guitar_tex> = using_guitar2_en
	elseif French
		<using_guitar_tex> = using_guitar2_fr
	elseif Spanish
		<using_guitar_tex> = using_guitar2_sp
	elseif German
		<using_guitar_tex> = using_guitar2_de
	elseif Italian
		<using_guitar_tex> = using_guitar2_it
	endif
	create_menu_backdrop texture = <using_guitar_tex>
	holding_button = 1
	<waited> = 0.0
	begin
	GetButtonsPressed
	if (<makes> = 0)
		<holding_button> = 0
	endif
	if (<waited> > 12.0)
		break
	endif
	if (<holding_button> = 0)
		if ControllerMake \{x}
			break
		endif
	endif
	GetDeltaTime
	<waited> = (<waited> + <delta_time>)
	Wait \{1
		gameframe}
	repeat
	ui_flow_manager_respond_to_action \{action = continue}
endscript

script destroy_using_guitar_controller_wii_menu 
	destroy_menu_backdrop
endscript
menu_using_guitar_controller_font = text_a4

script create_using_guitar_controller_menu 
	create_menu_backdrop \{texture = boot_usingGuitar_BG}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = ugc_container
		pos = (0.0, 0.0)}
	guitar_tex = boot_usingGuitar_gtr_LesPaul
	GetPlatform
	switch <platform>
		case ps3
		<guitar_tex> = boot_usingGuitar_gtr_LesPaul_PS3
		case Ps2
		<guitar_tex> = boot_usingGuitar_gtr_LesPaul_PS2
	endswitch
	displaySprite parent = ugc_container tex = <guitar_tex> pos = (660.0, 510.0) just = [center center] z = 1 scale = 2
	displaySprite \{parent = ugc_container
		tex = boot_usingGuitar_illo
		pos = (640.0, 270.0)
		just = [
			center
			center
		]
		z = 1
		scale = 2}
	displaySprite \{parent = ugc_container
		id = bg_helper
		tex = white
		rgba = [
			83
			95
			147
			255
		]
		dims = (221.0, 40.0)
		just = [
			center
			top
		]
		z = 0.5}
	displayText \{parent = ugc_container
		id = bg_helper_text
		font = text_a4
		rgba = [
			223
			223
			223
			255
		]
		scale = 0.5
		just = [
			center
			top
		]
		z = 0.6
		noshadow}
	menu_using_guitar_controller_add_text_start
	menu_using_guitar_controller_add_text_back
	menu_using_guitar_controller_add_text_continue
	menu_using_guitar_controller_add_text_up_down
	menu_using_guitar_controller_add_text_tilt_starpower
	menu_using_guitar_controller_add_text_header
	spawnscriptnow \{go_through_using_guitar_text}
	spawnscriptnow \{check_for_any_input
		params = {
			mode = StartAndA
		}}
	return \{play_sound = 0}
endscript

script destroy_using_guitar_controller_menu 
	destroy_menu \{menu_id = ugc_container}
	destroy_menu_backdrop
	KillSpawnedScript \{name = go_through_using_guitar_text}
	KillSpawnedScript \{name = check_for_any_input}
endscript

script go_through_using_guitar_text 
	max_width = 200
	begin
	if ScreenElementExists \{id = bg_helper}
		SetScreenElementProps \{id = bg_helper
			pos = (406.0, 135.0)}
	endif
	if ScreenElementExists \{id = bg_helper_text}
		SetScreenElementProps \{id = bg_helper_text
			pos = (407.0, 133.0)
			text = '1) STRAP ON'}
		GetScreenElementDims \{id = bg_helper_text}
		SetScreenElementProps \{id = bg_helper_text
			scale = 1}
		if (<width> > <max_width>)
			fit_text_in_rectangle id = bg_helper_text dims = (<max_width> * (1.0, 0.0) + <Height> * (0.0, 1.0))
		else
			SetScreenElementProps \{id = bg_helper_text
				scale = 0.5}
		endif
	endif
	Wait \{2
		seconds}
	if ScreenElementExists \{id = bg_helper}
		SetScreenElementProps \{id = bg_helper
			pos = (639.0, 135.0)}
	endif
	if ScreenElementExists \{id = bg_helper_text}
		SetScreenElementProps \{id = bg_helper_text
			pos = (640.0, 133.0)
			text = '2) BANG HEAD'}
		GetScreenElementDims \{id = bg_helper_text}
		SetScreenElementProps \{id = bg_helper_text
			scale = 1}
		if (<width> > <max_width>)
			fit_text_in_rectangle id = bg_helper_text dims = (<max_width> * (1.0, 0.0) + <Height> * (0.0, 1.0))
		else
			SetScreenElementProps \{id = bg_helper_text
				scale = 0.5}
		endif
	endif
	Wait \{2
		seconds}
	if ScreenElementExists \{id = bg_helper}
		SetScreenElementProps \{id = bg_helper
			pos = (872.0, 135.0)}
	endif
	if ScreenElementExists \{id = bg_helper_text}
		SetScreenElementProps \{id = bg_helper_text
			pos = (873.0, 133.0)
			text = '3) LOSE CONTROL'}
		GetScreenElementDims \{id = bg_helper_text}
		SetScreenElementProps \{id = bg_helper_text
			scale = 1}
		if (<width> > <max_width>)
			fit_text_in_rectangle id = bg_helper_text dims = (<max_width> * (1.0, 0.0) + <Height> * (0.0, 1.0))
		else
			SetScreenElementProps \{id = bg_helper_text
				scale = 0.5}
		endif
	endif
	Wait \{2
		seconds}
	repeat
endscript

script menu_using_guitar_controller_add_text_start 
	text1 = 'START'
	text1_pos = (805.0, 593.0)
	text2 = 'button'
	text2_pos = (805.0, 626.0)
	CreateScreenElement {
		type = TextElement
		text = <text1>
		pos = <text1_pos>
		parent = ugc_container
		rgba = [200 200 200 255]
		font = ($menu_using_guitar_controller_font)
		just = [right top]
		scale = (0.7, 0.7)
	}
	GetScreenElementDims id = <id>
	if (<width> > 80)
		extra_space = (<width> - 80)
		GetScreenElementProps id = <id>
		SetScreenElementProps id = <id> pos = (<pos> - <extra_space> * (0.5, 0.0))
	endif
	CreateScreenElement {
		type = TextElement
		text = <text2>
		pos = <text2_pos>
		parent = ugc_container
		rgba = [200 200 200 255]
		font = ($menu_using_guitar_controller_font)
		just = [right top]
		scale = 0.6
	}
endscript

script menu_using_guitar_controller_add_text_back 
	text1 = 'BACK'
	text1_pos = (460.0, 590.0)
	text2 = 'Red Button'
	text2_pos = (460.0, 623.0)
	CreateScreenElement {
		type = TextElement
		text = <text1>
		pos = <text1_pos>
		parent = ugc_container
		rgba = [200 200 200 255]
		font = ($menu_using_guitar_controller_font)
		just = [left top]
		scale = (0.7, 0.7)
	}
	CreateScreenElement {
		type = TextElement
		text = <text2>
		pos = <text2_pos>
		parent = ugc_container
		rgba = [165 70 70 255]
		font = ($menu_using_guitar_controller_font)
		just = [left top]
		scale = 0.6
	}
endscript

script menu_using_guitar_controller_add_text_continue 
	text1 = 'CONTINUE'
	text1_pos = (390.0, 590.0)
	text2 = 'Green Button'
	text2_pos = (390.0, 623.0)
	CreateScreenElement {
		type = TextElement
		text = <text1>
		pos = <text1_pos>
		parent = ugc_container
		rgba = [200 200 200 255]
		font = ($menu_using_guitar_controller_font)
		just = [right top]
		scale = (0.7, 0.7)
	}
	GetScreenElementDims id = <id>
	if (<width> > 125)
		extra_space = (<width> - 125)
		GetScreenElementProps id = <id>
		SetScreenElementProps id = <id> pos = (<pos> - <extra_space> * (0.5, 0.0))
	endif
	CreateScreenElement {
		type = TextElement
		text = <text2>
		pos = <text2_pos>
		parent = ugc_container
		rgba = [80 145 105 255]
		font = ($menu_using_guitar_controller_font)
		just = [right top]
		scale = 0.6
	}
endscript

script menu_using_guitar_controller_add_text_up_down 
	text1 = 'UP/DOWN'
	text1_pos = (590.0, 398.0)
	text2 = 'Strum Bar'
	text2_pos = (590.0, 431.0)
	CreateScreenElement {
		type = TextElement
		text = <text1>
		pos = <text1_pos>
		parent = ugc_container
		rgba = [200 200 200 255]
		font = ($menu_using_guitar_controller_font)
		just = [center top]
		scale = (0.7, 0.7)
	}
	GetScreenElementDims id = <id>
	if (<width> > 180)
		SetScreenElementProps id = <id> scale = 1
		fit_text_in_rectangle id = <id> only_if_larger_x = 1 dims = ((180.0, 0.0) + <Height> * (0.0, 1.0))
	endif
	CreateScreenElement {
		type = TextElement
		text = <text2>
		pos = <text2_pos>
		parent = ugc_container
		rgba = [200 200 200 255]
		font = ($menu_using_guitar_controller_font)
		just = [center top]
		scale = 0.6
	}
	GetScreenElementDims id = <id>
	if (<width> > 180)
		SetScreenElementProps id = <id> scale = 1
		fit_text_in_rectangle id = <id> only_if_larger_x = 1 dims = ((180.0, 0.0) + <Height> * (0.0, 1.0))
	endif
endscript

script menu_using_guitar_controller_add_text_tilt_starpower 
	text1 = 'TILT UP'
	text1_pos = (300.0, 398.0)
	text2 = 'for Star Power'
	text2_pos = (300.0, 431.0)
	CreateScreenElement {
		type = TextElement
		text = <text1>
		pos = <text1_pos>
		parent = ugc_container
		rgba = [200 200 200 255]
		font = ($menu_using_guitar_controller_font)
		just = [left top]
		scale = (0.7, 0.7)
	}
	GetScreenElementDims id = <id>
	if (<width> > 180)
		SetScreenElementProps id = <id> scale = 1
		fit_text_in_rectangle id = <id> only_if_larger_x = 1 dims = ((180.0, 0.0) + <Height> * (0.0, 1.0))
	endif
	CreateScreenElement {
		type = TextElement
		text = <text2>
		pos = <text2_pos>
		parent = ugc_container
		rgba = [200 200 200 255]
		font = ($menu_using_guitar_controller_font)
		just = [left top]
		scale = 0.6
	}
	GetScreenElementDims id = <id>
	if (<width> > 180)
		SetScreenElementProps id = <id> scale = 1
		fit_text_in_rectangle id = <id> only_if_larger_x = 1 dims = ((180.0, 0.0) + <Height> * (0.0, 1.0))
	endif
	CreateScreenElement \{type = SpriteElement
		parent = ugc_container
		texture = boot_usingGuitar_arrow
		pos = (270.0, 460.0)
		just = [
			right
			center
		]}
endscript

script menu_using_guitar_controller_add_text_header 
	text1 = 'IN THE EVENT OF ROCK'
	text1_pos = (660.0, 55.0)
	text2 = 'USING THE GUITAR CONTROLLER'
	text2_pos = (660.0, 95.0)
	CreateScreenElement {
		type = TextElement
		text = <text1>
		pos = <text1_pos>
		parent = ugc_container
		rgba = [100 110 145 255]
		font = ($menu_using_guitar_controller_font)
		just = [center top]
		scale = (1.4, 1.0)
	}
	CreateScreenElement {
		type = TextElement
		text = <text2>
		pos = <text2_pos>
		parent = ugc_container
		rgba = [200 200 200 255]
		font = ($menu_using_guitar_controller_font)
		just = [center top]
		scale = (0.9, 0.7)
	}
endscript
