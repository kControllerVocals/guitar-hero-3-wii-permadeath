enter_profile_name_fs = {
	create = create_enter_profile_name_menu
	destroy = destroy_enter_profile_name_menu
	remove_focus = enter_profile_name_remove_focus
	refocus = enter_profile_name_refocus
	actions = [
		{
			action = profile_name_confirmed
			flow_state = main_menu_fs
		}
		{
			action = go_back
			flow_state = main_menu_fs
		}
	]
}

script begin_create_profile 
	ui_flow_manager_respond_to_action \{action = enter_profile_name}
endscript

script begin_create_profile_from_dialog 
	destroy_generic_popup
	EnterCreateProfileMenu
endscript

script back_out_of_select_profile_menu 
	CancelEnterWifiMenu
	set_home_button_allowed
	destroy_generic_popup
endscript

script log_into_profile \{order = -1}
	LogInToValidProfile profile_order = <order>
	destroy_generic_popup
endscript

script want_to_open_select_profile_menu 
	Wait \{3}
	SpawnScriptLater \{open_select_profile_menu}
endscript

script open_select_profile_menu 
	destroy_generic_popup
	GetValidProfileCount
	if (<valid_profile_count> = 1)
		GetProfileName \{profile_index = 1}
		first_profile_name = <profile_name>
		create_generic_popup {
			title = $wii_profiles
			message = $wii_select_profile
			previous_menu = vmenu_main_menu
			option_menu = 3
			option1 = {
				title = <first_profile_name>
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back back_out_of_select_profile_menu}
					{pad_choose log_into_profile params = {order = 1}}
				]
			}
			option2 = {
				title = $wii_create_new
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back back_out_of_select_profile_menu}
					{pad_choose begin_create_profile_from_dialog}
				]
			}
			option3 = {
				title = $wii_delete_profile2
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back back_out_of_select_profile_menu}
					{pad_choose open_delete_profile_menu}
				]
			}
		}
	endif
	if (<valid_profile_count> = 2)
		GetProfileName \{profile_index = 1}
		first_profile_name = <profile_name>
		GetProfileName \{profile_index = 2}
		second_profile_name = <profile_name>
		create_generic_popup {
			title = $wii_profiles
			message = $wii_select_profile
			previous_menu = vmenu_main_menu
			option_menu = 4
			option1 = {
				title = <first_profile_name>
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back back_out_of_select_profile_menu}
					{pad_choose log_into_profile params = {order = 1}}
				]
			}
			option2 = {
				title = <second_profile_name>
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back back_out_of_select_profile_menu}
					{pad_choose log_into_profile params = {order = 2}}
				]
			}
			option3 = {
				title = $wii_create_new
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back back_out_of_select_profile_menu}
					{pad_choose begin_create_profile_from_dialog}
				]
			}
			option4 = {
				title = $wii_delete_profile2
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back back_out_of_select_profile_menu}
					{pad_choose open_delete_profile_menu}
				]
			}
		}
	endif
	if (<valid_profile_count> = 3)
		GetProfileName \{profile_index = 1}
		first_profile_name = <profile_name>
		GetProfileName \{profile_index = 2}
		second_profile_name = <profile_name>
		GetProfileName \{profile_index = 3}
		third_profile_name = <profile_name>
		create_generic_popup {
			title = $wii_profiles
			message = $wii_select_profile
			previous_menu = vmenu_main_menu
			option_menu = 4
			option1 = {
				title = <first_profile_name>
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back back_out_of_select_profile_menu}
					{pad_choose log_into_profile params = {order = 1}}
				]
			}
			option2 = {
				title = <second_profile_name>
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back back_out_of_select_profile_menu}
					{pad_choose log_into_profile params = {order = 2}}
				]
			}
			option3 = {
				title = <third_profile_name>
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back back_out_of_select_profile_menu}
					{pad_choose log_into_profile params = {order = 3}}
				]
			}
			option4 = {
				title = $wii_delete_profile
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back back_out_of_select_profile_menu}
					{pad_choose open_delete_profile_menu}
				]
			}
		}
	endif
endscript

script cancel_delete_menu 
	destroy_generic_popup
	open_select_profile_menu
endscript

script open_delete_profile_menu 
	destroy_generic_popup
	GetValidProfileCount
	if (<valid_profile_count> = 1)
		GetProfileName \{profile_index = 1}
		first_profile_name = <profile_name>
		create_generic_popup {
			title = $wii_profiles
			message = $wii_select_profile
			previous_menu = vmenu_main_menu
			option_menu = 2
			option1 = {
				title = <first_profile_name>
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back cancel_delete_menu}
					{pad_choose ask_delete_confirm params = {order = 1}}
				]
			}
			option2 = {
				title = $wii_back
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back cancel_delete_menu}
					{pad_choose cancel_delete_menu}
				]
			}
		}
	endif
	if (<valid_profile_count> = 2)
		GetProfileName \{profile_index = 1}
		first_profile_name = <profile_name>
		GetProfileName \{profile_index = 2}
		second_profile_name = <profile_name>
		create_generic_popup {
			title = $wii_profiles
			message = $wii_select_profile
			previous_menu = vmenu_main_menu
			option_menu = 3
			option1 = {
				title = <first_profile_name>
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back cancel_delete_menu}
					{pad_choose ask_delete_confirm params = {order = 1}}
				]
			}
			option2 = {
				title = <second_profile_name>
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back cancel_delete_menu}
					{pad_choose ask_delete_confirm params = {order = 2}}
				]
			}
			option3 = {
				title = $wii_back
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back cancel_delete_menu}
					{pad_choose cancel_delete_menu}
				]
			}
		}
	endif
	if (<valid_profile_count> = 3)
		GetProfileName \{profile_index = 1}
		first_profile_name = <profile_name>
		GetProfileName \{profile_index = 2}
		second_profile_name = <profile_name>
		GetProfileName \{profile_index = 3}
		third_profile_name = <profile_name>
		create_generic_popup {
			title = $wii_profiles
			message = $wii_select_profile
			previous_menu = vmenu_main_menu
			option_menu = 4
			option1 = {
				title = <first_profile_name>
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back cancel_delete_menu}
					{pad_choose ask_delete_confirm params = {order = 1}}
				]
			}
			option2 = {
				title = <second_profile_name>
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back cancel_delete_menu}
					{pad_choose ask_delete_confirm params = {order = 2}}
				]
			}
			option3 = {
				title = <third_profile_name>
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back cancel_delete_menu}
					{pad_choose ask_delete_confirm params = {order = 3}}
				]
			}
			option4 = {
				title = $wii_back
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_back cancel_delete_menu}
					{pad_choose cancel_delete_menu}
				]
			}
		}
	endif
endscript

script delete_profile 
	destroy_generic_popup
	DeleteProfile profile_order = <order>
endscript

script cancel_ask_delete_confirm 
	destroy_generic_popup
	open_delete_profile_menu
endscript

script ask_delete_confirm 
	destroy_generic_popup
	GetProfileName profile_index = <order>
	FormatText TextName = delete_message_text $wii_delete_confirm2 a = (<profile_name>)
	create_generic_popup {
		title = $wii_delete_profile
		message = <delete_message_text>
		previous_menu = vmenu_main_menu
		yes_no_menu
		yes_eventhandlers = [
			{focus popup_menu_focus}
			{unfocus popup_menu_unfocus}
			{pad_choose delete_profile params = {order = <order>}}
		]
		no_eventhandlers = [
			{focus popup_menu_focus}
			{unfocus popup_menu_unfocus}
			{pad_choose cancel_ask_delete_confirm}
		]
	}
endscript
