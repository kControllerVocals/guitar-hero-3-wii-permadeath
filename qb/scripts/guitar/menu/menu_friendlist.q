choose_specific_friend = 0
invite_tutorial = 0
online_friendlist_fs = {
	create = create_friendlist_menu
	destroy = destroy_friendlist_menu
	actions = [
		{
			action = add_friend
			flow_state = add_friend_num_fs
		}
		{
			action = go_back
			flow_state = online_menu_fs
		}
		{
			action = select_join_friend
			flow_state = quick_match_joining_game_fs
		}
		{
			action = invite_go_back
			flow_state = create_match_select_venue_fs
		}
		{
			action = invite_friend
			transition_screen = default_joining_screen
			func = setup_and_post_game
			flow_state = online_character_select_fs
		}
	]
}
friendlist_solid_lines = [
	Setlist_Page1_Line_Solid1
	Setlist_Page1_Line_Solid2
	Setlist_Page1_Line_Solid3
]
friendlist_dotted_lines = [
	Setlist_Page1_Line_Dotted1
	Setlist_Page1_Line_Dotted2
	Setlist_Page1_Line_Dotted3
]
friendlist_loop_stars = [
	Setlist_Page1_Loop_Star1
	Setlist_Page1_Loop_Star2
	Setlist_Page1_Loop_Star3
]
friendlist_line_index = 0
friendlist_line_max = 26
friendlist_menu_pos = (340.0, 440.0)
friendlist_begin_text = (0.0, 0.0)
friendlist_background_pos = (0.0, 0.0)
friendlist_background_loop_pos = (0.0, 676.0)
friendlist_background_loop_num = 0
friendlist_page1_loop_pos = (160.0, 768.0)
friendlist_page1_num = 0
friendlist_previous_selection_index = 0
friendlist_previous_selection_tier = 1
friendlist_previous_selection_friend = 1
friendlist_selection_index = 0
friendlist_selection_tier = 1
friendlist_selection_friend = 1
friendlist_num_friends = 0
friendlist_clip_last_rot = 0
friendlist_clip_rot_neg = 0
friendlist_solid_line_pos = (0.0, 0.0)
friendlist_dotted_line_pos = (0.0, 0.0)
friendlist_solid_line_add = (0.0, 80.0)
friendlist_line_num = 0
friendlist_page1_dims = (922.0, 512.0)
friendlist_text_z = 4.1
friendlist_page1_z = 0

script friendlist_go_back 
	if ($choose_specific_friend = 0)
		ui_flow_manager_respond_to_action \{action = go_back}
	else
		ui_flow_manager_respond_to_action \{action = invite_go_back}
	endif
endscript

script friendlist_add_friend 
	ui_flow_manager_respond_to_action \{action = add_friend}
endscript

script friendlist_friend_options 
	disable_friend_list_refresh
	create_context_friend_menu
endscript

script friendlist_delete_friend 
	friend = $friendlist_selection_index
	printf 'Friend Selection %a ' a = <friend>
	printf 'Deleting Friend with index %c' c = <friend>
	DeleteFriend index = <friend>
endscript
num_friends_online = 0
num_friends_offline = 0
num_friends_pending = 0

script update_friends_list 
	GetMyFriendNum
	printf 'My Friend Number: %n' n = <myFriendKey>
	GetNumFriends
	printf 'Number of Friends: %i' i = <numFriends>
	change num_friends_online = <numFriendsOnline>
	if ($choose_specific_friend = 0)
		change num_friends_offline = <numFriendsOffline>
		change num_friends_pending = <numFriendsPending>
	else
		if (<numFriendsOnline> = 0)
			spawn_no_friends_dialog
		endif
		change \{num_friends_offline = 0}
		change \{num_friends_pending = 0}
	endif
endscript
allow_friend_list_refresh = 0

script can_refresh_friend_list 
	return \{allowed = $allow_friend_list_refresh}
endscript

script disable_friend_list_refresh 
	change \{allow_friend_list_refresh = 0}
endscript

script enable_friend_list_refresh 
	change \{allow_friend_list_refresh = 1}
endscript

script create_friendlist_menu 
	enable_friend_list_refresh
	Menu_Music_Off \{setflag = 1}
	create_friendlist_scrolling_menu
	change \{friendlist_page1_z = 3.5}
	update_friends_list
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = friendlist_loops_menu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	displaySprite \{parent = friendlist_loops_menu
		tex = Setlist_Page1_Loop
		pos = $friendlist_page1_loop_pos
		dims = $friendlist_page1_dims
		z = $friendlist_page1_z}
	<tab> = tab_friendlist
	create_fl_assets <tab>
	if ($num_friends_online < 1)
		if ($num_friends_offline < 1)
			change \{friendlist_selection_tier = 3}
		else
			change \{friendlist_selection_tier = 2}
		endif
	else
		change \{friendlist_selection_tier = 1}
	endif
	change \{friendlist_selection_index = 0}
	change \{friendlist_selection_friend = 1}
	GetNumFriends
	if ((<numFriends> = 0) && ($invite_tutorial = 0))
		change \{invite_tutorial = 1}
		create_generic_popup \{ok_menu
			full_blackout = 0.6
			message_scale = 0.746
			message = $wii_invite_info
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
					block_refresh_and_destroy
				}
			]}
		Wait \{1
			gameframe}
		base_pos = (150.0, 40.0)
		top_pos = (<base_pos> + (19.0, 0.0))
		CreateScreenElement \{type = ContainerElement
			parent = generic_popup_container
			id = invite_icon_container
			pos = (0.0, 0.0)
			internal_just = [
				center
				center
			]}
		displaySprite parent = invite_icon_container tex = invite_single_tex pos = <base_pos> dims = (128.0, 128.0) z = 150
		displaySprite parent = invite_icon_container tex = invite_host_tex pos = <top_pos> dims = (128.0, 128.0) z = 151
		SetScreenElementProps \{id = invite_icon_container
			alpha = 0}
		blink_invite
	else
		SpawnScript \{delayed_refresh}
	endif
endscript

script create_friendlist_scrolling_menu 
	if ($choose_specific_friend = 0)
		friendlist_event_handlers = [
			{pad_up friendlist_scroll params = {dir = up}}
			{pad_down friendlist_scroll params = {dir = down}}
			{pad_back friendlist_go_back}
			{pad_choose friendlist_friend_options}
			{pad_l1 friendlist_add_friend}
		]
	else
		friendlist_event_handlers = [
			{pad_up friendlist_scroll params = {dir = up}}
			{pad_down friendlist_scroll params = {dir = down}}
			{pad_back friendlist_go_back}
			{pad_choose friendlist_invite_friend}
		]
	endif
	new_menu {
		scrollid = scrolling_friendlist
		vmenuid = vmenu_friendlist
		use_backdrop = 0
		no_wrap
		z = -1
		event_handlers = <friendlist_event_handlers>
	}
	set_focus_color \{rgba = [
			200
			120
			0
			250
		]}
	set_unfocus_color \{rgba = [
			50
			30
			10
			255
		]}
endscript

script destroy_friendlist_scrolling_menu 
	destroy_menu \{menu_id = scrolling_friendlist}
	clean_up_user_control_helpers
endscript

script destroy_friendlist_menu 
	disable_friend_list_refresh
	change \{friendlist_selection_tier = 1}
	change \{friendlist_selection_index = 0}
	change \{friendlist_selection_friend = 1}
	destroy_menu \{menu_id = scrolling_friendlist}
	destroy_menu \{menu_id = friendlist_menu}
	destroy_menu \{menu_id = friendlist_loops_menu}
	reset_fl_vars \{del}
	clean_up_user_control_helpers
endscript

script friendlist_scroll \{dir = down}
	if ($friendlist_num_friends = 0)
		return
	endif
	if (<dir> = down)
		if ($friendlist_selection_index + 1 = $friendlist_num_friends)
			return
		endif
	else
		if ($friendlist_selection_index - 1 < 0)
			return
		endif
	endif
	FormatText \{checksumname = textid
		'id_friend%i'
		i = $friendlist_selection_index
		AddToStringLookup = true}
	retail_menu_unfocus id = <textid>
	SetScreenElementProps id = <textid> no_shadow
	if (<dir> = down)
		printf \{'Moving down from Tier: %a , Selection Index: %b, Selection Friend %c'
			a = $friendlist_selection_tier
			b = $friendlist_selection_index
			c = $friendlist_selection_friend}
		jump_tier = 0
		change friendlist_selection_index = ($friendlist_selection_index + 1)
		change friendlist_selection_friend = ($friendlist_selection_friend + 1)
		if ($friendlist_selection_tier = 1)
			if ($friendlist_selection_friend > $num_friends_online)
				change \{friendlist_selection_friend = 1}
				if ($num_friends_offline = 0)
					change friendlist_selection_tier = ($friendlist_selection_tier + 2)
				else
					change friendlist_selection_tier = ($friendlist_selection_tier + 1)
				endif
				jump_tier = 1
			endif
		endif
		if ($friendlist_selection_tier = 2)
			if ($friendlist_selection_friend > $num_friends_offline)
				change \{friendlist_selection_friend = 1}
				change friendlist_selection_tier = ($friendlist_selection_tier + 1)
				jump_tier = 1
			endif
		endif
		jump_tier_amt = (0.0, -240.0)
		if ($friendlist_selection_index = 0)
			song_jump_amt = (0.0, -80.0)
			GetScreenElementProps \{id = fl_clipart}
			SetScreenElementProps id = fl_clipart pos = (<pos> - (0.0, 80.0))
			GetScreenElementProps \{id = fl_clip}
			SetScreenElementProps id = fl_clip pos = (<pos> - (0.0, 80.0))
			GetScreenElementProps \{id = fl_highlight}
			SetScreenElementProps id = fl_highlight pos = (<pos> - (0.0, 80.0))
		else
			song_jump_amt = (0.0, -80.0)
		endif
	else
		printf \{'Moving up from Tier: %a , Selection Index: %b, Selection Friend %c'
			a = $friendlist_selection_tier
			b = $friendlist_selection_index
			c = $friendlist_selection_friend}
		jump_tier = 0
		change friendlist_selection_index = ($friendlist_selection_index - 1)
		change friendlist_selection_friend = ($friendlist_selection_friend - 1)
		if ($friendlist_selection_tier = 2)
			if ($friendlist_selection_friend = 0)
				change friendlist_selection_tier = ($friendlist_selection_tier - 1)
				change \{friendlist_selection_friend = $num_friends_online}
				jump_tier = 1
			endif
		elseif ($friendlist_selection_tier = 3)
			if ($friendlist_selection_friend = 0)
				if ($num_friends_offline = 0)
					change friendlist_selection_tier = ($friendlist_selection_tier - 2)
					change \{friendlist_selection_friend = $num_friends_online}
				else
					change friendlist_selection_tier = ($friendlist_selection_tier - 1)
					change \{friendlist_selection_friend = $num_friends_offline}
				endif
				jump_tier = 1
			endif
		endif
		jump_tier_amt = (0.0, 240.0)
		song_jump_amt = (0.0, 80.0)
	endif
	FormatText \{checksumname = textid
		'id_friend%i'
		i = $friendlist_selection_index
		AddToStringLookup = true}
	retail_menu_focus id = <textid>
	SetScreenElementProps id = <textid> shadow
	<not_header> = 1
	if (<jump_tier> = 1)
		change friendlist_begin_text = ($friendlist_begin_text + <jump_tier_amt>)
		SetScreenElementProps \{id = scrolling_friendlist
			pos = $friendlist_begin_text}
		change friendlist_background_pos = ($friendlist_background_pos + <jump_tier_amt>)
		<not_header> = 0
	endif
	if (<not_header>)
		change friendlist_begin_text = ($friendlist_begin_text + <song_jump_amt>)
		SetScreenElementProps \{id = scrolling_friendlist
			pos = $friendlist_begin_text}
		change friendlist_background_pos = ($friendlist_background_pos + <song_jump_amt>)
	endif
	SetScreenElementProps \{id = friendlist_menu
		pos = $friendlist_background_pos}
	SetScreenElementProps \{id = friendlist_loops_menu
		pos = $friendlist_background_pos}
	if ($friendlist_clip_rot_neg)
		SetScreenElementProps id = fl_clip rot_angle = (0 - $friendlist_clip_last_rot)
		change \{friendlist_clip_rot_neg = 0}
	else
		GetRandomValue \{name = rot
			a = 10.0
			b = -30.0}
		SetScreenElementProps id = fl_clip rot_angle = <rot>
		change friendlist_clip_last_rot = <rot>
		change \{friendlist_clip_rot_neg = 1}
	endif
	if (<dir> = down)
		change friendlist_background_loop_num = ($friendlist_background_loop_num + 1)
		if ($friendlist_background_loop_num = 10)
			change \{friendlist_background_loop_num = 0}
			change friendlist_background_loop_pos = ($friendlist_background_loop_pos + (0.0, 1308.0))
			displaySprite \{parent = friendlist_menu
				tex = Setlist_BG_Loop
				pos = $friendlist_background_loop_pos
				dims = (1280.0, 1308.0)
				z = 3.1
				blendMode = diffuse}
			gumside = Random (@ 1 @ 2 )
			gumpos = $friendlist_background_loop_pos
			shoepos = (<gumpos> + (900.0, 0.0))
			gumflag = flip_h
			shoeflag = flip_v
			if (<gumside> = 1)
				<gumpos> = (<gumpos> + (1100.0, 0.0))
				<shoepos> = $friendlist_background_loop_pos
				<gumflag> = flip_v
				<shoeflag> = flip_h
			endif
		endif
		change friendlist_page1_num = ($friendlist_page1_num + 1)
		if ($friendlist_page1_num = 4)
			change \{friendlist_page1_num = 0}
			change friendlist_page1_loop_pos = ($friendlist_page1_loop_pos + (0.0, 512.0))
			displaySprite \{parent = friendlist_loops_menu
				tex = Setlist_Page1_Loop
				pos = $friendlist_page1_loop_pos
				dims = $friendlist_page1_dims
				z = $friendlist_page1_z}
		endif
		change friendlist_line_num = ($friendlist_line_num + 1)
		if ($friendlist_line_num = 1)
			change \{friendlist_line_num = 0}
			<i> = 1
			if NOT (<not_header>)
				<i> = 3
			endif
			begin
			if ($friendlist_line_index = $friendlist_line_max)
				change \{friendlist_line_index = 0}
			endif
			<line> = ($friendlist_solid_lines [0])
			displaySprite parent = friendlist_menu tex = <line> pos = $friendlist_solid_line_pos dims = (896.0, 16.0) z = ($friendlist_page1_z + 0.1)
			change friendlist_line_index = ($friendlist_line_index + 1)
			if ($friendlist_line_index = $friendlist_line_max)
				change \{friendlist_line_index = 0}
			endif
			<line> = ($friendlist_dotted_lines [0])
			displaySprite parent = friendlist_menu tex = <line> pos = $friendlist_dotted_line_pos dims = (896.0, 16.0) z = ($friendlist_page1_z + 0.1)
			change friendlist_line_index = ($friendlist_line_index + 1)
			change friendlist_solid_line_pos = (($friendlist_solid_line_pos) + ($friendlist_solid_line_add))
			change friendlist_dotted_line_pos = (($friendlist_dotted_line_pos) + ($friendlist_solid_line_add))
			repeat <i>
		endif
	else
		change friendlist_background_loop_num = ($friendlist_background_loop_num - 1)
		change friendlist_page1_num = ($friendlist_page1_num - 1)
		change friendlist_line_num = ($friendlist_line_num - 1)
		change friendlist_line_index = ($friendlist_line_index + 1)
		if ($friendlist_line_index = $friendlist_line_max)
			change \{friendlist_line_index = 0}
		endif
	endif
	printf \{'After Move-  Tier: %a , Selection Index: %b, Selection Friend %c'
		a = $friendlist_selection_tier
		b = $friendlist_selection_index
		c = $friendlist_selection_friend}
	if GotParam \{up}
		generic_menu_up_or_down_sound \{up}
	endif
	if GotParam \{down}
		generic_menu_up_or_down_sound \{down}
	endif
endscript

script reset_fl_vars 
	if GotParam \{del}
		change \{friendlist_begin_text = (0.0, 0.0)}
		change \{friendlist_background_pos = (0.0, 0.0)}
		change \{friendlist_background_loop_pos = (0.0, 676.0)}
		change \{friendlist_background_loop_num = 0}
		change \{friendlist_selection_index = 0}
		change \{friendlist_selection_friend = 0}
		destroy_menu \{menu_id = fl_overshadow}
		destroy_menu \{menu_id = fl_clipart}
		destroy_menu \{menu_id = fl_clip}
		destroy_menu \{menu_id = fl_bg_helper}
		destroy_menu \{menu_id = fl_highlight}
		destroy_menu \{menu_id = fl_fixed}
	endif
	change \{friendlist_page1_num = 0}
	change \{friendlist_page1_loop_pos = (157.0, 768.0)}
	change \{friendlist_line_num = 0}
	change \{friendlist_line_index = 0}
	change \{friendlist_clip_last_rot = 0}
	change \{friendlist_clip_rot_neg = 0}
endscript

script refresh_friends_list 
	if ($allow_friend_list_refresh = 0)
		return
	endif
	change \{friendlist_previous_selection_index = $friendlist_selection_index}
	change \{friendlist_previous_selection_tier = $friendlist_selection_tier}
	change \{friendlist_previous_selection_friend = $friendlist_selection_friend}
	change \{friendlist_begin_text = (0.0, 0.0)}
	change \{friendlist_background_pos = (0.0, 0.0)}
	change \{friendlist_background_loop_pos = (0.0, 676.0)}
	change \{friendlist_background_loop_num = 0}
	change \{friendlist_selection_index = 0}
	change \{friendlist_selection_friend = 0}
	destroy_menu \{menu_id = friendlist_menu}
	destroy_menu \{menu_id = fl_overshadow}
	destroy_menu \{menu_id = fl_clipart}
	destroy_menu \{menu_id = fl_clip}
	destroy_menu \{menu_id = fl_bg_helper}
	destroy_menu \{menu_id = fl_highlight}
	destroy_menu \{menu_id = fl_fixed}
	change \{friendlist_page1_num = 0}
	change \{friendlist_page1_loop_pos = (157.0, 768.0)}
	change \{friendlist_line_num = 0}
	change \{friendlist_line_index = 0}
	change \{friendlist_clip_last_rot = 0}
	change \{friendlist_clip_rot_neg = 0}
	update_friends_list
	if ($num_friends_online < 1)
		if ($num_friends_offline < 1)
			change \{friendlist_selection_tier = 3}
		else
			change \{friendlist_selection_tier = 2}
		endif
	else
		change \{friendlist_selection_tier = 1}
	endif
	change \{friendlist_selection_index = 0}
	change \{friendlist_selection_friend = 1}
	create_fl_assets
	change \{disable_menu_sounds = 1}
	begin
	if ($friendlist_selection_tier >= $friendlist_previous_selection_tier)
		if ($friendlist_selection_friend >= $friendlist_previous_selection_friend)
			break
		endif
	endif
	last_tier = ($friendlist_selection_tier)
	last_friend = ($friendlist_selection_friend)
	printf \{'Launching Down Event for FriendList'}
	LaunchEvent \{type = pad_down
		target = vmenu_friendlist}
	if (<last_tier> = $friendlist_selection_tier)
		if (<last_friend> = $friendlist_selection_friend)
			break
		endif
	endif
	repeat
	change \{disable_menu_sounds = 0}
endscript

script delayed_refresh 
	Wait \{5
		gameframes}
	refresh_friends_list
endscript

script create_fl_assets 
	CreateScreenElement \{type = ContainerElement
		parent = root_window
		id = friendlist_menu
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	displaySprite \{id = sl_bg_head
		parent = friendlist_menu
		tex = Setlist_BG_Head
		pos = (0.0, 0.0)
		dims = (1280.0, 676.0)
		z = 3.1
		blendMode = diffuse}
	displaySprite \{id = sl_bg_loop
		parent = friendlist_menu
		tex = Setlist_BG_Loop
		pos = $friendlist_background_loop_pos
		dims = (1280.0, 1352.0)
		z = 3.1
		blendMode = diffuse}
	displaySprite \{id = sl_page1_head
		parent = friendlist_menu
		tex = Setlist_Page1_Head
		pos = (160.0, 0.0)
		dims = (922.0, 768.0)
		z = $friendlist_page1_z}
	displaySprite parent = friendlist_menu tex = Setlist_Page1_Line_Red pos = (300.0, 12.0) dims = (8.0, 6400.0) z = ($friendlist_page1_z + 0.1)
	<title_pos> = (300.0, 380.0)
	displaySprite id = sl_page1_head_lines parent = friendlist_menu tex = Setlist_Page1_Head_Lines pos = (176.0, 64.0) dims = (896.0, 320.0) z = ($friendlist_page1_z + 0.1)
	<begin_line> = (176.0, 420.0)
	<solid_line_pos> = (176.0, 340.0)
	<dotted_line_pos> = (176.0, 380.0)
	<dotted_line_add> = ($friendlist_solid_line_add)
	begin
	<line> = ($friendlist_solid_lines [0])
	<solid_line_pos> = (<solid_line_pos> + $friendlist_solid_line_add)
	displaySprite parent = friendlist_menu tex = <line> pos = <solid_line_pos> dims = (883.0, 16.0) z = ($friendlist_page1_z + 0.1)
	repeat 8
	begin
	<line> = ($friendlist_dotted_lines [0])
	<dotted_line_pos> = (<dotted_line_pos> + <dotted_line_add>)
	displaySprite parent = friendlist_menu tex = <line> pos = <dotted_line_pos> dims = (883.0, 16.0) z = ($friendlist_page1_z + 0.1)
	repeat 8
	<solid_line_pos> = (<solid_line_pos> + $friendlist_solid_line_add)
	<dotted_line_pos> = (<dotted_line_pos> + <dotted_line_add>)
	change friendlist_solid_line_pos = <solid_line_pos>
	change friendlist_dotted_line_pos = <dotted_line_pos>
	change \{friendlist_num_friends = 0}
	if English
		friend_header = Friendlist_Page1_Title_en
	elseif French
		friend_header = Friendlist_Page1_Title_fr
	elseif Spanish
		friend_header = Friendlist_Page1_Title_sp
	elseif German
		friend_header = Friendlist_Page1_Title_de
	elseif Italian
		friend_header = Friendlist_Page1_Title_it
	endif
	displaySprite id = sl_page1_title parent = friendlist_menu tex = <friend_header> pos = (380.0, 130.0) dims = (512.0, 256.0) z = ($friendlist_page1_z + 0.2) rot_angle = 5
	if ($num_friends_online > 0)
		displayText id = sl_text_1 parent = friendlist_menu scale = (1.3, 1.0) text = $wii_friend_online rgba = [195 80 45 255] pos = <title_pos> z = $friendlist_text_z noshadow
		<text_pos> = (<title_pos> + (40.0, 54.0))
	else
		<text_pos> = (<title_pos> + (40.0, -106.0))
	endif
	num_tiers = 3
	printf \{'About to print %a Online friends, %b Offline friends, and %c Pending friends'
		a = $num_friends_online
		b = $num_friends_offline
		c = $num_friends_pending}
	<tier> = 0
	friend = 0
	begin
	<tier> = (<tier> + 1)
	printf 'Printing Tier %a' a = <tier>
	if (<tier> = 2)
		if ($num_friends_offline > 0)
			<text_pos> = (<text_pos> + (-40.0, 106.0))
			displayText parent = friendlist_menu scale = (1.0, 1.0) text = $wii_friend_offline rgba = [190 75 40 255] pos = <text_pos> z = $friendlist_text_z noshadow
			<text_pos> = (<text_pos> + (40.0, 54.0))
		endif
	endif
	if (<tier> = 3)
		if ($num_friends_pending > 0)
			<text_pos> = (<text_pos> + (-40.0, 106.0))
			displayText parent = friendlist_menu scale = (1.0, 1.0) text = $wii_friend_pending rgba = [190 75 40 255] pos = <text_pos> z = $friendlist_text_z noshadow
			<text_pos> = (<text_pos> + (40.0, 54.0))
		endif
	endif
	num_friends = 0
	if (<tier> = 1)
		<num_friends> = $num_friends_online
	elseif (<tier> = 2)
		<num_friends> = $num_friends_offline
	else
		<num_friends> = $num_friends_pending
	endif
	if (<num_friends> > 0)
		begin
		GetFriendInfo index = <friend>
		FormatText checksumname = textid 'id_friend%i' i = <friend> AddToStringLookup = true
		CreateScreenElement {
			type = TextElement
			id = <textid>
			parent = friendlist_menu
			scale = (0.75, 0.75)
			text = <nickName>
			pos = <text_pos>
			rgba = [50 30 10 255]
			z_priority = $friendlist_text_z
			font = text_a5
			just = [left top]
			no_shadow
			shadow_offs = (2.0, 2.0)
			shadow_rgba = [0 0 0 255]
		}
		<status_pos> = (<text_pos> + (600.0, -7.0))
		if ($choose_specific_friend = 0)
			if (<hasPendingInvite> = 1)
				base_pos = (0.0, 0.0)
				top_pos = (<base_pos> + (11.0, 0.0))
				FormatText checksumname = inviteid 'invite_id%a' a = <friend>
				CreateScreenElement {
					type = ContainerElement
					id = <inviteid>
					parent = friendlist_menu
					pos = <status_pos>
				}
				displaySprite parent = <inviteid> tex = invite_single_tex pos = <base_pos> dims = (80.0, 80.0) z = 101
				displaySprite parent = <inviteid> tex = invite_host_tex pos = <top_pos> dims = (80.0, 80.0) z = 101.1
				switch <game_mode>
					case 0
					<game_mode_text> = 'Co-op'
					case 1
					<game_mode_text> = 'Battle'
					case 2
					<game_mode_text> = 'Pro Face-Off'
					case 3
					<game_mode_text> = 'Face-Off'
				endswitch
				switch <num_songs>
					case 1
					<num_songs_text> = '1'
					case 3
					<num_songs_text> = '3'
					case 5
					<num_songs_text> = '5'
					case 7
					<num_songs_text> = '7'
				endswitch
				if (<game_mode> = 2)
					switch <diff>
						case 0
						<diff_text> = 'Easy'
						case 1
						<diff_text> = 'Medium'
						case 2
						<diff_text> = 'Hard'
						case 3
						<diff_text> = 'Expert'
					endswitch
					FormatText TextName = inviteInfo '%a - %b - %c' a = <game_mode_text> b = <diff_text> c = <num_songs_text>
				else
					FormatText TextName = inviteInfo '%a - %c' a = <game_mode_text> c = <num_songs_text>
				endif
				<text_pos> = (<text_pos> + (0.0, 40.0))
				displayText parent = friendlist_menu scale = (0.75, 0.75) id = <friendkeyid> text = <inviteInfo> rgba = [20 60 100 255] pos = <text_pos> z = $friendlist_text_z noshadow
				<text_pos> = (<text_pos> + (0.0, 40.0))
			else
				<text_pos> = (<text_pos> + (0.0, 80.0))
			endif
		else
			<text_pos> = (<text_pos> + (0.0, 80.0))
		endif
		change friendlist_num_friends = ($friendlist_num_friends + 1)
		friend = (<friend> + 1)
		repeat <num_friends>
	endif
	repeat <num_tiers>
	change \{friendlist_begin_text = friendlist_menu_pos}
	if ($friendlist_num_friends > 0)
		retail_menu_focus \{id = id_friend0}
		SetScreenElementProps \{id = id_friend0
			shadow}
	endif
	if ScreenElementExists \{fl_fixed}
	else
		CreateScreenElement \{type = ContainerElement
			parent = root_window
			id = fl_fixed
			pos = (0.0, 0.0)
			just = [
				left
				top
			]}
		<clip_pos> = (160.0, 420.0)
		displaySprite id = fl_clipart parent = fl_fixed tex = Setlist_Clip_Horse pos = <clip_pos> dims = (154.0, 102.0) z = ($friendlist_text_z + 0.1)
		<clip_pos> = (<clip_pos> - (20.0, -40.0))
		displaySprite id = fl_clip parent = fl_fixed tex = Setlist_Clip pos = <clip_pos> dims = (141.0, 102.0) z = ($friendlist_text_z + 0.2)
		hilite_dims = (762.0, 80.0)
		displaySprite id = fl_highlight parent = fl_fixed tex = white pos = (300.0, 428.0) dims = <hilite_dims> z = ($friendlist_text_z - 0.1) rgba = [255 255 255 128]
		<bg_helper_pos> = (140.0, 585.0)
		<helper_rgba> = [105 65 7 160]
	endif
	if ($choose_specific_friend = 0)
		new_friendlist_show_helperbar pos = (<bg_helper_pos> + (120.0, 4.0))
	else
		new_friendlist_show_choosefriend_helperbar pos = (<bg_helper_pos> + (120.0, 4.0))
	endif
	displaySprite \{id = fl_overshadow
		rgba = [
			105
			65
			7
			160
		]
		parent = root_window
		tex = Setlist_Overshadow
		pos = (0.0, 0.0)
		dims = (1280.0, 720.0)
		z = 5.0}
endscript

script new_friendlist_show_helperbar 
	if ScreenElementExists \{fl_fixed}
	else
		clean_up_user_control_helpers
		text_options = [
			$wii_updown
			$wii_options
			$wii_back
			$wii_add_friend
		]
		button_options = [
			'\\bb'
			'\\b4'
			'\\b5'
			'\\b8'
		]
		i = 0
		begin
		<text1> = (<button_options> [<i>])
		<text2> = (<text_options> [<i>])
		switch <text1>
			case '\\bb'
			<button> = strumbar
			case '\\b4'
			<button> = green
			case '\\b5'
			<button> = red
			case '\\b6'
			<button> = Yellow
			case '\\b7'
			<button> = Blue
			case '\\b8'
			<button> = Orange
		endswitch
		add_user_control_helper text = <text2> button = <button> z = 100
		<i> = (<i> + 1)
		tabs_text = $wii_friend_code2
		friendlist_text_positions = (260.0, 100.0)
		repeat 4
	endif
	tab_text_pos = (<friendlist_text_positions>)
	displayText parent = friendlist_menu scale = 1 text = (<tabs_text>) rgba = [0 0 0 255] pos = <tab_text_pos> z = 50 noshadow
	GetMyFriendNum
	<tab_text_pos> = (<tab_text_pos> + (-15.0, 40.0))
	displayText parent = friendlist_menu scale = 1 text = <myFriendKey> rgba = [50 50 50 255] pos = <tab_text_pos> z = 50 noshadow
endscript

script friendlist_show_helperbar \{spacing = 16}
	if ScreenElementExists \{fl_fixed}
	else
		text_options = [
			$wii_updown
			$wii_options
			$wii_back
			$wii_add_friend
		]
		button_options = [
			'\\bb'
			'\\b4'
			'\\b5'
			'\\b8'
		]
		i = 0
		begin
		<text> = (<button_options> [<i>])
		displayText parent = fl_fixed scale = (1.0, 0.8) text = <text> pos = <pos> z = ($friendlist_text_z + 0.3) font = buttonsps2
		GetScreenElementDims id = <id>
		<width> = (<width> + <spacing>)
		<pos> = (<pos> + (<width> * (1.0, 0.0)))
		<text> = (<text_options> [<i>])
		displayText parent = fl_fixed scale = (0.7, 0.9) text = <text> rgba = [230 230 230 255] pos = (<pos> + (0.0, 11.0)) z = ($friendlist_text_z + 0.3) font = text_a1
		GetScreenElementDims id = <id>
		<width> = (<width> + <spacing>)
		<pos> = (<pos> + (<width> * (1.0, 0.0)))
		<i> = (<i> + 1)
		repeat 4
		tabs_text = $wii_friend_code2
		friendlist_text_positions = (260.0, 100.0)
	endif
	tab_text_pos = (<friendlist_text_positions>)
	displayText parent = friendlist_menu scale = 1 text = (<tabs_text>) rgba = [0 0 0 255] pos = <tab_text_pos> z = 50 noshadow
	GetMyFriendNum
	<tab_text_pos> = (<tab_text_pos> + (-15.0, 40.0))
	displayText parent = friendlist_menu scale = 1 text = <myFriendKey> rgba = [50 50 50 255] pos = <tab_text_pos> z = 50 noshadow
endscript

script new_friendlist_show_choosefriend_helperbar 
	if ScreenElementExists \{fl_fixed}
	else
		clean_up_user_control_helpers
		text_options = [
			$wii_updown
			$wii_invite
			$wii_back
		]
		button_options = [
			'\\bb'
			'\\b4'
			'\\b5'
		]
		i = 0
		begin
		<text1> = (<button_options> [<i>])
		<text2> = (<text_options> [<i>])
		switch <text1>
			case '\\bb'
			<button> = strumbar
			case '\\b4'
			<button> = green
			case '\\b5'
			<button> = red
			case '\\b6'
			<button> = Yellow
			case '\\b7'
			<button> = Blue
			case '\\b8'
			<button> = Orange
		endswitch
		add_user_control_helper text = <text2> button = <button> z = 100
		<i> = (<i> + 1)
		repeat 3
	endif
endscript

script friendlist_show_choosefriend_helperbar \{spacing = 16}
	if ScreenElementExists \{fl_fixed}
	else
		text_options = [
			$wii_updown
			$wii_invite
			$wii_back
		]
		button_options = [
			'\\bb'
			'\\b4'
			'\\b5'
		]
		i = 0
		begin
		<text> = (<button_options> [<i>])
		displayText parent = fl_fixed scale = (1.0, 0.8) text = <text> pos = <pos> z = ($friendlist_text_z + 0.3) font = buttonsps2
		GetScreenElementDims id = <id>
		<width> = (<width> + <spacing>)
		<pos> = (<pos> + (<width> * (1.0, 0.0)))
		<text> = (<text_options> [<i>])
		displayText parent = fl_fixed scale = (0.7, 0.9) text = <text> rgba = [230 230 230 255] pos = (<pos> + (0.0, 11.0)) z = ($friendlist_text_z + 0.3) font = text_a1
		GetScreenElementDims id = <id>
		<width> = (<width> + <spacing>)
		<pos> = (<pos> + (<width> * (1.0, 0.0)))
		<i> = (<i> + 1)
		repeat 3
	endif
endscript

script create_context_friend_menu 
	GetNumFriends
	totalfriends = (<numFriendsOnline> + <numFriendsOffline> + <numFriendsPending>)
	if (<totalfriends> = 0)
		return
	endif
	friend = $friendlist_selection_index
	GetFriendInfo index = <friend>
	FormatText TextName = text $wii_options_for a = <nickName>
	if (<hasPendingInvite> = 1)
		create_generic_popup {
			title = $wii_options
			option_menu = 4
			focus_option = 4
			message = <text>
			option1 = {
				title = $wii_accept_invite
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_choose accept_invite}
				]
			}
			option2 = {
				title = $wii_reject_invite
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_choose choose_reject_phrase}
				]
			}
			option3 = {
				title = $wii_delete_friend
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_choose confirm_delete_friend params = {name = <nickName>}}
				]
			}
			option4 = {
				title = $wii_cancel
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_choose block_refresh_and_destroy}
				]
			}
			previous_menu = vmenu_friendlist
		}
	else
		create_generic_popup {
			title = $wii_options
			option_menu = 2
			focus_option = 2
			message = <text>
			option1 = {
				title = $wii_delete_friend
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_choose confirm_delete_friend params = {name = <nickName>}}
				]
			}
			option2 = {
				title = $wii_cancel
				eventhandlers = [
					{focus popup_menu_focus}
					{unfocus popup_menu_unfocus}
					{pad_choose block_refresh_and_destroy}
				]
			}
			previous_menu = vmenu_friendlist
		}
	endif
endscript

script choose_reject_phrase 
	destroy_generic_popup
	Wait \{1
		gameframe}
	create_generic_popup \{title = $wii_reason
		phrase_window
		font_scale = 0.75
		phrase_array = reject_phrases_short
		phrase_eventhandlers = [
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
				send_reject_phrase
				params = {
					phrase_array = reject_phrases_short
				}
			}
			{
				pad_back
				back_out_of_rejection
			}
		]
		previous_menu = vmenu_friendlist}
endscript

script back_out_of_rejection 
	destroy_generic_popup
	create_context_friend_menu
endscript

script send_reject_phrase 
	friend = $friendlist_selection_index
	printf 'Friend Selection %a' a = <friend>
	phrase = ($phrase_index)
	phrase_text = ($<phrase_array> [<phrase>])
	printf 'Sending phrase:\\n %a \\nto Friend at index %b' a = <phrase_text> b = <friend>
	SendRejectPhrase index = <friend> phrase = <phrase>
	FormatText \{checksumname = inviteid
		'invite_id%a'
		a = $friendlist_selection_index}
	if ScreenElementExists id = <inviteid>
		DestroyScreenElement id = <inviteid>
	endif
	block_refresh_and_destroy
endscript

script confirm_delete_friend 
	destroy_generic_popup
	Wait \{1
		gameframe}
	FormatText TextName = text $wii_delete_confirm a = <name>
	create_generic_popup {
		title = $wii_delete
		yes_no_menu
		focus_no
		message = <text>
		yes_eventhandlers = [
			{focus popup_menu_focus}
			{unfocus popup_menu_unfocus}
			{pad_choose context_menu_choose_delete_friend params = {name = <name>}}
		]
		no_eventhandlers = [
			{focus popup_menu_focus}
			{unfocus popup_menu_unfocus}
			{pad_choose block_refresh_and_destroy}
		]
		previous_menu = vmenu_friendlist
	}
endscript

script context_menu_choose_delete_friend 
	destroy_generic_popup
	Wait \{1
		gameframe}
	friendlist_delete_friend
	enable_network_wait_variable
	create_generic_popup \{loading_window
		message = $wii_deleting_friend
		wait_variable = network_wait_var
		previous_menu = vmenu_friendlist}
	FormatText TextName = text $wii_deleted_friend a = <name>
	Wait \{1
		gameframe}
	create_generic_popup {
		title = $wii_done
		ok_menu
		message = <text>
		ok_eventhandlers = [
			{focus popup_menu_focus}
			{unfocus popup_menu_unfocus}
			{pad_choose block_refresh_and_destroy}
		]
		previous_menu = vmenu_friendlist
	}
endscript

script friendlist_invite_friend 
	destroy_generic_popup
	friend = $friendlist_selection_index
	GetFriendInfo index = <friend>
	FormatText TextName = text $wii_invite_confirm a = <nickName>
	create_generic_popup {
		title = $wii_invite_title
		yes_no_menu
		message = <text>
		yes_eventhandlers = [
			{focus popup_menu_focus}
			{unfocus popup_menu_unfocus}
			{pad_choose friendlist_confirm_invite_friend params = {index = <resolvedIndex>}}
		]
		no_eventhandlers = [
			{focus popup_menu_focus}
			{unfocus popup_menu_unfocus}
			{pad_choose block_refresh_and_destroy}
		]
		previous_menu = vmenu_friendlist
	}
endscript

script friendlist_confirm_invite_friend 
	destroy_generic_popup
	Wait \{5
		gameframe}
	change invite_index = <index>
	if ($host_invite_friend_to_char_select_render_stall = 1)
		change \{host_invite_friend_to_char_select_render_stall = 0}
		SkipRenderFrames \{10}
	endif
	ui_flow_manager_respond_to_action \{action = invite_friend}
endscript

script refresh_and_destroy 
	if ScreenElementExists \{id = invite_icon_container}
		KillSpawnedScript \{name = blink_invite}
	endif
	destroy_generic_popup
	Wait \{1
		gameframe}
	enable_friend_list_refresh
	refresh_friends_list
endscript

script blink_invite 
	begin
	if NOT ScreenElementExists \{id = invite_icon_container}
		return
	endif
	doScreenElementMorph \{id = invite_icon_container
		alpha = 1.0
		time = 0.5}
	Wait \{0.5
		seconds}
	doScreenElementMorph \{id = invite_icon_container
		alpha = 0.0
		time = 0.5}
	Wait \{0.5
		seconds}
	repeat
endscript

script get_localized_loading_text 
	return loading_string = ($wii_loading_header)
endscript

script spawn_no_friends_dialog 
	destroy_generic_popup
	create_generic_popup \{title = $wii_error
		ok_menu
		message = $wii_no_friends_online
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
				destroy_and_go_back
			}
		]
		previous_menu = vmenu_character_select_p1}
endscript

script destroy_and_go_back 
	destroy_generic_popup
	ui_flow_manager_respond_to_action \{action = go_back}
endscript

script block_refresh_and_destroy 
	SetButtonEventMappings \{block_menu_input}
	refresh_and_destroy
	Wait \{0.5
		seconds}
	SetButtonEventMappings \{unblock_menu_input}
endscript
