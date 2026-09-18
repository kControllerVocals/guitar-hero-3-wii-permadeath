
script spawn_reject 
	GetFriendName index = <index>
	FormatText TextName = reject_text ($wii_reject_dialog) a = <nickName> b = ($reject_phrases_full [<phrase>])
	create_generic_popup {
		title = $wii_rejected
		ok_menu
		message = <reject_text>
		ok_eventhandlers = [
			{focus popup_menu_focus}
			{unfocus popup_menu_unfocus}
			{pad_choose ok_after_reject}
		]
		previous_menu = vmenu_character_select_p1
	}
endscript
should_spawn_disconnect = 0

script safe_spawn_disconnect 
	change \{should_spawn_disconnect = 1}
endscript

script check_player_disconnect 
	begin
	if ($should_spawn_disconnect = 1)
		change \{should_spawn_disconnect = 0}
		spawn_disconnect
		return
	endif
	if ($in_net_lobby = 0)
		return
	endif
	Wait \{10
		gameframes}
	repeat
endscript

script spawn_disconnect 
	if ScreenElementExists \{id = warning_message_container}
		leaving_lobby_dialog_unfocus
		destroy_leaving_lobby_dialog
	endif
	create_generic_popup \{title = $wii_error
		ok_menu
		message = $wii_wifi_friend_disconnect
		ok_eventhandlers = [
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
				ok_after_reject
			}
		]
		previous_menu = vmenu_character_select_p1}
endscript

script ok_after_reject 
	destroy_generic_popup
	network_player_lobby_message \{type = character_select
		action = deselect}
	if NOT ($ui_flow_manager_state [0] = online_character_select_fs)
		ui_flow_manager_respond_to_action \{action = handle_dropped_client}
		Wait \{1
			gameframe}
	endif
	cs_go_back \{params = {
			player = 1
		}}
	quit_network_game
endscript

script spawn_leavegame 
	if ScreenElementExists \{id = warning_message_container}
		leaving_lobby_dialog_unfocus
		destroy_leaving_lobby_dialog
	endif
	create_generic_popup \{title = $wii_error
		ok_menu
		message = $wii_wifi_friend_leave
		ok_eventhandlers = [
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
				ok_after_reject
			}
		]
		previous_menu = vmenu_character_select_p1}
endscript
invite_pos = (0.0, 0.0)

script spawn_invite 
	GetFriendName index = <index>
	FormatText checksumname = invite_id '%n%i' n = <nickName> i = <index> AddToStringLookup = true
	if ScreenElementExists id = <invite_id>
		DestroyScreenElement id = <invite_id>
		Wait \{1
			gameframe}
	endif
	if ScreenElementExists \{id = invite_container}
		return
	endif
	CreateScreenElement \{type = ContainerElement
		id = invite_container
		parent = root_window
		pos = (150.0, 150.0)
		just = [
			left
			top
		]}
	base_pos = $invite_pos
	top_pos = (($invite_pos) + (19.0, 0.0))
	displaySprite parent = invite_container tex = invite_single_tex pos = <base_pos> dims = (128.0, 128.0) z = 101
	Wait \{20
		gameframes}
	displaySprite parent = invite_container tex = invite_host_tex pos = <top_pos> dims = (128.0, 128.0) z = 102
	Wait \{15
		gameframes}
	text_box_pos = $invite_pos
	<text_box_pos> = (<text_box_pos> + (80.0, 48.0))
	CreateScreenElement {
		type = SpriteElement
		id = invite_name_box
		parent = invite_container
		rgba = [0 0 0 255]
		pos = <text_box_pos>
		alpha = 1
		scale = (1.0, 1.0)
		dims = (1.0, 35.0)
		just = [left top]
		z_priority = 99
	}
	text_pos = (<text_box_pos> + (30.0, 2.0))
	CreateScreenElement {
		type = TextElement
		id = invite_text
		parent = invite_container
		rgba = [255 255 255 255]
		alpha = 0
		pos = <text_pos>
		font = text_a1
		scale = 0.8
		text = <nickName>
		just = [left top]
		z_priority = 100
	}
	GetScreenElementDims \{id = invite_text}
	printf 'TextElementWidth: %a' a = <width>
	box_width = ((<width>) * (1.0, 0.0) + (40.0, 1.0))
	invite_name_box :DoMorph scale = <box_width> scale_relative time = 0.5 Anim = fast_out
	SetScreenElementProps \{id = invite_text
		alpha = 1}
	Wait \{60
		gameframes}
	DestroyScreenElement \{id = invite_text}
	invite_name_box :DoMorph \{scale = (1.0, 1.0)
		scale_relative
		time = 0.5
		Anim = fast_in}
	if ScreenElementExists \{id = invite_container}
		DestroyScreenElement \{id = invite_container}
	endif
endscript

script check_invite 
	CheckForInvite index = <index>
endscript

script accept_invite 
	destroy_generic_popup
	GetFriendInfo index = ($friendlist_selection_index)
	printf 'Accepting an Invite from %a in my friend list' a = <nickName>
	online_menu_select_join_friend friend_index = (<resolvedIndex>)
endscript
