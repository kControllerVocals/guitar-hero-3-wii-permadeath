wii_saveload_successor = null_flow_state
wii_nosave_onboot = 1

script wii_leave_saveload_flow 
	if ($wii_memcard_autosave = 0)
		printf \{'returning options_data_settings_fs'}
		return \{flow_state = options_data_settings_fs}
	else
		printf \{'autosave return state'}
		ps2_get_saveload_successor
		return flow_state = <flow_state>
	endif
endscript

script wii_memcard_load 
	SetSaveFileName \{FileType = Progress
		name = 'GH3Progress'}
	GetGlobalTags \{globaltag_checksum
		params = globaltag_checksum}
	oldglobaltag_checksum = <globaltag_checksum>
	if NOT LoadFromMemoryCard \{FileType = Progress}
		if GotParam \{CorruptedData}
			printf 'CORRUPTED DATA boot=%a' a = <boot>
			if (<boot> = 1)
				return \{flow_state = wii_memcard_corrupt_boot_fs}
			elseif (<boot> = 0)
				return \{flow_state = wii_memcard_load_corrupt_ingame_fs}
			endif
		elseif GotParam \{NoSave}
			printf 'NO SAVE boot=%a' a = <boot>
			if (<boot> = 1)
				return \{flow_state = wii_memcard_load_no_save_boot_fs}
			elseif (<boot> = 0)
				return \{flow_state = wii_memcard_load_no_save_ingame_fs}
			endif
		else
			ScriptAssert \{'Something went wrong with the file load that we don\'t handle yet'}
			if (<boot> = 1)
				return \{flow_state = wii_memcard_corrupt_boot_fs}
			elseif (<boot> = 0)
				return \{flow_state = wii_memcard_load_corrupt_ingame_fs}
			endif
		endif
	endif
	globaltag_checksum = invalid
	GetGlobalTags \{globaltag_checksum
		params = globaltag_checksum
		noassert = 1}
	if NOT (<globaltag_checksum> = <oldglobaltag_checksum>)
		printf \{'GlobalTag Checksum mismatch - deleting old save'}
		ClearGlobalTags
		setup_globaltags
		printf 'Checksums don\'t Match boot=%a' a = <boot>
		if (<boot> = 1)
			return \{flow_state = wii_memcard_corrupt_boot_fs}
		elseif (<boot> = 0)
			return \{flow_state = wii_memcard_load_corrupt_ingame_fs}
		endif
	endif
	scan_globaltag_downloads
	printf 'LOAD COMPLETE boot=%a' a = <boot>
	if (<boot> = 1)
		change \{wii_nosave_onboot = 0}
		return \{flow_state = bootup_press_any_button_fs}
	elseif (<boot> = 0)
		wii_leave_saveload_flow
		return flow_state = <flow_state>
	endif
endscript

script wii_memcard_check_for_space 
	if NOT GetMemCardSpaceAvailable \{name = $memcard_file_name
			FileType = Progress}
		if (<no_space> = 1)
			return \{nospace = 1
				noinode = 0}
		elseif (<no_inodes> = 1)
			return \{noinode = 1
				nospace = 0}
		endif
	endif
	return \{nospace = 0
		noinode = 0}
endscript

script wii_memcard_save \{check_for_space = 0}
	printf 'boot=%a' a = <boot>
	if (<check_for_space> = 1)
		memcard_check_for_existing_save
		if (<found> = 0)
			wii_memcard_check_for_space
			if (<nospace> = 1)
				printf \{'NOT ENOUGH SPACE FOR SAVE'}
				if (<boot> = 1)
					return \{flow_state = wii_memcard_insufficient_space_boot_fs}
				elseif (<boot> = 0)
					return \{flow_state = wii_memcard_insufficient_space_ingame_fs}
				endif
			elseif (<noinode> = 1)
				if (<boot> = 1)
					return \{flow_state = wii_memcard_insufficient_inode_boot_fs}
				elseif (<boot> = 0)
					return \{flow_state = wii_memcard_insufficient_inode_ingame_fs}
				endif
			endif
		endif
	endif
	if ($progression_pop_count = 1)
		pop_later = 1
		progression_push_current
	else
		pop_later = 0
	endif
	SetSaveFileName \{FileType = Progress
		name = 'GH3Progress'}
	if ($wii_memcard_autosave = 1 || (<boot> = 1))
		saveFromOptions = false
	else
		saveFromOptions = true
	endif
	if NOT SaveToMemoryCard FileType = Progress saveFromOptions = <saveFromOptions>
		printf \{'SAVE ERROR'}
		if (<boot> = 1)
			return \{flow_state = wii_memcard_save_error_boot_fs}
		elseif (<boot> = 0)
			return \{flow_state = wii_memcard_save_error_ingame_fs}
		endif
	endif
	if (<pop_later> = 1)
		progression_pop_current
	endif
	printf \{'SAVE COMPLETE'}
	if ($wii_memcard_autosave = 1)
		return \{success = 1}
	elseif (<boot> = 1)
		choose_proper_using_guitar_screen
		return flow_state = <flow_state>
	elseif (<boot> = 0)
		wii_leave_saveload_flow
		return flow_state = <flow_state>
	endif
endscript

script wii_replace_file 
	ClearGlobalTags
	setup_globaltags
	DeleteMemCardFile \{FileType = Progress}
	return \{flow_state = wii_memcard_load_no_save_boot_fs}
endscript

script wii_replace_file_ingame 
	ClearGlobalTags
	setup_globaltags
	DeleteMemCardFile \{FileType = Progress}
	return \{flow_state = wii_memcard_no_save_ingame_fs}
endscript

script wii_disable_autosave 
	create_wii_saveload_screen <...>
	Wait \{3
		seconds}
	SetGlobalTags \{user_options
		params = {
			autosave = 0
		}}
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = leave_saveload_flow
		}}
endscript

script wii_set_saveload_successor 
	get_flow_manager_action_state \{action = continue}
	change wii_saveload_successor = <state>
endscript

script wii_memcard_set_options_as_successor 
	wii_memcard_set_autosave \{autosave = 0}
	change \{wii_saveload_successor = options_data_settings_fs}
endscript

script wii_memcard_saveload_complete 
	create_wii_saveload_screen <...>
	SpawnScriptLater \{ui_flow_manager_respond_to_action
		params = {
			action = leave_saveload_flow
		}}
endscript
wii_memcard_autosave = 0

script wii_memcard_set_autosave 
	change wii_memcard_autosave = <autosave>
endscript

script wii_goto_system_menu 
	ResetToIPL
endscript

script wii_delete_file_toggle_autosave 
	destroy_generic_popup
	DeleteMemCardFile \{FileType = Progress}
endscript

script wifi_nand_continue_without_saving 
	destroy_generic_popup
	SetGlobalTags \{user_options
		params = {
			autosave = 0
		}}
endscript

script open_insufficient_space_dialog 
	destroy_generic_popup
	FormatText TextName = message_text ($wii_wifi_nand_insufficient_space_text) d = (<fsblocks>)
	create_generic_popup {
		title = $wii_error_header
		message = <message_text>
		option_menu = 2
		option1 = {
			title = $wii_saveload_continuenosave
			eventhandlers = [
				{focus popup_menu_focus}
				{unfocus popup_menu_unfocus}
				{pad_choose wifi_nand_continue_without_saving}
			]
		}
		option2 = {
			title = $wii_saveload_wiimenu
			eventhandlers = [
				{focus popup_menu_focus}
				{unfocus popup_menu_unfocus}
				{pad_choose wii_goto_system_menu}
			]
		}
	}
endscript

script open_insufficient_inodes_dialog 
	destroy_generic_popup
	create_generic_popup \{title = $wii_error_header
		message = $wii_wifi_nand_insufficient_inodes_text
		option_menu = 2
		option1 = {
			title = $wii_saveload_continuenosave
			eventhandlers = [
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
					wifi_nand_continue_without_saving
				}
			]
		}
		option2 = {
			title = $wii_saveload_wiimenu
			eventhandlers = [
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
					wii_goto_system_menu
				}
			]
		}}
endscript

script open_corrupt_save_dialog 
	destroy_generic_popup
	get_string_wii \{message = corrupt_boot}
	create_generic_popup {
		title = $wii_error_header
		message = <localized_string>
		option_menu = 2
		font_scale = 0.6
		option1 = {
			title = $wii_saveload_continuecorrupt
			eventhandlers = [
				{focus popup_menu_focus}
				{unfocus popup_menu_unfocus}
				{pad_choose wifi_nand_continue_without_saving}
			]
		}
		option2 = {
			title = $wii_saveload_deletefile
			eventhandlers = [
				{focus popup_menu_focus}
				{unfocus popup_menu_unfocus}
				{pad_choose wii_delete_file_toggle_autosave}
			]
		}
	}
endscript
