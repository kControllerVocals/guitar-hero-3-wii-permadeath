online_signin_autoload_required = 0

script create_online_signin_splash \{menu_id = signin_dialog_menu
		vmenu_id = signin_dialog_vmenu
		pos = (640.0, 520.0)
		z = 110}

	create_menu_backdrop \{texture = Online_Background}
	begin
	if ($net_safe_to_enter_net_play = 1)
		break
	else
		Wait \{0.5
			seconds}
	endif
	repeat
	Wait \{2
		frames}
	change \{online_signin_autoload_required = 0}
	if CheckForSignIn
		NetSessionFunc \{func = onlinesignin}
	else
		if isXenon
			menu_pos = (640.0, 465.0)
			bookend_r_pos = (710.0, 533.0)
			bookend_l_pos = (500.0, 533.0)
			CreateScreenElement \{type = ContainerElement
				parent = root_window
				id = warning_message_container
				pos = (0.0, 0.0)}
			CreateScreenElement {
				type = VScrollingMenu
				parent = warning_message_container
				id = <menu_id>
				just = [center top]
				dims = (500.0, 150.0)
				pos = (640.0, 465.0)
				z_priority = 1
			}
			CreateScreenElement {
				type = VMenu
				parent = <menu_id>
				id = <vmenu_id>
				pos = (298.0, 0.0)
				just = [center top]
				internal_just = [center top]
				dims = (500.0, 150.0)
				event_handlers = [
					{pad_up generic_menu_up_or_down_sound params = {up}}
					{pad_down generic_menu_up_or_down_sound params = {down}}
					{pad_back online_signin_select_cancel}
				]
			}
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
			create_pause_menu_frame \{parent = warning_message_container
				z = 5}
			displaySprite \{parent = warning_message_container
				tex = Dialog_Title_BG
				dims = (224.0, 224.0)
				z = 9
				pos = (640.0, 100.0)
				just = [
					right
					top
				]
				flip_v}
			displaySprite \{parent = warning_message_container
				tex = Dialog_Title_BG
				dims = (224.0, 224.0)
				z = 9
				pos = (640.0, 100.0)
				just = [
					left
					top
				]}
			displaySprite \{parent = warning_message_container
				id = options_bg_1
				tex = dialog_bg
				pos = (640.0, 500.0)
				dims = (320.0, 64.0)
				z = 9
				just = [
					center
					botom
				]}
			displaySprite \{parent = warning_message_container
				id = options_bg_2
				tex = dialog_bg
				pos = (640.0, 530.0)
				dims = (320.0, 64.0)
				z = 9
				just = [
					center
					top
				]
				flip_h}
			CreateScreenElement \{type = TextElement
				parent = warning_message_container
				font = fontgrid_title_gh3
				scale = 1.3
				rgba = [
					223
					223
					223
					250
				]
				text = 'WARNING'
				just = [
					center
					top
				]
				z_priority = 10.0
				pos = (640.0, 175.0)
				shadow
				shadow_offs = (3.0, 3.0)
				shadow_rgba = [
					0
					0
					0
					255
				]}
			if isXenon
				if (NetSessionFunc func = is_cable_unplugged)
					<sign_in_text> = 'Unable to connect to Xbox LIVE. Please check your network connection and settings and try again.'
					single_option = 1
				elseif (CheckForSignIn local)
					<sign_in_text> = 'The current Gamer Profile is not enabled for Xbox LIVE multiplayer game play.'
				else
					<sign_in_text> = 'No gamer profile currently signed in. Please sign into an Xbox LIVE multiplayer enabled gamer profile to continue.'
				endif
			else
				<sign_in_text> = 'The current profile does not have permission to enter the PLAYSTATION®Network lobby.'
			endif
			CreateScreenElement {
				type = TextBlockElement
				parent = warning_message_container
				font = fontgrid_title_gh3
				scale = 0.6
				rgba = [210 210 210 250]
				text = <sign_in_text>
				just = [center top]
				internal_just = [center top]
				internal_scale = <scale>
				z_priority = <z>
				pos = (640.0, 310.0)
				dims = (800.0, 320.0)
				line_spacing = 1.0
			}
			cancel_text = 'CONTINUE'
			if NOT GotParam \{single_option}
				CreateScreenElement {
					type = ContainerElement
					parent = <vmenu_id>
					dims = (100.0, 50.0)
					event_handlers = [
						{focus net_warning_focus}
						{unfocus net_warning_unfocus}
						{pad_choose online_signin_select_signin}
					]
				}
				container_id = <id>
				CreateScreenElement {
					type = TextElement
					parent = <container_id>
					local_id = text
					font = fontgrid_title_gh3
					scale = 0.85
					rgba = ($menu_unfocus_color)
					text = 'SIGN IN'
					just = [center top]
					z_priority = (<z> + 0.1)
				}
				fit_text_into_menu_item id = <id> max_width = 240
				GetScreenElementDims id = <id>
				CreateScreenElement {
					type = SpriteElement
					parent = <container_id>
					local_id = bookend_left
					texture = Dialog_Highlight
					alpha = 0.0
					just = [right center]
					pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (-2)) + (-5.0, 0.0))
					z_priority = (<z> + 0.1)
					scale = (1.0, 1.0)
					flip_v
				}
				CreateScreenElement {
					type = SpriteElement
					parent = <container_id>
					local_id = bookend_right
					texture = Dialog_Highlight
					alpha = 0.0
					just = [left center]
					pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (2)) + (5.0, 0.0))
					z_priority = (<z> + 0.1)
					scale = (1.0, 1.0)
				}
				cancel_text = 'CANCEL'
			endif
			CreateScreenElement {
				type = ContainerElement
				parent = <vmenu_id>
				dims = (100.0, 50.0)
				event_handlers = [
					{focus net_warning_focus}
					{unfocus net_warning_unfocus}
					{pad_choose online_signin_select_cancel}
				]
			}
			container_id = <id>
			CreateScreenElement {
				type = TextElement
				parent = <container_id>
				local_id = text
				font = fontgrid_title_gh3
				scale = 0.85
				rgba = ($menu_unfocus_color)
				text = <cancel_text>
				just = [center top]
				z_priority = (<z> + 0.1)
			}
			fit_text_into_menu_item id = <id> max_width = 240
			GetScreenElementDims id = <id>
			CreateScreenElement {
				type = SpriteElement
				parent = <container_id>
				local_id = bookend_left
				texture = Dialog_Highlight
				alpha = 0.0
				just = [right center]
				pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (-2)) + (-5.0, 0.0))
				z_priority = (<z> + 0.1)
				scale = (1.0, 1.0)
				flip_v
			}
			CreateScreenElement {
				type = SpriteElement
				parent = <container_id>
				local_id = bookend_right
				texture = Dialog_Highlight
				alpha = 0.0
				just = [left center]
				pos = ((0.0, 20.0) + (1.0, 0.0) * (<width> / (2)) + (5.0, 0.0))
				z_priority = (<z> + 0.1)
				scale = (1.0, 1.0)
			}
			change \{user_control_pill_text_color = [
					255
					255
					255
					255
				]}
			change \{user_control_pill_color = [
					0
					0
					0
					255
				]}
			add_user_control_helper \{text = 'SELECT'
				button = green
				z = 100}
			add_user_control_helper \{text = 'BACK'
				button = red
				z = 100}
			add_user_control_helper \{text = 'UP/DOWN'
				button = strumbar
				z = 100}
			LaunchEvent type = focus target = <vmenu_id>
		else
			NetSessionFunc \{func = onlinesignin}
		endif
	endif
endscript

script destroy_online_signin_splash 
	clean_up_user_control_helpers
	destroy_menu_backdrop
	if ScreenElementExists \{id = warning_message_container}
		DestroyScreenElement \{id = warning_message_container}
	endif
	if ScreenElementExists \{id = signin_container}
		DestroyScreenElement \{id = signin_container}
	endif
	if ScreenElementExists \{id = sign_in_scoller}
		DestroyScreenElement \{id = sign_in_scoller}
	endif
endscript

script online_signin_select_signin 
	change \{online_signin_autoload_required = 1}
	NetSessionFunc \{func = onlinesignin}
endscript

script online_signin_select_cancel 
	ui_flow_manager_respond_to_action \{action = cancel}
endscript
