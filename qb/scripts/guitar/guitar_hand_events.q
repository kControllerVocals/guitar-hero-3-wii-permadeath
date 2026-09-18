
script Strum_iterator \{song_name = 'test'
		difficulty = 'easy'
		array_type = 'song'
		part = ''}
	strum_iterator_CFunc_setup
	begin
	if strum_iterator_CFunc
		break
	endif
	WaitOneGameFrame
	repeat
	strum_iterator_CFunc_cleanup
endscript

script FretPos_iterator 
	if NOT GotParam \{target}

		return
	endif
	if ($disable_band = 1)
		return
	endif
	get_song_prefix song = <song_name>
	FormatText checksumname = event_array '%s_anim_notes' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists name = <event_array> type = array

		return
	endif
	array_entry = 0
	GetArraySize $<event_array>
	GetSongTimeMs time_offset = <time_offset>
	if NOT (<array_size> = 0)
		begin
		if ((<time> - <skipleadin>) < $<event_array> [<array_entry>] [0])
			break
		endif
		<array_entry> = (<array_entry> + 1)
		repeat <array_size>
		array_size = (<array_size> - <array_entry>)
		if (<array_size> = 0)
			return
		endif
		begin
		TimeMarkerReached_SetParams time_offset = <time_offset> array = <event_array> array_entry = <array_entry> ArrayOfArrays
		begin
		if TimeMarkerReached
			GetSongTimeMs time_offset = <time_offset>
			break
		endif
		WaitOneGameFrame
		repeat
		TimeMarkerReached_ClearParams
		note = ($<event_array> [<array_entry>] [1])
		length = ($<event_array> [<array_entry>] [2])
		if CompositeObjectExists name = <target>
			if (<part> = guitar)
				if ((<note> >= 118) && (<note> <= 127))
					LaunchEvent type = pose_fret target = <target> data = {note = <note> note_length = <note_length>}
				endif
			else
				if ((<note> >= 101) && (<note> <= 110))
					LaunchEvent type = pose_fret target = <target> data = {note = <note> note_length = <note_length>}
				endif
			endif
		endif
		<array_entry> = (<array_entry> + 1)
		repeat <array_size>
	endif
endscript

script FretFingers_iterator \{part = ''}
	FretFingers_iterator_CFunc_Setup
	begin
	if FretFingers_iterator_CFunc
		break
	endif
	WaitOneGameFrame
	repeat
	FretFingers_iterator_CFunc_Cleanup
endscript

script WatchForStartPlaying_iterator 
	get_song_prefix song = <song_name>
	FormatText checksumname = event_array '%s_song_expert' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists name = <event_array> type = array
		return
	endif
	array_entry = 0
	GetArraySize $<event_array>
	song_array_size = (<array_size> / $num_song_columns)
	GetSongTimeMs time_offset = <time_offset>
	if NOT (<song_array_size> = 0)
		begin
		if ((<time> - <skipleadin>) < $<event_array> [<array_entry>])
			break
		endif
		<array_entry> = (<array_entry> + $num_song_columns)
		repeat <song_array_size>
		song_array_size = (<song_array_size> - (<array_entry> / $num_song_columns))
		if (<song_array_size> = 0)
			return
		endif
		TimeMarkerReached_SetParams time_offset = <time_offset> array = <event_array> array_entry = <array_entry>
		begin
		if TimeMarkerReached
			GetSongTimeMs time_offset = <time_offset>
			break
		endif
		WaitOneGameFrame
		repeat
		TimeMarkerReached_ClearParams
		BroadcastEvent \{type = start_playing}
	endif
endscript

script Drum_iterator 
	Drum_iterator_CFunc_Setup
	begin
	if Drum_iterator_CFunc
		break
	endif
	WaitOneGameFrame
	repeat
	Drum_iterator_CFunc_Cleanup
endscript

script Drum_cymbal_iterator 
	get_song_prefix song = <song_name>
	FormatText checksumname = event_array '%s_drums_notes' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists name = <event_array> type = array

		return
	endif
	array_entry = 0
	GetArraySize $<event_array>
	GetSongTimeMs time_offset = <time_offset>
	if NOT (<array_size> = 0)
		begin
		if ((<time> - <skipleadin>) < $<event_array> [<array_entry>] [0])
			break
		endif
		<array_entry> = (<array_entry> + 1)
		repeat <array_size>
		array_size = (<array_size> - <array_entry>)
		if (<array_size> = 0)
			return
		endif
		begin
		TimeMarkerReached_SetParams time_offset = <time_offset> array = <event_array> array_entry = <array_entry> ArrayOfArrays
		begin
		if TimeMarkerReached
			GetSongTimeMs time_offset = <time_offset>
			break
		endif
		WaitOneGameFrame
		repeat
		TimeMarkerReached_ClearParams
		if CompositeObjectExists \{name = Drummer}
			note = ($<event_array> [<array_entry>] [1])
			length = ($<event_array> [<array_entry>] [2])
			if ((<note> >= 37) && (<note> <= 45))
				switch (<note>)
					case 44
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal1 timerId = CymbalTimer1 Anim = ($cymbal_anims [0]) BlendDuration = $drum_blend_time
					case 45
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal2 timerId = CymbalTimer2 Anim = ($cymbal_anims [1]) BlendDuration = $drum_blend_time
					case 43
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal3 timerId = CymbalTimer3 Anim = ($cymbal_anims [2]) BlendDuration = $drum_blend_time
					case 41
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal4 timerId = CymbalTimer4 Anim = ($cymbal_anims [3]) BlendDuration = $drum_blend_time
					case 42
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal4 timerId = CymbalTimer4 Anim = ($cymbal_anims [3]) BlendDuration = $drum_blend_time
				endswitch
			elseif ((<note> >= 49) && (<note> <= 57))
				switch (<note>)
					case 56
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal1 timerId = CymbalTimer1 Anim = ($cymbal_anims [0]) BlendDuration = $drum_blend_time
					case 57
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal2 timerId = CymbalTimer2 Anim = ($cymbal_anims [1]) BlendDuration = $drum_blend_time
					case 55
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal3 timerId = CymbalTimer3 Anim = ($cymbal_anims [2]) BlendDuration = $drum_blend_time
					case 53
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal4 timerId = CymbalTimer4 Anim = ($cymbal_anims [3]) BlendDuration = $drum_blend_time
					case 54
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal4 timerId = CymbalTimer4 Anim = ($cymbal_anims [3]) BlendDuration = $drum_blend_time
				endswitch
			endif
		endif
		<array_entry> = (<array_entry> + 1)
		repeat <array_size>
	endif
endscript

script handle_strum_event 
	Obj_GetID
	wait_for_correct_frame_obj id = <ObjID>
	Obj_KillSpawnedScript \{name = hero_strum_guitar}
	Obj_SpawnScriptNow hero_strum_guitar params = {note_length = <note_length>}
endscript

script handle_missed_strum_event 
	Obj_KillSpawnedScript \{name = hero_strum_guitar}
	Obj_SpawnScriptNow hero_strum_guitar params = {note_length = <note_length>}
endscript

script handle_start_playing 

	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	if (<info_struct>.stance = intro || <info_struct>.stance = intro_smstg)
		handle_change_stance \{stance = Stance_A}
	endif
endscript

script handle_fret_event 
	Obj_GetID
	wait_for_correct_frame_obj id = <ObjID>
	handle_fret_event_cfunc note = <note>
endscript

script handle_finger_event 
	Obj_GetID
	wait_for_correct_frame_obj id = <ObjID>
	hero_play_chord chord = <chord>
endscript

script handle_missed_note 
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	if ($<info_struct>.playing_missed_note = false)
		change structurename = <info_struct> playing_missed_note = true
		strum_anims = $bad_strums
		anim_length = ($<info_struct>.last_strum_length)
		strum_anim = (<strum_anims>.<anim_length> [0])
		hero_play_strum_anim Anim = <strum_anim> BlendDuration = 0.1
	endif
endscript

script handle_hit_note 
	Obj_GetID
	handle_hit_note_CFunc
endscript

script handle_change_stance \{Speed = 1.0}
	Obj_GetID
	wait_for_correct_frame_obj id = <ObjID>
	ExtendCRC <ObjID> '_Info' out = info_struct
	display_debug_info = false
	if (should_display_debug_info)
		display_debug_info = true
	endif
	if GotParam \{no_wait}
		anim_set = ($<info_struct>.anim_set)
		old_stance = ($<info_struct>.stance)
		if play_stance_transition_cfunc anim_set = <anim_set> old_stance = <old_stance> new_stance = <stance>
			hero_play_anim Anim = <anim_to_run> Speed = <Speed>
			hero_wait_until_anim_finished
		else
		endif
		change structurename = <info_struct> stance = <stance>
		change structurename = <info_struct> next_stance = <stance>
		if (<display_debug_info> = true)

		endif
		if (<ObjID> = Guitarist || <ObjID> = bassist)
			if (<stance> = intro || <stance> = intro_smstg || <stance> = stance_frontend || <stance> = stance_frontend_guitar)
				change structurename = <info_struct> disable_arms = 2
				change structurename = <info_struct> next_anim_disable_arms = 2
			else
				change structurename = <info_struct> disable_arms = 0
				change structurename = <info_struct> next_anim_disable_arms = 0
			endif
			Obj_SwitchScript \{guitarist_idle}
		else
			Obj_SwitchScript \{BandMember_Idle}
		endif
	else
		if (<display_debug_info> = true)

		endif
		change structurename = <info_struct> next_stance = <stance>
		if (<ObjID> = Guitarist || <ObjID> = bassist)
			if (<stance> = intro || <stance> = intro_smstg || <stance> = stance_frontend || <stance> = stance_frontend_guitar)
				change structurename = <info_struct> next_anim_disable_arms = 2
			else
				change structurename = <info_struct> next_anim_disable_arms = 0
			endif
		endif
	endif
	return
endscript

script queue_change_stance 
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	change structurename = <info_struct> next_stance = <stance>
endscript

script handle_play_anim 
	Obj_GetID
	wait_for_correct_frame_obj id = <ObjID>
	ExtendCRC <ObjID> '_Info' out = info_struct
	anim_set = ($<info_struct>.anim_set)
	stance = ($<info_struct>.stance)
	display_debug_info = false
	if (should_display_debug_info)
		display_debug_info = true
	endif
	if GotParam \{no_wait}
		if (<display_debug_info> = true)

		endif
		change structurename = <info_struct> current_anim = <Anim>
		change structurename = <info_struct> next_anim = none
		if GotParam \{repeat_count}
			change structurename = <info_struct> anim_repeat_count = <repeat_count>
		else
			change structurename = <info_struct> anim_repeat_count = 1
		endif
		if GotParam \{Cycle}
			change structurename = <info_struct> cycle_anim = true
		else
			change structurename = <info_struct> cycle_anim = false
		endif
		if (<name> = Guitarist || <name> = bassist)
			if GotParam \{disable_auto_arms}
				change structurename = <info_struct> disable_arms = 2
			elseif GotParam \{disable_auto_strum}
				change structurename = <info_struct> disable_arms = 1
			else
				change structurename = <info_struct> disable_arms = 0
			endif
		endif
		Obj_KillSpawnedScript \{name = hero_play_adjusting_random_anims}
		Obj_SpawnScriptNow hero_play_adjusting_random_anims params = {Anim = <Anim>}
	else
		if (<display_debug_info> = true)
			if (<info_struct>.next_anim != none)

			else

			endif
		endif
		change structurename = <info_struct> next_anim = <Anim>
		if GotParam \{repeat_count}
			change structurename = <info_struct> next_anim_repeat_count = <repeat_count>
		else
			change structurename = <info_struct> next_anim_repeat_count = 1
		endif
		if GotParam \{Cycle}
			change structurename = <info_struct> cycle_next_anim = true
		else
			change structurename = <info_struct> cycle_next_anim = false
		endif
		if (<name> = Guitarist || <name> = bassist)
			if GotParam \{disable_auto_arms}
				change structurename = <info_struct> next_anim_disable_arms = 2
			elseif GotParam \{disable_auto_strum}
				change structurename = <info_struct> next_anim_disable_arms = 1
			else
				change structurename = <info_struct> next_anim_disable_arms = 0
			endif
		endif
	endif
endscript

script handle_walking 
	Obj_GetID
	if (<ObjID> != <name>)
		return
	endif
	wait_for_correct_frame_obj id = <ObjID>
	ExtendCRC <ObjID> '_Info' out = info_struct
	if ($<info_struct>.allow_movement != true)
		return
	endif
	if NOT ($<info_struct>.stance = Stance_A)
		anim_set = ($<info_struct>.anim_set)
		old_stance = ($<info_struct>.stance)
		if play_stance_transition_cfunc anim_set = <anim_set> old_stance = <old_stance> new_stance = Stance_A
			hero_play_anim Anim = <anim_to_run>
			hero_wait_until_anim_finished
		endif
		change structurename = <info_struct> stance = Stance_A
	endif
	change structurename = <info_struct> disable_arms = 0
	Obj_SwitchScript guitarist_walking params = {<...>}
endscript

script play_drum_anim \{arm = left
		BlendDuration = $drum_blend_time}
	if NOT GotParam \{Anim}
		return
	endif
	if (<arm> = left)
		Obj_KillSpawnedScript \{name = play_drummer_left_arm_anim}
		Obj_SpawnScriptNow play_drummer_left_arm_anim params = {Anim = <Anim> BlendDuration = <BlendDuration>}
	else
		Obj_KillSpawnedScript \{name = play_drummer_right_arm_anim}
		Obj_SpawnScriptNow play_drummer_right_arm_anim params = {Anim = <Anim>}
	endif
endscript

script play_drummer_left_arm_anim 
	hero_play_anim Tree = $hero_drumming_branch timerId = leftarm_timer target = DrummerLeftArm Anim = <Anim> BlendDuration = <BlendDuration>
	hero_wait_until_anim_finished \{Timer = leftarm_timer}
	Wait \{$drummer_arm_blend_out_delay
		seconds}
	Wait \{$drummer_clear_arm_twist_value_delay
		seconds}
	change \{structurename = drummer_info
		last_left_arm_note = 0}
endscript

script play_drummer_right_arm_anim 
	hero_play_anim Tree = $hero_drumming_branch timerId = rightarm_timer target = DrummerRightArm Anim = <Anim> BlendDuration = <BlendDuration>
	hero_wait_until_anim_finished \{Timer = rightarm_timer}
	Wait \{$drummer_arm_blend_out_delay
		seconds}
	Wait \{$drummer_clear_arm_twist_value_delay
		seconds}
	change \{structurename = drummer_info
		last_right_arm_note = 0}
endscript
