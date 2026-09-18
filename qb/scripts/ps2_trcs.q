ps2_saveload_successor = null_flow_state
ps2_saveload_successor_action_state = {
}
GH3ProgressIconSpaceRequired = 62
restartMenuMusic = 0

script ps2_leave_saveload_flow 
	Wait \{5
		gameframe}
	destroy_ps2_trc_menu
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = leave_saveload_flow
		}}
	if ($restartMenuMusic = 1)
		change \{restartMenuMusic = 0}
		spawnscriptnow \{menu_music_on
			params = {
				setflag = 1
			}}
	endif
endscript

script ps2_memcard_load_check_status 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{3
		seconds}
	if NOT CardIsInSlot

		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_memcard
			}}
		return
	endif

	memcard_check_for_existing_save
	if (<found> = 0)

		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_save
			}}
		return
	endif
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = status_ok
		}}
endscript

script ps2_memcard_load 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{5
		gameframe}
	SetSaveFileName \{FileType = Progress
		name = 'GH3Progress'}
	GetGlobalTags \{globaltag_checksum
		params = globaltag_checksum}
	oldglobaltag_checksum = <globaltag_checksum>
	if NOT LoadFromMemoryCard \{FileType = Progress}
		if NOT CardIsInSlot
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = no_memcard
				}}
			return
		elseif GotParam \{CorruptedData}
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = corrupt_save
				}}
			return
		else

			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = corrupt_save
				}}
			return
		endif
	endif
	globaltag_checksum = invalid
	GetGlobalTags \{globaltag_checksum
		params = globaltag_checksum
		noassert = 1}
	if NOT (<globaltag_checksum> = <oldglobaltag_checksum>)

		ClearGlobalTags
		setup_globaltags
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = corrupt_save
			}}
		return
	endif
	restore_options_from_global_tags
	scan_globaltag_downloads
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = load_complete
		}}
endscript

script ps2_memcard_save_check_status \{no_check = 0
		check_for_existing = 0}
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{5
		gameframe}
	if (<no_check> = 0)
		if CardIsNew
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = new_memcard
				}}
			return
		endif
	endif
	if NOT CardIsInSlot
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_memcard
			}}
		return
	endif
	if NOT CardIsFormatted
		Wait \{5
			gameframe}
		if NOT CardIsFormatted
			if NOT CardIsInSlot
				spawnscriptnow \{ui_flow_manager_respond_to_action
					params = {
						action = no_memcard
					}}
				return
			endif
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = not_formatted
				}}
			return
		endif
	endif
	if (<check_for_existing> = 1)
		memcard_check_for_existing_save
		if NOT (<found> = 0)
			if NOT CardIsInSlot
				spawnscriptnow \{ui_flow_manager_respond_to_action
					params = {
						action = no_memcard
					}}
				return
			endif
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = existing_save
				}}
			return
		endif
	endif
	ps2_memcard_check_for_space
	if (<nospace> = 0)
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = status_ok
			}}
	endif
endscript

script ps2_memcard_check_for_space 
	memcard_check_for_existing_save
	if (<found> = 0)
		GetMemCardSpaceRequired \{Progress}

		GetMemCardSpaceAvailable

		if (<SpaceRequired> > <SpaceAvailable>)
			if NOT CardIsInSlot
				spawnscriptnow \{ui_flow_manager_respond_to_action
					params = {
						action = no_memcard
					}}
				return \{nospace = 1}
			endif
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = insufficient_space
				}}
			return \{nospace = 1}
		endif
	endif
	return \{nospace = 0}
endscript

script ps2_memcard_save 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{5
		gameframe}
	if ($progression_pop_count = 1)
		pop_later = 1
		progression_push_current
	else
		pop_later = 0
	endif
	SetSaveFileName \{FileType = Progress
		name = 'GH3Progress'}
	if NOT SaveToMemoryCard \{FileType = Progress}

		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = error
			}}
		return
	endif
	if (<pop_later> = 1)
		progression_pop_current
	endif
	destroy_ps2_saveload_screen
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = save_complete
		}}
endscript

script ps2_memcard_format_check_status 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{5
		gameframe}
	if CardIsFormatted
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = is_formatted
			}}
		return
	endif
	Wait \{5
		gameframe}
	if CardIsFormatted
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = is_formatted
			}}
		return
	endif
	if NOT CardIsInSlot
		spawnscriptnow \{ui_flow_manager_respond_to_action
			params = {
				action = no_memcard
			}}
		return
	endif
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = status_ok
		}}
endscript

script ps2_memcard_format 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{5
		gameframe}
	if NOT FormatCard
		if NOT CardIsInSlot
			spawnscriptnow \{ui_flow_manager_respond_to_action
				params = {
					action = no_memcard
				}}
			return
		else
			ScriptAssert \{'something went wrong with the format card'}
		endif
	endif
	destroy_ps2_saveload_screen
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = success
		}}
endscript

script ps2_replace_file 
	ClearGlobalTags
	setup_globaltags
	DeleteMemCardFile \{FileType = Progress}
	spawnscriptnow \{ui_flow_manager_respond_to_action
		params = {
			action = return_to_save
		}}
endscript

script ps2_disable_autosave 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{3
		seconds}
	SetGlobalTags \{user_options
		params = {
			autosave = 0
		}}
	ps2_leave_saveload_flow
endscript

script ps2_set_saveload_successor 
	get_flow_manager_action_state \{action = continue}
	change ps2_saveload_successor = <state>
	HACK_ps2_set_saveload_successor_checksum <state>
endscript

script ps2_get_saveload_successor 
	return \{flow_state = HACK_ps2_saveload_successor}
endscript

script ps2_memcard_set_options_as_successor 
	ps2_memcard_set_autosave \{autosave = 0}
	change \{ps2_saveload_successor = options_data_settings_fs}
	HACK_ps2_set_saveload_successor_checksum \{options_data_settings_fs}
endscript

script ps2_memcard_saveload_complete 
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	Wait \{1
		second}
	ps2_leave_saveload_flow
endscript

script ps2_memcard_message 
	change \{check_for_unplugged_controllers = 1}
	destroy_ps2_saveload_screen
	create_ps2_saveload_screen <...>
	add_user_control_helper \{text = 'CONTINUE'
		button = green
		z = 1006}
	CreateScreenElement \{type = SpriteElement
		parent = ps2_trc_container
		rgba = [
			0
			0
			0
			0
		]
		event_handlers = [
			{
				pad_choose
				ui_flow_manager_respond_to_action
				params = {
					action = continue
				}
			}
		]}
	LaunchEvent type = focus target = <id>
endscript
ps2_memcard_autosave = 0

script ps2_memcard_set_autosave 
	change ps2_memcard_autosave = <autosave>
endscript

script ps2_memcard_save_successor 
	if (($ps2_memcard_autosave) = 0)
		return \{flow_state = ps2_memcard_save_ingame_fs}
	else
		return \{flow_state = ps2_memcard_autosave_ingame_fs}
	endif
endscript

script ps2_memcard_existing_save_successor 
	if (($ps2_memcard_autosave) = 0)
		return \{flow_state = ps2_memcard_overwrite_confirm_ingame_fs}
	else
		ps2_memcard_save_successor
		return flow_state = <flow_state>
	endif
endscript
