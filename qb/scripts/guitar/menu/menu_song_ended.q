
script create_song_ended_menu \{player = 1}
	if IsMoviePlaying \{TextureSlot = 1}
		PauseMovie \{TextureSlot = 1}
	endif
	disable_pause
	menu_font = text_a4
	menu_pos = (530.0, 480.0)
	completion = 0
	get_song_end_time song = ($current_song)
	GetSongTimeMs
	if (<time> < 0)
		time = 0
	elseif (<time> > <total_end_time>)
		time = <total_end_time>
	endif
	if (<total_end_time> > 0)
		completion = (100 * <time> / <total_end_time>)
	endif
	CastToInteger \{completion}
	get_difficulty_text_upper difficulty = ($current_difficulty)
	get_song_title song = ($current_song)
	GetUpperCaseString <song_title>
	FormatText TextName = completion_text '%d' d = <completion>
	song_ended_off = (643.0, 212.0)
	song_name_off = (695.0, 460.0)
	z = 10000.0
	offwhite = [223 223 223 255]
	new_menu scrollid = song_ended_scrolling_menu vmenuid = song_ended_vmenu use_backdrop = 0 spacing = -12 menu_pos = <menu_pos> exclusive_device = ($last_start_pressed_device)
	create_pause_menu_frame z = (<z> - 10)
	SetScreenElementProps \{id = song_ended_vmenu
		internal_just = [
			center
			center
		]}
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = song_ended_static_text_container
		internal_just = [
			center
			center
		]
		pos = (0.0, 0.0)
		z_priority = 2}
	displaySprite parent = song_ended_static_text_container tex = Dialog_Title_BG flip_v pos = (416.0, 100.0) scale = (1.75, 1.75) z = <z>
	displaySprite parent = song_ended_static_text_container tex = Dialog_Title_BG pos = (640.0, 100.0) scale = (1.75, 1.75) z = <z>
	CreateScreenElement {
		type = TextElement
		parent = song_ended_static_text_container
		font = <menu_font>
		text = 'SONG ENDED'
		just = [center center]
		pos = {<song_ended_off> relative}
		rgba = [223 223 223 255]
		scale = 1.3
		z_priority = (<z> + 0.1)
		shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		pos = (0.0, -10.0)
	}
	fit_text_in_rectangle id = <id> dims = (285.0, 40.0) only_if_larger_x = 1 start_x_scale = 1.3 start_y_scale = 1.3
	<song_title_scale> = 1.65
	<song_name_pos> = (640.0, 337.0)
	<completion_text_pos> = (640.0, 412.0)
	fill_song_title_and_completion_details <...> parent = song_ended_static_text_container
	change \{menu_focus_color = [
			180
			50
			50
			255
		]}
	change \{menu_unfocus_color = [
			0
			0
			0
			255
		]}
	text_scale = (1.333, 1.4667)
	displaySprite parent = song_ended_static_text_container tex = white pos = (492.0, 517.0) scale = (75.0, 6.0) z = (<z> + 0.1) rgba = <offwhite>
	displaySprite parent = song_ended_static_text_container tex = dialog_frame_joiner pos = (480.0, 510.0) rot_angle = 5 scale = (1.575, 1.5) z = (<z> + 0.2)
	displaySprite parent = song_ended_static_text_container tex = dialog_frame_joiner pos = (750.0, 514.0) flip_v rot_angle = -5 scale = (1.575, 1.5) z = (<z> + 0.2)
	displaySprite id = hi_right parent = song_ended_static_text_container tex = Dialog_Highlight pos = (770.0, 533.0) scale = (1.0, 1.0) z = (<z> + 0.3) just = [left center]
	displaySprite id = hi_left parent = song_ended_static_text_container tex = Dialog_Highlight flip_v pos = (500.0, 533.0) scale = (1.0, 1.0) z = (<z> + 0.3) just = [right center]
	displaySprite parent = song_ended_static_text_container tex = dialog_bg pos = (480.0, 450.0) dims = (320.0, 80.0) z = <z>
	displaySprite parent = song_ended_static_text_container tex = dialog_bg flip_h pos = (480.0, 530.0) dims = (320.0, 80.0) z = <z>
	CreateScreenElement \{type = ContainerElement
		parent = song_ended_vmenu
		dims = (0.0, 100.0)
		event_handlers = [
			{
				focus
				menu_se_retry_highlight_focus
				params = {
					id = song_ended_retry_text
				}
			}
			{
				unfocus
				retail_menu_unfocus
				params = {
					id = song_ended_retry_text
				}
			}
			{
				pad_choose
				song_ended_menu_select_retry_song
			}
		]}
	CreateScreenElement {
		type = TextElement
		parent = <id>
		id = song_ended_retry_text
		font = <menu_font>
		text = 'RETRY SONG'
		rgba = ($menu_unfocus_color)
		scale = <text_scale>
		just = [center top]
		z_priority = (<z> + 0.1)
		pos = (110.0, -61.0)
	}
	fit_text_in_rectangle \{id = song_ended_retry_text
		dims = (270.0, 57.0)}
	CreateScreenElement {
		type = ContainerElement
		parent = song_ended_vmenu
		dims = (0.0, 100.0)
		event_handlers = [
			{focus menu_se_newsong_highlight_focus params = {id = song_ended_new_song_text}}
			{unfocus retail_menu_unfocus params = {id = song_ended_new_song_text}}
			{pad_choose song_ended_menu_select_new_song params = {player = <player>}}
		]
	}
	CreateScreenElement {
		type = TextElement
		parent = <id>
		id = song_ended_new_song_text
		font = <menu_font>
		text = 'NEW SONG'
		rgba = ($menu_unfocus_color)
		scale = <text_scale>
		just = [center top]
		z_priority = (<z> + 0.1)
		pos = (110.0, -110.0)
	}
	fit_text_in_rectangle \{id = song_ended_new_song_text
		dims = (270.0, 57.0)}
	CreateScreenElement \{type = ContainerElement
		parent = song_ended_vmenu
		dims = (0.0, 100.0)
		event_handlers = [
			{
				focus
				menu_se_quit_highlight_focus
				params = {
					id = song_ended_main_menu_text
				}
			}
			{
				unfocus
				retail_menu_unfocus
				params = {
					id = song_ended_main_menu_text
				}
			}
			{
				pad_choose
				song_ended_menu_select_quit
			}
		]}
	CreateScreenElement {
		type = TextElement
		parent = <id>
		id = song_ended_main_menu_text
		font = <menu_font>
		text = 'MAIN MENU'
		rgba = ($menu_unfocus_color)
		scale = <text_scale>
		just = [center top]
		z_priority = (<z> + 0.1)
		pos = (110.0, -159.0)
	}
	fit_text_in_rectangle \{id = song_ended_main_menu_text
		dims = (270.0, 57.0)}
	add_user_control_helper \{text = 'SELECT'
		button = green
		z = 100}
	add_user_control_helper \{text = 'UP/DOWN'
		button = strumbar
		z = 100}
endscript

script destroy_song_ended_menu 
	GH3_SFX_fail_song_stop_sounds
	if IsMoviePlaying \{TextureSlot = 1}
		ResumeMovie \{TextureSlot = 1}
	endif
	enable_pause
	clean_up_user_control_helpers
	destroy_menu \{menu_id = song_ended_scrolling_menu}
	destroy_pause_menu_frame
	destroy_menu \{menu_id = song_ended_static_text_container}
endscript

script song_ended_menu_select_retry_song 
	ui_flow_manager_respond_to_action \{action = select_retry}
	restart_song
endscript

script song_ended_menu_select_new_song 
	if GotParam \{player}
		ui_flow_manager_respond_to_action action = select_new_song create_params = {player = <player>}
	else
		ui_flow_manager_respond_to_action \{action = select_new_song}
	endif
endscript

script song_ended_menu_select_quit 
	ui_flow_manager_respond_to_action \{action = select_quit}
endscript

script menu_se_retry_highlight_focus 
	retail_menu_focus id = <id>
	GetScreenElementDims id = <id>
	SetScreenElementProps id = hi_left pos = ((635.0, 490.0) - <width> * (0.5, 0.0)) flip_v
	SetScreenElementProps id = hi_right pos = ((645.0, 490.0) + <width> * (0.5, 0.0))
endscript

script menu_se_newsong_highlight_focus 
	retail_menu_focus id = <id>
	GetScreenElementDims id = <id>
	SetScreenElementProps id = hi_left pos = ((635.0, 530.0) - <width> * (0.5, 0.0)) flip_v
	SetScreenElementProps id = hi_right pos = ((645.0, 530.0) + <width> * (0.5, 0.0))
endscript

script menu_se_quit_highlight_focus 
	retail_menu_focus id = <id>
	GetScreenElementDims id = <id>
	SetScreenElementProps id = hi_left pos = ((635.0, 570.0) - <width> * (0.5, 0.0)) flip_v
	SetScreenElementProps id = hi_right pos = ((645.0, 570.0) + <width> * (0.5, 0.0))
endscript
