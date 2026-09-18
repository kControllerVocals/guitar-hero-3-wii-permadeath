menu_choose_practice_part_font = fontgrid_title_gh3

script create_choose_practice_part_menu 

	kill_start_key_binding
	set_focus_color rgba = ($default_menu_focus_color)
	set_unfocus_color rgba = ($default_menu_unfocus_color)
	menu_pos = (848.0, 242.0)
	CreateScreenElement \{type = ContainerElement
		id = cpp_container
		parent = root_window
		just = [
			left
			top
		]
		pos = (0.0, 0.0)}
	new_menu scrollid = cpp_scroll vmenuid = cpp_vmenu menu_pos = <menu_pos> spacing = -50
	create_menu_backdrop \{texture = Venue_BG}
	displaySprite \{parent = cpp_container
		tex = Practice_Poster_3
		pos = (186.0, 15.0)
		dims = (672.0, 672.0)
		rot_angle = -2
		z = 1}
	displaySprite \{parent = cpp_container
		tex = Toprockers_Tape_2
		pos = (500.0, 650.0)
		z = 3
		rot_angle = -12
		flip_v}
	displaySprite \{parent = cpp_container
		tex = Toprockers_Tape_1
		pos = (565.0, -95.0)
		z = 3
		rot_angle = 80}
	displaySprite \{parent = cpp_container
		tex = Toprockers_Tape_2
		pos = (500.0, -85.0)
		z = 3
		rot_angle = 80}
	displaySprite \{parent = cpp_container
		tex = Toprockers_Tape_2
		pos = (435.0, -75.0)
		z = 3
		rot_angle = 78}
	CreateScreenElement {
		type = TextBlockElement
		parent = cpp_container
		id = header
		text = 'PRACTICE PART'
		pos = (360.0, 60.0)
		dims = (100.0, 300.0)
		scale = 1.7
		just = [left top]
		internal_just = [left top]
		line_spacing = 1
		rgba = [35 100 130 255]
		font = ($menu_choose_practice_part_font)
		z = 2
		rot_angle = -2
	}
	GetScreenElementChildren id = <id>
	GetArraySize (<children>)
	i = 0
	begin
	GetScreenElementDims id = (<children> [<i>])
	width_to_check_for = 225
	if (<i> = 1)
		<width_to_check_for> = 120
	endif
	if (<width> > <width_to_check_for>)
		fit_text_in_rectangle id = (<children> [<i>]) dims = (<width_to_check_for> * (1.0, 0.0) + <Height> * (0.0, 1.0))
	endif
	<i> = (<i> + 1)
	repeat <array_size>
	displaySprite \{parent = cpp_container
		tex = dialog_bg
		pos = (680.0, 256.0)
		dims = (332.0, 70.0)
		z = 2}
	displaySprite \{parent = cpp_container
		tex = dialog_bg
		flip_h
		pos = (680.0, 326.0)
		dims = (332.0, 70.0)
		z = 2}
	displaySprite \{id = cpp_hi_left
		parent = cpp_container
		tex = Dialog_Highlight
		flip_v
		pos = (720.0, 325.0)
		z = 5
		just = [
			right
			center
		]}
	displaySprite \{id = cpp_hi_right
		parent = cpp_container
		tex = Dialog_Highlight
		pos = (910.0, 325.0)
		z = 5
		just = [
			left
			center
		]}
	guitar_or_lead_text = 'GUITAR'
	bass_or_rhythm_text = 'BASS'
	get_song_rhythm_track_cfunc song = ($current_song)
	if (<rhythm_track> = 1)
		<guitar_or_lead_text> = 'LEAD'
		<bass_or_rhythm_text> = 'RHYTHM'
	endif
	set_focus_color \{rgba = [
			130
			0
			0
			250
		]}
	set_unfocus_color \{rgba = [
			0
			0
			0
			255
		]}
	CreateScreenElement \{type = ContainerElement
		id = cpp_guitar
		parent = cpp_vmenu
		event_handlers = [
			{
				focus
				retail_menu_focus
				params = {
					id = guitar_text
				}
			}
			{
				focus
				menu_choose_practice_part_highlighter
				params = {
					text_id = guitar_text
					guitar
				}
			}
			{
				unfocus
				retail_menu_unfocus
				params = {
					id = guitar_text
				}
			}
			{
				pad_choose
				practicemenu_select_part
				params = {
					part = guitar
				}
			}
			{
				pad_back
				practicemenu_go_back
			}
		]
		dims = (100.0, 100.0)}
	CreateScreenElement {
		type = TextElement
		font = ($menu_choose_practice_part_font)
		parent = cpp_guitar
		id = guitar_text
		text = <guitar_or_lead_text>
		scale = (1.333, 1.333)
		rgba = ($menu_unfocus_color)
		font_spacing = 0
		z_priority = 5
		just = [center center]
	}
	GetScreenElementDims id = <id>
	if (<width> > 250)
		fit_text_in_rectangle id = <id> dims = ((250.0, 0.0) + <Height> * (0.0, 1.0))
	endif
	CreateScreenElement \{type = ContainerElement
		id = cpp_bass
		parent = cpp_vmenu
		event_handlers = [
			{
				focus
				retail_menu_focus
				params = {
					id = bass_text
				}
			}
			{
				focus
				menu_choose_practice_part_highlighter
				params = {
					text_id = bass_text
					Bass
				}
			}
			{
				unfocus
				retail_menu_unfocus
				params = {
					id = bass_text
				}
			}
			{
				pad_choose
				practicemenu_select_part
				params = {
					part = rhythm
				}
			}
			{
				pad_back
				practicemenu_go_back
			}
		]
		dims = (100.0, 100.0)}
	CreateScreenElement {
		type = TextElement
		font = ($menu_choose_practice_part_font)
		parent = cpp_bass
		id = bass_text
		text = <bass_or_rhythm_text>
		scale = (1.333, 1.333)
		rgba = ($menu_unfocus_color)
		font_spacing = 0
		z_priority = 5
		just = [center center]
	}
	GetScreenElementDims id = <id>
	if (<width> > 250)
		fit_text_in_rectangle id = <id> dims = ((250.0, 0.0) + <Height> * (0.0, 1.0))
	endif
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

script menu_choose_practice_part_highlighter 
	GetScreenElementDims id = <text_id>
	y_off = (0.0, 0.0)
	if GotParam \{Bass}
		<y_off> = (0.0, 52.0)
	endif
	new_pos_l = ((840.0, 303.0) + <y_off> - <width> * (0.5, 0.0))
	new_pos_r = ((850.0, 303.0) + <y_off> + <width> * (0.5, 0.0))
	if GotParam \{guitar}
		SetScreenElementProps id = cpp_hi_left pos = <new_pos_l> preserve_flip
		SetScreenElementProps id = cpp_hi_right pos = <new_pos_r>
	elseif GotParam \{Bass}
		SetScreenElementProps id = cpp_hi_left pos = <new_pos_l> preserve_flip
		SetScreenElementProps id = cpp_hi_right pos = <new_pos_r>
	endif
endscript

script destroy_choose_practice_part_menu 
	destroy_pause_menu_frame
	restore_start_key_binding
	destroy_menu_backdrop
	destroy_menu \{menu_id = cpp_scroll}
	destroy_menu \{menu_id = cpp_container}
	clean_up_user_control_helpers
	set_focus_color rgba = ($default_menu_focus_color)
	set_unfocus_color rgba = ($default_menu_unfocus_color)
endscript

script practicemenu_select_part 
	change structurename = player1_status part = <part>
	ui_flow_manager_respond_to_action \{action = continue}
endscript

script practicemenu_go_back 
	ui_flow_manager_respond_to_action \{action = go_back}
endscript
