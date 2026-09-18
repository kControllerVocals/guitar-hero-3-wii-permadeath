popup_focus_color = [
	210
	210
	210
	250
]
popup_unfocus_color = [
	210
	130
	0
	250
]
popup_previous_menu = vmenu_main_menu
phrase_index = 0
phrase_array_size = 0
generic_down_arrow_enabled = 1
generic_up_arrow_enabled = 1

script assign_alias_for_generic_popup 
	AssignAlias id = <focus_item> alias = current_menu
endscript
generic_popup_open = 0
generic_popup_loading_window_open = 0

script is_generic_popup_open 
	return \{open = $generic_popup_open}
endscript

script popup_menu_focus 
	if GotParam \{id}
		if ScreenElementExists id = <id>
			SetScreenElementProps id = <id> rgba = ($popup_focus_color)
		endif
	else
		GetTags
		SetScreenElementProps id = <id> rgba = ($popup_focus_color)
	endif
endscript

script popup_menu_unfocus 
	if GotParam \{id}
		if ScreenElementExists id = <id>
			SetScreenElementProps id = <id> rgba = ($popup_unfocus_color)
		endif
	else
		GetTags
		SetScreenElementProps id = <id> rgba = ($popup_unfocus_color)
	endif
endscript

script create_generic_popup \{text_font = text_a1
		menu_font = fontgrid_title_gh3
		z = 100
		font_scale = 0.75
		message_scale = 0.75}
	change \{generic_popup_open = 1}
	if GotParam \{loading_window}
		if ($<wait_variable> = 1)
			return
		endif
	endif
	printf \{'creating the generic popup'}
	scale_1 = ((1.5, 0.0) + (0.0, 1.4))
	scale_2 = ((1.4, 0.0) + (0.0, 1.4))
	scale_3 = ((1.4, 0.0) + (0.0, 1.3499999))
	scale_4 = ((1.575, 0.0) + (0.0, 1.5))
	scale_5 = ((1.5, 0.0) + (0.0, 1.4))
	menu_pos = (534.0, 474.0)
	<dialog> = 0
	generic_popup_z = <z>
	menu_font = <font>
	text_font = <message_font>
	current_menu :GetParentID
	<parent_id> :getmenutype
	if (<menu_type> = VMenu)
		change popup_previous_menu = <parent_id>
	else
		change \{popup_previous_menu = current_menu}
	endif
	if GotParam \{option_menu}
		if (<option_menu> = 1)
			<menu_pos> = (534.0, 494.0)
		elseif (<option_menu> = 2)
			<menu_pos> = (534.0, 494.0)
		elseif (<option_menu> = 3)
			<menu_pos> = (534.0, 474.0)
		else
			<menu_pos> = (534.0, 454.0)
		endif
		<dialog> = 1
		printf 'creating generic popup menu with %a options' a = <option_menu>
	endif
	if GotParam \{ok_menu}
		<menu_pos> = (534.0, 484.0)
		<dialog> = 1
	endif
	if GotParam \{yes_no_menu}
		<menu_pos> = (534.0, 480.0)
		<dialog> = 1
	endif
	if GotParam \{phrase_window}
		<menu_pos> = (415.0, 250.0)
	endif
	if GotParam \{loading_window}
		<menu_pos> = (534.0, 484.0)
		if GotParam \{can_cancel}
			<dialog> = 1
		endif
	endif
	popup_old_focus_color = ($menu_unfocus_color)
	popup_old_unfocus_color = ($menu_focus_color)
	change menu_focus_color = <popup_old_focus_color>
	change menu_unfocus_color = <popup_old_unfocus_color>
	change \{popup_focus_color = [
			180
			50
			50
			255
		]}
	change \{popup_unfocus_color = [
			0
			0
			0
			255
		]}
	if GotParam \{phrase_window}
		change \{popup_focus_color = [
				223
				223
				223
				255
			]}
		change \{popup_unfocus_color = [
				128
				128
				128
				255
			]}
	endif
	text_scale = <font_scale>
	offwhite = [223 223 223 255]
	if GotParam \{phrase_window}
		generic_popup_event_handlers = [
			{pad_up scroll_phrase_window params = {dir = up}}
			{pad_down scroll_phrase_window params = {dir = down}}
		]
	else
		if NOT ((GotParam ok_menu) || (GotParam loading_window) || (GotParam blank_menu))
			if GotParam \{option_menu}
				if (<option_menu> > 1)
					generic_popup_event_handlers = [
						{pad_up generic_menu_up_or_down_sound params = {up}}
						{pad_down generic_menu_up_or_down_sound params = {down}}
					]
				endif
			else
				generic_popup_event_handlers = [
					{pad_up generic_menu_up_or_down_sound params = {up}}
					{pad_down generic_menu_up_or_down_sound params = {down}}
				]
			endif
		endif
	endif
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = generic_popup_container
		pos = (0.0, 0.0)
		internal_just = [
			center
			center
		]}
	if GotParam \{full_blackout}
		CreateScreenElement {
			type = SpriteElement
			parent = generic_popup_container
			texture = black
			rgba = [0 0 0 255]
			pos = (640.0, 360.0)
			dims = (1280.0, 720.0)
			just = [center center]
			z_priority = <generic_popup_z>
			alpha = <full_blackout>
		}
		CreateScreenElement {
			type = SpriteElement
			parent = generic_popup_container
			rgba = [0 0 0 255]
			texture = black
			pos = (640.0, 360.0)
			dims = (524.0, 320.0)
			just = [center center]
			z_priority = <generic_popup_z>
			alpha = (1.3 - <full_blackout>)
		}
	else
		CreateScreenElement {
			type = SpriteElement
			parent = generic_popup_container
			rgba = [0 0 0 255]
			texture = black
			pos = (640.0, 360.0)
			dims = (524.0, 320.0)
			just = [center center]
			z_priority = <generic_popup_z>
			alpha = 1.0
		}
	endif
	<center_pos> = (640.0, 360.0)
	CreateScreenElement {
		type = SpriteElement
		parent = generic_popup_container
		texture = GH3_Pause_Frame_02
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [bottom right]
		z_priority = (<generic_popup_z> + 2)
	}
	CreateScreenElement {
		type = SpriteElement
		parent = generic_popup_container
		texture = GH3_Pause_Frame_02
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [top right]
		z_priority = (<generic_popup_z> + 2)
		flip_v
	}
	CreateScreenElement {
		type = SpriteElement
		parent = generic_popup_container
		texture = GH3_Pause_Frame_02
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [top left]
		z_priority = (<generic_popup_z> + 2)
		flip_v
		flip_h
	}
	CreateScreenElement {
		type = SpriteElement
		parent = generic_popup_container
		texture = GH3_Pause_Frame_02
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_3>
		just = [bottom left]
		z_priority = (<generic_popup_z> + 2)
		flip_h
	}
	CreateScreenElement {
		type = SpriteElement
		parent = generic_popup_container
		texture = GH3_Pause_Frame_01
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [bottom right]
		z_priority = (<generic_popup_z> + 2)
	}
	CreateScreenElement {
		type = SpriteElement
		parent = generic_popup_container
		texture = GH3_Pause_Frame_01
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [top right]
		z_priority = (<generic_popup_z> + 2)
		flip_v
	}
	CreateScreenElement {
		type = SpriteElement
		parent = generic_popup_container
		texture = GH3_Pause_Frame_01
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [top left]
		z_priority = (<generic_popup_z> + 2)
		flip_v
		flip_h
	}
	CreateScreenElement {
		type = SpriteElement
		parent = generic_popup_container
		texture = GH3_Pause_Frame_01
		rgba = [255 255 255 255]
		pos = (<center_pos>)
		scale = <scale_4>
		just = [bottom left]
		z_priority = (<generic_popup_z> + 2)
		flip_h
	}
	CreateScreenElement {
		type = SpriteElement
		parent = generic_popup_container
		texture = GH3_Pause_Frame_01
		rgba = [0 0 0 255]
		pos = (<center_pos>)
		scale = <scale_5>
		just = [bottom right]
		z_priority = (<generic_popup_z> + 2)
	}
	CreateScreenElement {
		type = SpriteElement
		parent = generic_popup_container
		texture = GH3_Pause_Frame_01
		rgba = [0 0 0 255]
		pos = (<center_pos>)
		scale = <scale_5>
		just = [top right]
		z_priority = 12
		flip_v
	}
	CreateScreenElement {
		type = SpriteElement
		parent = generic_popup_container
		texture = GH3_Pause_Frame_01
		rgba = [0 0 0 255]
		pos = (<center_pos>)
		scale = <scale_5>
		just = [top left]
		z_priority = (<generic_popup_z> + 2)
		flip_v
		flip_h
	}
	CreateScreenElement {
		type = SpriteElement
		parent = generic_popup_container
		texture = GH3_Pause_Frame_01
		rgba = [0 0 0 255]
		pos = (<center_pos>)
		scale = <scale_5>
		just = [bottom left]
		z_priority = (<generic_popup_z> + 2)
		flip_h
	}
	if GotParam \{title}
		popup_title_off = (645.0, 60.0)
		displaySprite parent = generic_popup_container tex = Dialog_Title_BG flip_v pos = (416.0, 0.0) scale = (1.75, 1.75) z = (<generic_popup_z> + 2.1)
		displaySprite parent = generic_popup_container tex = Dialog_Title_BG pos = (640.0, 0.0) scale = (1.75, 1.75) z = (<generic_popup_z> + 2.1)
		if German
			CreateScreenElement {
				type = TextElement
				parent = generic_popup_container
				font = <menu_font>
				text = <title>
				just = [center top]
				pos = {<popup_title_off> relative}
				rgba = [223 223 223 250]
				scale = (1.0, 1.15)
				z_priority = (<generic_popup_z> + 2.2)
				shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba = [0 0 0 255]
			}
		else
			CreateScreenElement {
				type = TextElement
				parent = generic_popup_container
				font = <menu_font>
				text = <title>
				just = [center top]
				pos = {<popup_title_off> relative}
				rgba = [223 223 223 250]
				scale = (1.2, 1.3499999)
				z_priority = (<generic_popup_z> + 2.2)
				shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba = [0 0 0 255]
			}
		endif
	endif
	if GotParam \{message}
		printf 'printing message %a ' a = <message>
		if GotParam \{long_text}
			OSPrintf \{'Using Long Text Dimmensions'}
			message_block_pos = (410.0, 202.0)
			message_block_dims = (606.0, 340.0)
		else
			message_block_pos = (410.0, 220.0)
			message_block_dims = (600.0, 300.0)
		endif
		CreateScreenElement {
			type = TextBlockElement
			id = message_block
			text = <message>
			scale = <message_scale>
			parent = generic_popup_container
			font = <text_font>
			rgba = [210 130 0 250]
			pos = <message_block_pos>
			dims = <message_block_dims>
			just = [left top]
			z_priority = (<generic_popup_z> + 2.2)
		}
	endif
	generic_popup_menu_z = (<generic_popup_z> + 5)
	if GotParam \{phrase_window}
	elseif GotParam \{blank_menu}
	elseif GotParam \{loading_window}
		if GotParam \{can_cancel}
			displaySprite parent = generic_popup_container tex = white pos = (492.0, 517.0) scale = (75.0, 6.0) z = (<generic_popup_menu_z> + 0.1) rgba = <offwhite>
			displaySprite parent = generic_popup_container tex = dialog_frame_joiner pos = (480.0, 510.0) rot_angle = 5 scale = (1.575, 1.5) z = (<generic_popup_menu_z> + 0.2) alpha = 1.0
			displaySprite parent = generic_popup_container tex = dialog_frame_joiner pos = (750.0, 514.0) flip_v rot_angle = -5 scale = (1.575, 1.5) z = (<generic_popup_menu_z> + 0.2) alpha = 1.0
		endif
	else
		displaySprite parent = generic_popup_container tex = white pos = (492.0, 517.0) scale = (75.0, 6.0) z = (<generic_popup_menu_z> + 0.1) rgba = <offwhite>
		displaySprite parent = generic_popup_container tex = dialog_frame_joiner pos = (480.0, 510.0) rot_angle = 5 scale = (1.575, 1.5) z = (<generic_popup_menu_z> + 0.2) alpha = 1.0
		displaySprite parent = generic_popup_container tex = dialog_frame_joiner pos = (750.0, 514.0) flip_v rot_angle = -5 scale = (1.575, 1.5) z = (<generic_popup_menu_z> + 0.2) alpha = 1.0
	endif
	CreateScreenElement {
		type = VScrollingMenu
		parent = root_window
		id = scrolling_generic_popup_menu
		dims = (400.0, 480.0)
		just = [left top]
		pos = <menu_pos>
		z_priority = <generic_popup_menu_z>
	}
	CreateScreenElement {
		type = VMenu
		parent = scrolling_generic_popup_menu
		id = vmenu_generic_popup_menu
		pos = (0.0, 0.0)
		just = [center center]
		internal_just = [center center]
		event_handlers = <generic_popup_event_handlers>
	}
	if GotParam \{phrase_window}
		SetScreenElementProps \{id = scrolling_generic_popup_menu
			dims = (600.0, 300.0)}
		SetScreenElementProps \{id = vmenu_generic_popup_menu
			dont_allow_wrap}
	endif
	if GotParam \{loading_window}
		<largest_width> = 0
		GetScreenElementChildren \{id = message_block}
		GetArraySize <children>
		<i> = 0
		begin
		GetScreenElementDims id = (<children> [<i>])
		if (<largest_width> < <width>)
			<largest_width> = <width>
		endif
		<i> = (<i> + 1)
		repeat <array_size>
		GetScreenElementProps \{id = message_block}
		<starting_pos> = <pos>
		<adjust_width> = ((600 - <largest_width>) / 2.0 - 40)
		<ending_pos> = (<starting_pos> + (<adjust_width> * (1.0, 0.0)))
		SetScreenElementProps id = message_block internal_just = [left center] pos = <ending_pos>
	endif
	if GotParam \{loading_window}
		if GotParam \{can_cancel}
			CreateScreenElement {
				type = TextElement
				parent = vmenu_generic_popup_menu
				font = <menu_font>
				scale = 1.5
				rgba = ($popup_unfocus_color)
				text = $wii_cancel
				just = [center top]
				event_handlers = <cancel_eventhandlers>
				z_priority = (<generic_popup_menu_z> + 5)
			}
			displaySprite parent = generic_popup_container tex = dialog_bg pos = (480.0, 450.0) scale = (2.5, 2.5) z = <generic_popup_menu_z>
			displaySprite parent = generic_popup_container tex = dialog_bg flip_h pos = (480.0, 530.0) scale = (2.5, 2.5) z = <generic_popup_menu_z>
		endif
	elseif GotParam \{ok_menu}
		CreateScreenElement {
			type = TextElement
			parent = vmenu_generic_popup_menu
			font = <menu_font>
			scale = 1.5
			rgba = ($popup_unfocus_color)
			text = $wii_ok
			just = [center top]
			event_handlers = <ok_eventhandlers>
			z_priority = (<generic_popup_menu_z> + 5)
		}
		displaySprite parent = generic_popup_container tex = dialog_bg pos = (480.0, 450.0) scale = (2.5, 2.5) z = <generic_popup_menu_z>
		displaySprite parent = generic_popup_container tex = dialog_bg flip_h pos = (480.0, 530.0) scale = (2.5, 2.5) z = <generic_popup_menu_z>
	elseif GotParam \{yes_no_menu}
		CreateScreenElement {
			type = TextElement
			parent = vmenu_generic_popup_menu
			font = <menu_font>
			id = yes_option
			scale = 1.0
			rgba = ($popup_unfocus_color)
			text = $wii_yes
			just = [center top]
			event_handlers = <yes_eventhandlers>
			z_priority = (<generic_popup_menu_z> + 5)
		}
		CreateScreenElement {
			type = TextElement
			parent = vmenu_generic_popup_menu
			font = <menu_font>
			id = no_option
			scale = 1.0
			rgba = ($popup_unfocus_color)
			text = $wii_no
			just = [center top]
			event_handlers = <no_eventhandlers>
			z_priority = (<generic_popup_menu_z> + 5)
		}
		displaySprite parent = generic_popup_container tex = dialog_bg pos = (480.0, 450.0) scale = (2.5, 2.5) z = <generic_popup_menu_z>
		displaySprite parent = generic_popup_container tex = dialog_bg flip_h pos = (480.0, 530.0) scale = (2.5, 2.5) z = <generic_popup_menu_z>
	elseif GotParam \{option_menu}
		CreateScreenElement {
			type = TextElement
			parent = vmenu_generic_popup_menu
			font = <menu_font>
			id = option1
			scale = <text_scale>
			rgba = ($popup_unfocus_color)
			text = (<option1>.title)
			just = [center top]
			event_handlers = (<option1>.eventhandlers)
			z_priority = (<generic_popup_menu_z> + 5)
		}
		if (<option_menu> > 1)
			CreateScreenElement {
				type = TextElement
				parent = vmenu_generic_popup_menu
				font = <menu_font>
				id = option2
				scale = <text_scale>
				rgba = ($popup_unfocus_color)
				text = (<option2>.title)
				just = [center top]
				event_handlers = (<option2>.eventhandlers)
				z_priority = (<generic_popup_menu_z> + 5)
			}
		endif
		if (<option_menu> > 2)
			CreateScreenElement {
				type = TextElement
				parent = vmenu_generic_popup_menu
				font = <menu_font>
				id = option3
				scale = <text_scale>
				rgba = ($popup_unfocus_color)
				text = (<option3>.title)
				just = [center top]
				event_handlers = (<option3>.eventhandlers)
				z_priority = (<generic_popup_menu_z> + 5)
			}
		endif
		if (<option_menu> > 3)
			CreateScreenElement {
				type = TextElement
				parent = vmenu_generic_popup_menu
				font = <menu_font>
				id = option4
				scale = <text_scale>
				rgba = ($popup_unfocus_color)
				text = (<option4>.title)
				just = [center top]
				event_handlers = (<option4>.eventhandlers)
				z_priority = (<generic_popup_menu_z> + 5)
			}
		endif
		if (<option_menu> = 4)
			displaySprite parent = generic_popup_container tex = dialog_bg pos = (480.0, 428.0) scale = (2.5, 3.2) z = <generic_popup_menu_z>
			displaySprite parent = generic_popup_container tex = dialog_bg flip_h pos = (480.0, 530.0) scale = (2.5, 3.2) z = <generic_popup_menu_z>
		else
			displaySprite parent = generic_popup_container tex = dialog_bg pos = (480.0, 450.0) scale = (2.5, 2.5) z = <generic_popup_menu_z>
			displaySprite parent = generic_popup_container tex = dialog_bg flip_h pos = (480.0, 530.0) scale = (2.5, 2.5) z = <generic_popup_menu_z>
		endif
	elseif GotParam \{phrase_window}
		GetArraySize $<phrase_array>
		numPhrases = <array_size>
		i = 0
		begin
		FormatText checksumname = phraseid 'phraseid%n' n = <i>
		CreateScreenElement {
			type = TextBlockElement
			parent = vmenu_generic_popup_menu
			font = <menu_font>
			id = <phraseid>
			scale = <text_scale>
			rgba = ($popup_unfocus_color)
			text = ($<phrase_array> [<i>])
			just = [center top]
			dims = (600.0, 300.0)
			internal_just = [center center]
			event_handlers = <phrase_eventhandlers>
			z_priority = (<generic_popup_menu_z> + 5)
		}
		<i> = (<i> + 1)
		repeat <numPhrases>
		CreateScreenElement \{type = ContainerElement
			parent = generic_popup_container
			id = arrow_container
			pos = (0.0, 0.0)
			internal_just = [
				center
				center
			]}
		CreateScreenElement {
			type = SpriteElement
			parent = arrow_container
			id = down_arrow
			texture = Scroll_Arrow
			pos = (<center_pos> + (0.0, 86.0))
			just = [center top]
			dims = (64.0, 64.0)
			z_priority = (<generic_popup_menu_z> + 6)
		}
		CreateScreenElement {
			type = SpriteElement
			parent = arrow_container
			id = up_arrow
			texture = Scroll_Arrow
			pos = (<center_pos> + (0.0, -150.0))
			just = [center top]
			flip_h
			dims = (64.0, 64.0)
			z_priority = (<generic_popup_menu_z> + 6)
		}
		change \{generic_up_arrow_enabled = 1}
		change \{generic_down_arrow_enabled = 1}
		change phrase_array_size = <numPhrases>
		change \{phrase_index = 0}
		if (($phrase_array_size) > 1)
			enable_generic_arrow \{dir = down}
		endif
		disable_generic_arrow \{dir = up}
		SpawnScriptLater \{arrow_blinker
			params = {
				time = 0.5
			}}
		FormatText TextName = selection_text '%a of %b' a = (($phrase_index) + 1) b = ($phrase_array_size)
		CreateScreenElement {
			type = TextElement
			parent = generic_popup_container
			text = <selection_text>
			font = <menu_font>
			scale = 0.75
			id = current_phrase_text
			rgba = [223 223 223 255]
			pos = (<center_pos> + (100.0, 150.0))
			just = [left bottom]
			z_priority = (<generic_popup_menu_z> + 5)
		}
	endif
	switch $popup_previous_menu
		case vmenu_main_menu
		vmenu_main_menu :GetTags
		LaunchEvent \{type = unfocus
			target = $popup_previous_menu}
		switch <tag_selected_index>
			case 0
			SetScreenElementProps \{id = main_menu_career_text
				no_shadow}
			case 1
			SetScreenElementProps \{id = main_menu_coop_career_text
				no_shadow}
			case 2
			SetScreenElementProps \{id = main_menu_quickplay_text
				no_shadow}
			case 3
			SetScreenElementProps \{id = main_menu_multiplayer_text
				no_shadow}
			case 4
			SetScreenElementProps \{id = main_menu_training_text
				no_shadow}
			case 5
			SetScreenElementProps \{id = main_menu_options_text
				no_shadow}
			case 6
			SetScreenElementProps \{id = main_menu_leaderboards_text
				no_shadow}
			default
		endswitch
		default
		LaunchEvent \{type = unfocus
			target = $popup_previous_menu}
	endswitch
	if (<dialog> = 1)
		<largest_width> = 0
		GetScreenElementChildren \{id = vmenu_generic_popup_menu}
		GetArraySize <children>
		<i> = 0
		begin
		GetScreenElementDims id = (<children> [<i>])
		if (<largest_width> < <width>)
			<largest_width> = <width>
		endif
		<i> = (<i> + 1)
		repeat <array_size>
		<center_adjust> = ((210 - <largest_width>) / 2)
		GetScreenElementProps \{id = scrolling_generic_popup_menu}
		SetScreenElementProps id = scrolling_generic_popup_menu pos = (<pos> + ((1.0, 0.0) * <center_adjust>))
	endif
	if GotParam \{focus_yes}
		LaunchEvent \{type = focus
			target = vmenu_generic_popup_menu
			data = {
				child_id = yes_option
			}}
	elseif GotParam \{focus_no}
		LaunchEvent \{type = focus
			target = vmenu_generic_popup_menu
			data = {
				child_id = no_option
			}}
	elseif GotParam \{focus_option}
		FormatText checksumname = focused_child 'option%a' a = <focus_option>
		LaunchEvent type = focus target = vmenu_generic_popup_menu data = {child_id = <focused_child>}
	else
		LaunchEvent \{type = focus
			target = vmenu_generic_popup_menu}
	endif
	if GotParam \{loading_window}
		if GotParam \{wait_variable}
			start_loading_process text_block_id = message_block wait_var = <wait_variable> base_text = <message>
		else
			printf \{'No Wait Variable Given, will not start loading progress dots'}
		endif
		if (($generic_popup_loading_window_open) = 1)
			destroy_generic_popup
		endif
	endif
endscript

script destroy_generic_popup 
	if ScreenElementExists \{id = arrow_container}
		KillSpawnedScript \{name = arrow_blinker}
	endif
	if ScreenElementExists \{id = generic_popup_container}
		DestroyScreenElement \{id = generic_popup_container}
	endif
	if ScreenElementExists \{id = vmenu_generic_popup_menu}
		DestroyScreenElement \{id = vmenu_generic_popup_menu}
	endif
	if ScreenElementExists \{id = scrolling_generic_popup_menu}
		DestroyScreenElement \{id = scrolling_generic_popup_menu}
	else
		return
	endif
	change \{generic_popup_open = 0}
	change \{generic_popup_loading_window_open = 0}
	printf \{'swaping menu colors'}
	popup_old_focus_color = ($menu_unfocus_color)
	popup_old_unfocus_color = ($menu_focus_color)
	change menu_focus_color = <popup_old_focus_color>
	change menu_unfocus_color = <popup_old_unfocus_color>
	LaunchEvent \{type = focus
		target = $popup_previous_menu}
endscript

script start_loading_process \{time = 0.3333}
	change \{generic_popup_loading_window_open = 1}
	num_dots = 3
	begin
	<num_dots> = (<num_dots> + 1)
	if (<num_dots> > 3)
		<num_dots> = 0
	endif
	if ($<wait_var> = 0)
		temp_string = <base_text>
		if (<num_dots> > 0)
			begin
			<temp_string> = (<temp_string> + '.')
			repeat <num_dots>
		endif
		SetScreenElementProps id = <text_block_id> text = <temp_string>
	else
		return
	endif
	Wait <time> seconds
	repeat
endscript

script enable_generic_arrow 
	if (<dir> = down)
		if (($generic_down_arrow_enabled) = 1)
			return
		else
			change \{generic_down_arrow_enabled = 1}
		endif
	elseif (<dir> = up)
		if (($generic_up_arrow_enabled) = 1)
			return
		else
			change \{generic_up_arrow_enabled = 1}
		endif
	endif
endscript

script disable_generic_arrow 
	if (<dir> = down)
		if (($generic_down_arrow_enabled) = 0)
			return
		else
			change \{generic_down_arrow_enabled = 0}
		endif
	elseif (<dir> = up)
		if (($generic_up_arrow_enabled) = 0)
			return
		else
			change \{generic_up_arrow_enabled = 0}
		endif
	endif
endscript

script scroll_phrase_window 
	if (<dir> = down)
		if (($phrase_index) < (($phrase_array_size) -1))
			change phrase_index = (($phrase_index) + 1)
			printf 'Scrolling the window down: Index %a Array Size: %b' a = ($phrase_index) b = ($phrase_array_size)
			generic_menu_up_or_down_sound \{params = {
					down
				}}
		endif
	elseif (<dir> = up)
		if (($phrase_index) > 0)
			change phrase_index = (($phrase_index) -1)
			printf 'Scrolling the window up: Index %a Array Size: %b' a = ($phrase_index) b = ($phrase_array_size)
			generic_menu_up_or_down_sound \{params = {
					up
				}}
		endif
	endif
	if (($phrase_index) < (($phrase_array_size) -1))
		enable_generic_arrow \{dir = down}
		printf \{'Enabling down arrow'}
	else
		disable_generic_arrow \{dir = down}
		printf \{'Disabling down arrow'}
	endif
	if (($phrase_index) > 0)
		enable_generic_arrow \{dir = up}
		printf \{'Enabling up arrow'}
	else
		disable_generic_arrow \{dir = up}
		printf \{'Disabling up arrow'}
	endif
	FormatText TextName = selection_text '%a of %b' a = (($phrase_index) + 1) b = ($phrase_array_size)
	SetScreenElementProps id = current_phrase_text text = <selection_text>
endscript

script arrow_blinker \{time = 0.5}
	if NOT ScreenElementExists \{id = arrow_container}
		return
	endif
	begin
	if (($generic_up_arrow_enabled) = 1)
		SetScreenElementProps \{id = up_arrow
			alpha = 1.0
			flip_h}
	else
		SetScreenElementProps \{id = up_arrow
			alpha = 0.0
			flip_h}
	endif
	if (($generic_down_arrow_enabled) = 1)
		SetScreenElementProps \{id = down_arrow
			alpha = 1.0}
	else
		SetScreenElementProps \{id = down_arrow
			alpha = 0.0}
	endif
	doScreenElementMorph id = arrow_container alpha = 1.0 time = <time>
	Wait <time> seconds
	doScreenElementMorph id = arrow_container alpha = 0.0 time = <time>
	Wait <time> seconds
	repeat
endscript
test_wait_var = 0

script stop_waiting 
	change \{test_wait_var = 1}
endscript
network_wait_var = 0

script enable_network_wait_variable 
	printf \{'Enabling the Network Wait Variable'}
	change \{network_wait_var = 0}
endscript

script clear_network_wait_variable 
	printf \{'Clearing the Network Wait Variable'}
	change \{network_wait_var = 1}
endscript

script generic_popup_test 
	if ScreenElementExists \{id = vmenu_generic_popup_menu}
		return
	endif
	change \{test_wait_var = 0}
	create_generic_popup \{title = 'TEST MENU 2'
		loading_window
		can_cancel
		message = 'Please Wait while this loads'
		wait_variable = test_wait_var
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
				stop_waiting
			}
		]
		previous_menu = vmenu_main_menu}
endscript
