null_flow_state = {
	is_null
}
ui_flow_manager_state = [
	main_menu_fs
	null_flow_state
]
previous_flow_manager_state = [
	null_flow_state
	null_flow_state
]
ui_flow_manager_under = [
	null_flow_state
	null_flow_state
]
menu_flow_locked = 0
menu_flow_play_sound = 1
ui_flow_HACK_previous_state = none

script ui_flow_manager_respond_to_action \{device_num = 0
		player = 1
		create_params = {
		}
		destroy_params = {
		}
		func_params = {
		}
		flow_state_func_params = {
		}
		play_sound = 1}
	if ($transitions_locked = 1 || $menu_flow_locked = 1)
		return
	endif
	if NOT ((<player> = 1) || (<player> = 2))
		ScriptAssert \{'Player must be equal to 1 or 2'}
	endif
	player_index = (<player> - 1)
	current_flow_state_name = ($ui_flow_manager_state [<player_index>])
	current_flow_state = (<current_flow_state_name>)
	new_state_name = <current_flow_state_name>
	previous_flow_state_name = ($previous_flow_manager_state [<player_index>])
	previous_flow_state = (<previous_flow_state_name>)
	under_flow_state_name = ($ui_flow_manager_under [<player_index>])
	under_flow_state = (<under_flow_state_name>)
	null_flow_state_name = null_flow_state
	found_action = 0
	if GotParam \{action}
		GetArraySize (<current_flow_state>.actions)
		action_array_size = <array_size>
		array_entry = 0
		begin
		if (<action> = <current_flow_state>.actions [(<array_entry>)].action)
			if ($menu_flow_play_sound = 1)
				if (<play_sound> = 1)
					if (<action> = go_back)
						SoundEvent \{event = Generic_Menu_Back_SFX}
					else
						SoundEvent \{event = ui_sfx_select}
					endif
				endif
			else
				change \{menu_flow_play_sound = 1}
			endif
			<found_action> = 1
			spawned_func = 0
			if StructureContains Structure = (<current_flow_state>.actions [<array_entry>]) func
				action_function = (<current_flow_state>.actions [<array_entry>].func)
				if StructureContains Structure = (<current_flow_state>.actions [<array_entry>]) func_params
					func_params = (<current_flow_state>.actions [<array_entry>].func_params)
				endif
				if StructureContains Structure = (<current_flow_state>.actions [<array_entry>]) spawned_func
					<spawned_func> = 1
				endif
			endif
			if StructureContains Structure = (<current_flow_state>.actions [<array_entry>]) use_last_flow_state
				<new_state_name> = <previous_flow_state_name>
			else
				if StructureContains Structure = ((<current_flow_state>.actions [(<array_entry>)])) flow_state
					<new_state_name> = ((<current_flow_state>.actions [(<array_entry>)]).flow_state)
				elseif StructureContains Structure = ((<current_flow_state>.actions [(<array_entry>)])) flow_state_func
					if StructureContains Structure = ((<current_flow_state>.actions [(<array_entry>)])) flow_state_func_params
						<flow_state_func_params> = ((<current_flow_state>.actions [(<array_entry>)]).flow_state_func_params)
					endif
					change \{transitions_locked = 1}
					flow_state_func = ((<current_flow_state>.actions [(<array_entry>)]).flow_state_func)
					<flow_state_func> <flow_state_func_params>
					change \{transitions_locked = 0}
					if NOT GotParam \{flow_state}
						ScriptAssert \{'flow_state_func did not return flow_state'}
					endif
					<new_state_name> = <flow_state>
				else
					ScriptAssert \{'Action does not define flow_state, use_last_flow_state, or flow_state_func'}
				endif
			endif
			break
		endif
		<array_entry> = (<array_entry> + 1)
		repeat <action_array_size>
	endif
	HACK_ps2_get_saveload_successor_checksum
	if ((<ps2_saveload_successor_checksum> != none) && (<new_state_name> = HACK_ps2_saveload_successor))

		HACK_ps2_set_saveload_successor_checksum \{none}
		new_state_name = <ps2_saveload_successor_checksum>
		if (ui_flow_HACK_previous_state != none)
			previous_flow_state_name = ($ui_flow_HACK_previous_state)
			previous_flow_state = (<previous_flow_state_name>)
		endif
		if StructureContains Structure = ($ps2_saveload_successor_action_state) func
			action_function = ($ps2_saveload_successor_action_state.func)
		endif
		if StructureContains Structure = ($ps2_saveload_successor_action_state) func_params
			func_params = (<current_flow_state>.actions [<array_entry>].func_params)
		endif
		if StructureContains Structure = ($ps2_saveload_successor_action_state) spawned_func
			<spawned_func> = 1
		endif
	endif
	if (<found_action>)
		new_state = (<new_state_name>)
		is_popup = (0)
		if StructureContains Structure = (<new_state>) popup
			<is_popup> = (1)
		endif
		state_destroy_params = {}
		if StructureContains Structure = (<new_state>) destroy_params
			state_destroy_params = (<new_state>.destroy_params)
		endif
		if ($playing_song = 0)
			if StructureContains Structure = (<current_flow_state>.actions [<array_entry>]) transition_screen
				transition_screen_struct = ((<current_flow_state>.actions [<array_entry>]).transition_screen)
				transition_create_func = (<transition_screen_struct>.create)
				<transition_create_func>
			endif
		endif
		if (<is_popup>)
			if NOT StructureContains Structure = (<under_flow_state>) is_null
				if StructureContains Structure = (<current_flow_state>) destroy
					destroy_func = (<current_flow_state>.destroy)
					<destroy_func> player = <player> <destroy_params> <state_destroy_params>
				endif
			endif
			SetArrayElement ArrayName = ui_flow_manager_under GlobalArray index = (<player_index>) newvalue = <current_flow_state_name> ResolveGlobals = 0
			LaunchEvent \{type = unfocus
				target = root_window}
		else
			if StructureContains Structure = (<current_flow_state>) destroy
				destroy_func = (<current_flow_state>.destroy)
				<destroy_func> player = <player> <destroy_params> <state_destroy_params>
			endif
			if NOT StructureContains Structure = (<under_flow_state>) is_null
				if StructureContains Structure = (<under_flow_state>) destroy
					destroy_func = (<under_flow_state>.destroy)
					<destroy_func> player = <player> <destroy_params> <state_destroy_params>
				endif
				SetArrayElement ArrayName = ui_flow_manager_under GlobalArray index = (<player_index>) newvalue = <null_flow_state_name> ResolveGlobals = 0
				LaunchEvent \{type = focus
					target = root_window}
			endif
		endif
		SetArrayElement ArrayName = previous_flow_manager_state GlobalArray index = (<player_index>) newvalue = <current_flow_state_name> ResolveGlobals = 0
		SetArrayElement ArrayName = ui_flow_manager_state GlobalArray index = (<player_index>) newvalue = <new_state_name> ResolveGlobals = 0
		if GotParam \{action_function}
			if (<spawned_func> = 1)
				spawnscriptnow <action_function> params = {device_num = (<device_num>) <func_params>}
			else
				<action_function> device_num = (<device_num>) <func_params>
			endif
		endif
		if ($playing_song = 0)
			if StructureContains Structure = (<current_flow_state>.actions [<array_entry>]) transition_screen
				transition_screen_struct = ((<current_flow_state>.actions [<array_entry>]).transition_screen)
				transition_destroy_func = (<transition_screen_struct>.destroy)
				<transition_destroy_func>
			endif
		endif
		pak = <new_state_name>



		SetPakManCurrentBlock map = flow_state_pak_map pak = <pak> block_scripts = 1

		state_create_params = {}
		if StructureContains Structure = (<new_state>) create_params
			state_create_params = (<new_state>.create_params)
		endif
		if StructureContains Structure = (<new_state>) create
			create_func = (<new_state>.create)
			<create_func> player = <player> <create_params> <state_create_params>
		endif
		if (<play_sound>)
			if (<action> = go_back)
				SoundEvent \{event = Generic_Menu_Back_SFX}
			else
				SoundEvent \{event = ui_sfx_select}
			endif
		endif
	endif
endscript

script start_flow_manager \{flow_state = main_menu_fs
		player = 1
		create_params = {
		}}
	if NOT ((<player> = 1) || (<player> = 2))
		ScriptAssert \{'Player must be equal to 1 or 2'}
	endif
	player_index = (<player> - 1)
	SetArrayElement ArrayName = ui_flow_manager_state GlobalArray index = (<player_index>) newvalue = <flow_state> ResolveGlobals = 0
	current_flow_state_name = ($ui_flow_manager_state [<player_index>])
	current_flow_state = (<current_flow_state_name>)

	pak = <current_flow_state_name>
	HACK_ps2_get_saveload_successor_checksum
	if ((<ps2_saveload_successor_checksum> != none) && (<pak> = HACK_ps2_saveload_successor))
		HACK_ps2_set_saveload_successor_checksum \{none}
		pak = <ps2_saveload_successor_checksum>
		if (ui_flow_HACK_previous_state != none)
			previous_flow_state_name = ($ui_flow_HACK_previous_state)
			previous_flow_state = (<previous_flow_state_name>)
		endif
	endif



	SetPakManCurrentBlock map = flow_state_pak_map pak = <pak> block_scripts = 1

	state_create_params = {}
	if StructureContains Structure = (<current_flow_state>) create_params
		state_create_params = (<current_flow_state>.create_params)
	endif
	if StructureContains Structure = (<current_flow_state>) create
		create_func = (<current_flow_state>.create)
		<create_func> player = <player> <create_params> <state_create_params>
	endif
endscript

script shut_down_flow_manager \{player = 1}
	if NOT ((<player> = 1) || (<player> = 2))
		ScriptAssert \{'Player must be equal to 1 or 2'}
	endif
	player_index = (<player> - 1)
	current_flow_state_name = ($ui_flow_manager_state [<player_index>])
	current_flow_state = (<current_flow_state_name>)
	if StructureContains Structure = (<current_flow_state>) destroy
		destroy_func = (<current_flow_state>.destroy)
		<destroy_func> player = <player> <destroy_params>
	endif
endscript

script get_flow_manager_action_state \{player = 1}
	if NOT ((<player> = 1) || (<player> = 2))
		ScriptAssert \{'Player must be equal to 1 or 2'}
	endif
	player_index = (<player> - 1)
	if NOT GotParam \{action}
		ScriptAssert \{'No action'}
	endif
	current_flow_state_name = ($ui_flow_manager_state [<player_index>])
	current_flow_state = (<current_flow_state_name>)
	GetArraySize (<current_flow_state>.actions)
	action_array_size = <array_size>
	array_entry = 0
	begin
	if (<action> = <current_flow_state>.actions [(<array_entry>)].action)
		if StructureContains Structure = ((<current_flow_state>.actions [(<array_entry>)])) flow_state_func
			flow_state_func = ((<current_flow_state>.actions [(<array_entry>)]).flow_state_func)
			<flow_state_func>
			if NOT GotParam \{flow_state}
				ScriptAssert \{'flow_state_func did not return flow_state'}
			endif
			return state = <flow_state> action_struct = (<current_flow_state>.actions [<array_entry>])
		else
			return state = (<current_flow_state>.actions [(<array_entry>)].flow_state) action_struct = (<current_flow_state>.actions [<array_entry>])
		endif
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <action_array_size>
endscript
