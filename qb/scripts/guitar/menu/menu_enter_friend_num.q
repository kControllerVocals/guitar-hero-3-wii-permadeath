add_friend_num_fs = {
	create = create_enter_friend_num_menu
	destroy = destroy_enter_friend_num_menu
	remove_focus = enter_friend_num_remove_focus
	refocus = enter_friend_num_refocus
	actions = [
		{
			action = go_back
			flow_state = online_friendlist_fs
		}
	]
}
new_friend_num = [
	'0'
	'0'
	'0'
	'0'
	'0'
	'0'
	'0'
	'0'
	'0'
	'0'
	'0'
	'0'
]
new_friend_num_starting_char = '0'
new_friend_num_index = 0
max_friend_numbers = 12
default_friend_num_characters = [
	'0'
	'1'
	'2'
	'3'
	'4'
	'5'
	'6'
	'7'
	'8'
	'9'
]
friend_num_position = (725.0, 345.0)
default_friend_num_indexes = [
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
	0
]
enter_friend_num_big_vals = {
	text_scale = 1.8
	text_pos = (725.0, 320.0)
	background_pos = (640.0, 360.0)
	background_dims = (1280.0, 720.0)
	header_pos = (730.0, 164.0)
	header_scale = 1.5
	tour_pos = (625.0, 410.0)
	tour_scale = 1.0
	address_pos = (625.0, 445.0)
	address_scale = 1.0
	date_pos = (625.0, 500.0)
	date_scale = 0.85
	sponsor_pos = (925.0, 402.0)
	sponsor_scale = 0.7
	sponsor_dims = (128.0, 128.0)
	sponsor_offset = (0.0, 20.0)
	right_side_img_pos = (1160.0, 330.0)
	right_side_img_dims = (196.0, 408.0)
}

script create_enter_friend_num_menu 
	SetScreenElementProps \{id = root_window
		event_handlers = [
			{
				pad_start
				null_script
			}
		]
		replace_handlers}
	change \{new_friend_num = [
			'0'
			''
			''
			''
			''
			''
			''
			''
			''
			''
			''
			''
		]}
	change \{new_friend_num_index = 0}
	change \{default_friend_num_indexes = [
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
			0
		]}
	rotation_angle = -2
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = efn_container
		pos = (0.0, 0.0)}
	CreateScreenElement \{type = SpriteElement
		parent = efn_container
		id = menu_backdrop
		texture = Venue_BG
		rgba = [
			255
			255
			255
			255
		]
		pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		blend = diffuse
		just = [
			center
			center
		]
		z_priority = 0}
	CreateScreenElement \{type = SpriteElement
		parent = efn_container
		id = ticket_image
		texture = band_name_ticket
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
		z_priority = 1}
	CreateScreenElement {
		type = SpriteElement
		parent = efn_container
		id = random_image
		texture = band_name_graphic03
		rgba = [255 255 255 255]
		pos = (($enter_friend_num_big_vals).right_side_img_pos)
		dims = (($enter_friend_num_big_vals).right_side_img_dims)
		z_priority = 2
	}
	rand = 0
	GetRandomValue \{name = rand
		Integer
		a = 0
		b = 2}
	if (<rand> = 0)
		SetScreenElementProps \{id = random_image
			texture = band_name_graphic01}
	elseif (<rand> = 1)
		SetScreenElementProps \{id = random_image
			texture = band_name_graphic02}
	elseif (<rand> = 2)
		SetScreenElementProps \{id = random_image
			texture = band_name_graphic03}
	endif
	black = [70 10 10 255]
	Blue = [30 110 150 255]
	nameColor = [180 70 35 255]
	activeColor = [230 130 65 255]
	CreateScreenElement {
		type = TextElement
		parent = efn_container
		font = text_a7
		text = $wii_add_friend
		id = efn_header_text
		pos = (($enter_friend_num_big_vals).header_pos)
		rot_angle = <rotation_angle>
		rgba = <black>
		just = [center top]
		scale = (($enter_friend_num_big_vals).header_scale)
	}
	CreateScreenElement {
		type = TextElement
		parent = efn_container
		font = text_a7
		text = $wii_enter_12
		id = efn_tour_text
		pos = (($enter_friend_num_big_vals).tour_pos)
		rot_angle = <rotation_angle>
		rgba = <black>
		just = [center top]
		scale = (($enter_friend_num_big_vals).tour_scale)
	}
	CreateScreenElement {
		type = TextElement
		parent = efn_container
		font = text_a7
		text = $wii_friend_code
		id = efn_address_text
		pos = (($enter_friend_num_big_vals).address_pos)
		rot_angle = <rotation_angle>
		rgba = <black>
		just = [center top]
		scale = (($enter_friend_num_big_vals).address_scale)
	}
	CreateScreenElement {
		type = TextElement
		parent = efn_container
		font = text_a7
		text = $wii_sponsored_by
		id = efn_sponsor_text
		pos = (($enter_friend_num_big_vals).sponsor_pos)
		rot_angle = <rotation_angle>
		rgba = <black>
		just = [center top]
		scale = (($enter_friend_num_big_vals).sponsor_scale)
	}
	CreateScreenElement {
		type = SpriteElement
		parent = efn_container
		id = logo_vault_image
		texture = setlist_icon_generic
		pos = (($enter_friend_num_big_vals).sponsor_pos + ($enter_friend_num_big_vals).sponsor_offset)
		dims = (($enter_friend_num_big_vals).sponsor_dims)
		rot_angle = <rotation_angle>
		just = [center top]
		blend = subtract
	}
	CreateScreenElement {
		type = TextElement
		parent = efn_container
		font = text_a7
		scale = (($enter_friend_num_big_vals).text_scale)
		rgba = <nameColor>
		rot_angle = <rotation_angle>
		text = ($new_friend_num_starting_char)
		id = friend_num_text
		pos = (($enter_friend_num_big_vals).text_pos)
		just = [center center]
	}
	CreateScreenElement {
		type = TextElement
		parent = efn_container
		font = text_a7
		scale = (($enter_friend_num_big_vals).text_scale)
		rgba = <activeColor>
		text = ($new_friend_num_starting_char)
		id = friend_num_entry_char
		pos = ($friend_num_position - (0.0, 100.0))
		rot_angle = <rotation_angle>
		just = [center center]
		z_priority = -5
	}
	CreateScreenElement {
		type = SpriteElement
		parent = efn_container
		id = efn_marker
		texture = band_name_underline
		just = [center center]
		event_handlers = [
			{pad_up enter_friend_num_change_character params = {up}}
			{pad_down enter_friend_num_change_character params = {down}}
			{pad_choose friend_num_advance_pointer}
			{pad_back friend_num_retreat_pointer}
			{pad_start confirm_friend_num}
		]
		rgba = <activeColor>
		exclusive_device = ($primary_controller)
	}
	RunScriptOnScreenElement \{id = efn_marker
		blinker
		params = {
			id = efn_marker
			time = 0.5
		}}
	LaunchEvent \{type = focus
		target = efn_marker}
	menu_efn_update_marker
	add_user_control_helper \{button = green
		text = $wii_next}
	add_user_control_helper \{button = red
		text = $wii_back}
	add_user_control_helper \{button = strumbar
		text = $wii_updown}
	add_user_control_helper \{button = start
		text = $wii_add_friend}
	FormatText checksumname = textid 'uc_text_%d' d = ($num_user_control_helpers -1)
	change add_friend_helper = <textid>
	SetScreenElementProps \{id = $add_friend_helper
		rgba = [
			192
			0
			0
			255
		]}
endscript
add_friend_helper = 0

script destroy_enter_friend_num_menu 
	destroy_menu \{menu_id = efn_container}
	destroy_menu_backdrop
	SetScreenElementProps \{id = root_window
		event_handlers = [
			{
				pad_start
				gh3_start_pressed
			}
		]
		replace_handlers}
	clean_up_user_control_helpers
endscript

script confirm_friend_num 
	if (($new_friend_num_index + 1) < $max_friend_numbers)
		return
	endif
	num_spaces = 0
	array_entry = 0
	begin
	if ($new_friend_num [<array_entry>] = ' ')
		<num_spaces> = (<num_spaces> + 1)
	endif
	repeat ($max_friend_numbers)
	if (<num_spaces> > 0)
		printf \{'Invalid Friend Code'}
	else
		menu_efn_get_friend_num_text
		FormatText TextName = confirm_message $wii_add_friend_confirm a = <friend_num_text_string>
		create_generic_popup {
			yes_no_menu
			yes_eventhandlers = [
				{focus popup_menu_focus}
				{unfocus popup_menu_unfocus}
				{pad_choose add_friend_post_confirm}
			]
			no_eventhandlers = [
				{focus popup_menu_focus}
				{unfocus popup_menu_unfocus}
				{pad_choose destroy_generic_popup}
			]
			message = <confirm_message>
			previous_menu = efn_marker
		}
	endif
endscript

script add_friend_post_confirm 
	destroy_generic_popup
	menu_efn_get_friend_num_text
	AddFriend friend_key = <friend_num_text_string>
	if (<error> = 0)
		printf 'Adding Friend with code %i' i = <friend_num_text_string>
		enable_network_wait_variable
		create_generic_popup \{loading_window
			message = $wii_adding_friend
			wait_variable = network_wait_var
			previous_menu = efn_marker}
		enable_network_wait_variable
		UpdateFriendsList
		create_generic_popup \{loading_window
			message = $wii_loading_friends_list
			wait_variable = network_wait_var
			previous_menu = efn_marker}
		ui_flow_manager_respond_to_action \{action = go_back}
	else
		FormatText checksumname = error_code 'wii_add_error%a' a = <error>
		printf 'Error adding friend with code %j' j = <friend_num_text_string>
		create_generic_popup {
			ok_menu
			message = ($<error_code>)
			ok_eventhandlers = [
				{focus popup_menu_focus}
				{unfocus popup_menu_unfocus}
				{pad_choose destroy_generic_popup}
			]
			previous_menu = efn_marker
		}
	endif
endscript

script enter_friend_num_change_character 
	if GotParam \{device_num}
		if IsGuitarController controller = <device_num>
			if GotParam \{up}
				change_friend_character_down
			else
				change_friend_character_up
			endif
		else
			if GotParam \{up}
				change_friend_character_up
			else
				change_friend_character_down
			endif
		endif
	endif
endscript

script enter_friend_num_remove_focus 
	LaunchEvent \{type = unfocus
		target = scrolling_enter_friend_num}
endscript

script enter_friend_num_refocus 
	LaunchEvent \{type = focus
		target = scrolling_enter_friend_num}
endscript

script change_friend_character_up 
	generic_menu_up_or_down_sound \{up}
	SetArrayElement ArrayName = default_friend_num_indexes GlobalArray index = $new_friend_num_index newvalue = ($default_friend_num_indexes [$new_friend_num_index] + 1)
	GetArraySize \{$default_friend_num_characters}
	if ($default_friend_num_indexes [$new_friend_num_index] > (<array_size> -1))
		SetArrayElement \{ArrayName = default_friend_num_indexes
			GlobalArray
			index = $new_friend_num_index
			newvalue = 0}
	endif
	SetArrayElement ArrayName = new_friend_num GlobalArray index = $new_friend_num_index newvalue = ($default_friend_num_characters [($default_friend_num_indexes [$new_friend_num_index])])
	menu_efn_refresh_friend_num
endscript

script change_friend_character_down 
	generic_menu_up_or_down_sound \{down}
	SetArrayElement ArrayName = default_friend_num_indexes GlobalArray index = $new_friend_num_index newvalue = ($default_friend_num_indexes [$new_friend_num_index] -1)
	GetArraySize \{$default_friend_num_characters}
	if ($default_friend_num_indexes [$new_friend_num_index] < 0)
		SetArrayElement ArrayName = default_friend_num_indexes GlobalArray index = $new_friend_num_index newvalue = (<array_size> -1)
	endif
	SetArrayElement ArrayName = new_friend_num GlobalArray index = $new_friend_num_index newvalue = ($default_friend_num_characters [($default_friend_num_indexes [$new_friend_num_index])])
	menu_efn_refresh_friend_num
endscript

script friend_num_advance_pointer 
	if (($new_friend_num_index + 1) < $max_friend_numbers)
		generic_menu_pad_choose_sound
		change new_friend_num_index = ($new_friend_num_index + 1)
		SetArrayElement ArrayName = new_friend_num GlobalArray index = $new_friend_num_index newvalue = ($default_friend_num_characters [($default_friend_num_indexes [$new_friend_num_index])])
		menu_efn_refresh_friend_num
	endif
endscript

script friend_num_retreat_pointer 
	if ($new_friend_num_index = 0)
		ui_flow_manager_respond_to_action \{action = go_back}
	endif
	if (($new_friend_num_index -1) > -1)
		generic_menu_pad_back_sound
		change new_friend_num_index = ($new_friend_num_index -1)
		SetArrayElement ArrayName = new_friend_num GlobalArray index = ($new_friend_num_index + 1) newvalue = ''
		menu_efn_refresh_friend_num
	endif
endscript

script menu_efn_get_friend_num_text 
	FormatText TextName = friend_num_text_string '%a%b%c%d%e%f%g%h%i%j%k%l' a = ($new_friend_num [0]) b = ($new_friend_num [1]) c = ($new_friend_num [2]) d = ($new_friend_num [3]) e = ($new_friend_num [4]) f = ($new_friend_num [5]) g = ($new_friend_num [6]) h = ($new_friend_num [7]) i = ($new_friend_num [8]) j = ($new_friend_num [9]) k = ($new_friend_num [10]) l = ($new_friend_num [11])
	return friend_num_text_string = <friend_num_text_string>
endscript
menu_efn_width_threshold = 609
menu_efn_backdrop_pos_change_factor = (100.0, 0.0)

script menu_efn_refresh_friend_num 
	if (($new_friend_num_index + 1) = $max_friend_numbers)
		SetScreenElementProps \{id = $add_friend_helper
			rgba = [
				0
				192
				0
				255
			]}
	else
		SetScreenElementProps \{id = $add_friend_helper
			rgba = [
				192
				0
				0
				255
			]}
	endif
	menu_efn_get_friend_num_text
	vals_struct = ($enter_friend_num_big_vals)
	SetScreenElementProps id = friend_num_text text = (<friend_num_text_string>) scale = (<vals_struct>.text_scale) pos = (<vals_struct>.text_pos)
	SetScreenElementProps id = friend_num_entry_char scale = (<vals_struct>.text_scale)
	GetScreenElementDims \{id = friend_num_text}
	SetScreenElementProps id = menu_backdrop pos = (<vals_struct>.background_pos) dims = (<vals_struct>.background_dims)
	SetScreenElementProps id = ticket_image pos = (<vals_struct>.background_pos) dims = (<vals_struct>.background_dims)
	SetScreenElementProps id = efn_header_text pos = (<vals_struct>.header_pos) scale = (<vals_struct>.header_scale)
	SetScreenElementProps id = efn_tour_text pos = (<vals_struct>.tour_pos) scale = (<vals_struct>.tour_scale)
	SetScreenElementProps id = efn_address_text pos = (<vals_struct>.address_pos) scale = (<vals_struct>.address_scale)
	SetScreenElementProps id = efn_sponsor_text pos = (<vals_struct>.sponsor_pos) scale = (<vals_struct>.sponsor_scale)
	SetScreenElementProps id = logo_vault_image pos = ((<vals_struct>.sponsor_pos) + (<vals_struct>.sponsor_offset)) dims = (<vals_struct>.sponsor_dims)
	SetScreenElementProps id = random_image pos = ((<vals_struct>.right_side_img_pos)) dims = (<vals_struct>.right_side_img_dims)
	menu_efn_update_marker
endscript

script menu_efn_update_marker 
	current_char = ($default_friend_num_characters [($default_friend_num_indexes [($new_friend_num_index)])])
	SetScreenElementProps id = friend_num_entry_char text = <current_char>
	GetScreenElementDims \{id = friend_num_entry_char}
	new_width = <width>
	new_height = <Height>
	fastscreenelementpos \{id = friend_num_text}
	GetScreenElementDims \{id = friend_num_text}
	new_pos = (<screenelementpos> + (1.0, 0.0) * 0.5 * <width> - (1.0, 0.0) * <new_width> * 0.5)
	GetScreenElementDims \{id = efn_marker}
	SetScreenElementProps id = efn_marker dims = ((1.0, 0.0) * <new_width> + (0.0, 1.0) * <Height>) pos = (<new_pos> + (<new_height> * 0.6 * (0.0, 1.0)))
endscript
