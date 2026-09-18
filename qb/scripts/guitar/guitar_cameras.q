CameraCuts_Good_Array = Default_Cameras_Good
CameraCuts_Normal_Array = Default_Cameras_Normal
CameraCuts_Poor_Array = Default_Cameras_Poor
CameraCuts_Performance = good
CameraCuts_LastArray = CameraCuts_Good_Array
CameraCuts_LastPerformance = good
CameraCuts_Enabled = false
CameraCuts_LastIndex = 0
CameraCuts_LastType = none
CameraCuts_LastDownbeatIndex = 0
CameraCuts_ChangeTime = 0
CameraCuts_ChangeNow = false
CameraCuts_ForceTime = 0
CameraCuts_NextTime = 0
CameraCuts_ArrayPrefix = 'Cameras'
CameraCuts_ForceType = none
CameraCuts_NextName = none
CameraCuts_ChangeCamEnable = true
CameraCuts_AllowNoteScripts = true
CameraCuts_LastCameraStartTime = 0.0
CameraCuts_ForceChangeTime = 0.0
CameraCuts_ShadowCasters = none
CameraCuts_NextNoteCameraTime = -1
CameraCuts_NoteMapping = [
	{
		MidiNote = 77
		Scr = CameraCuts_EnableChangeCam
		params = {
			enable = true
		}
	}
	{
		MidiNote = 78
		Scr = CameraCuts_EnableChangeCam
		params = {
			enable = false
		}
	}
	{
		MidiNote = 79
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras'
			changenow
		}
	}
	{
		MidiNote = 80
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_intro'
			changenow
		}
	}
	{
		MidiNote = 81
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_solo'
			selectguitartype
			changenow
		}
	}
	{
		MidiNote = 82
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_dolly'
			changenow
			name = Dolly_StageFront
		}
	}
	{
		MidiNote = 83
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_zoom'
			changenow
		}
	}
	{
		MidiNote = 84
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras'
			changenow
			type = CloseUp
		}
	}
	{
		MidiNote = 85
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras'
			changenow
			type = mid
		}
	}
	{
		MidiNote = 86
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras'
			changenow
			type = longshot
		}
	}
	{
		MidiNote = 87
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras'
			changenow
			type = stage
		}
	}
	{
		MidiNote = 88
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_singer'
			changenow
		}
	}
	{
		MidiNote = 89
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_drummer'
			changenow
		}
	}
	{
		MidiNote = 90
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_solo'
			selectguitartype
			changenow
		}
	}
	{
		MidiNote = 91
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_orbit'
			changenow
			name = Orbit_Stage
		}
	}
	{
		MidiNote = 92
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_orbit'
			changenow
			name = Orbit_Drummer
		}
	}
	{
		MidiNote = 93
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_orbit'
			changenow
			name = Orbit_CloseUp
		}
	}
	{
		MidiNote = 94
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_orbit'
			changenow
			name = Orbit_Mid
		}
	}
	{
		MidiNote = 95
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_guitar_closeup'
			changenow
			name = Guitar_CloseUp
		}
	}
	{
		MidiNote = 96
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_starpower'
			changenow
		}
	}
	{
		MidiNote = 97
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_bassist'
			changenow
		}
	}
	{
		MidiNote = 98
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_walk'
			changenow
		}
	}
	{
		MidiNote = 99
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_vert_guitarist'
			changenow
		}
	}
	{
		MidiNote = 100
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_vert_drummer'
			changenow
		}
	}
	{
		MidiNote = 101
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_vert_stagefront'
			changenow
		}
	}
	{
		MidiNote = 102
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_vert_stagerear'
			changenow
		}
	}
	{
		MidiNote = 103
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_orbit'
			changenow
			name = Orbit_Singer
		}
	}
	{
		MidiNote = 104
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_singer_closeup'
			changenow
		}
	}
	{
		MidiNote = 105
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_special'
			changenow
		}
	}
	{
		MidiNote = 106
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_special'
			changenow
			name = special01
		}
	}
	{
		MidiNote = 107
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_special'
			changenow
			name = special02
		}
	}
	{
		MidiNote = 108
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_special'
			changenow
			name = Special03
		}
	}
	{
		MidiNote = 109
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_special'
			changenow
			name = Special04
		}
	}
	{
		MidiNote = 110
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_dolly'
			changenow
			name = Dolly_StageRear
		}
	}
	{
		MidiNote = 111
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_zoom_slow'
			changenow
		}
	}
	{
		MidiNote = 112
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_zoom_fast'
			changenow
		}
	}
	{
		MidiNote = 113
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_zoom_out'
			changenow
		}
	}
	{
		MidiNote = 114
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_pan'
			changenow
		}
	}
	{
		MidiNote = 115
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_boss_closeup'
			changenow
		}
	}
	{
		MidiNote = 116
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_player_closeup'
			changenow
		}
	}
	{
		MidiNote = 117
		Scr = CameraCuts_SetArrayPrefix
		params = {
			prefix = 'cameras_stagedive'
			changenow
		}
	}
]

script cameracuts_iterator 

	change \{CameraCuts_NextNoteCameraTime = -1}
	get_song_prefix song = <song_name>
	FormatText checksumname = event_array '%s_cameras_notes' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists name = <event_array> type = array
		return
	endif
	array_entry = 0
	fretbar_count = 0
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
		if NOT (<array_size> = 0)
			begin
			change CameraCuts_NextNoteCameraTime = ($<event_array> [<array_entry>] [0] - <time_offset>)
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
			if ($CameraCuts_AllowNoteScripts = true)
				if GetNoteMapping section = cameras note = <note>
					spawnscriptnow (<note_data>.Scr) params = {(<note_data>.params) length = ($<event_array> [<array_entry>] [2])}
				endif
			endif
			<array_entry> = (<array_entry> + 1)
			repeat <array_size>
		endif
	endif
	change \{CameraCuts_NextNoteCameraTime = -1}
endscript

script CameraCuts_GetNextNoteCameraTime 
	return camera_time = ($CameraCuts_NextNoteCameraTime)
endscript

script CameraCuts_SetArray \{type = good
		array = Default_Cameras_Good}
	if (<type> = good)
		change CameraCuts_Good_Array = <array>
	endif
	if (<type> = medium)
		change CameraCuts_Normal_Array = <array>
	endif
	if (<type> = poor)
		change CameraCuts_Poor_Array = <array>
	endif
endscript

script CameraCuts_SetParams \{performance = medium}
	change CameraCuts_Performance = <performance>
endscript

script CameraCuts_SetArrayPrefix \{prefix = 'cameras'
		type = none
		name = none
		length = 0}
	if GotParam \{selectguitartype}
		if ($player1_status.instrument_id = Instrument_Guitar_Demonik)
			type = demonik
		else
			type = Normal
		endif
	endif
	change CameraCuts_ArrayPrefix = <prefix>
	change CameraCuts_ForceType = <type>
	change CameraCuts_NextName = <name>
	set_defaultcameracuts
	if GotParam \{changetime}
		change CameraCuts_ForceChangeTime = <changetime>
	endif
	if GotParam \{changenow}
		if (<length> > 200)
			change CameraCuts_NextTime = <length>
		endif
		CameraCuts_EnableChangeCam \{enable = true}
	endif
endscript

script set_defaultcameracut_perf \{perf = 'good'
		perf_checksum = good}
	GetPakManCurrentName \{map = zones}
	if ($current_num_players = 2)
		FormatText checksumname = Cameras_Array '%s_%p_%c_2p' p = $CameraCuts_ArrayPrefix c = <perf> s = <pakname>
		if GlobalExists name = <Cameras_Array> type = array
			CameraCuts_SetArray type = <perf_checksum> array = <Cameras_Array>
			return
		endif
		FormatText checksumname = Cameras_Array '%s_%p_2p' p = $CameraCuts_ArrayPrefix s = <pakname>
		if GlobalExists name = <Cameras_Array> type = array
			CameraCuts_SetArray type = <perf_checksum> array = <Cameras_Array>
			return
		endif
	endif
	FormatText checksumname = Cameras_Array '%s_%p_%c' p = $CameraCuts_ArrayPrefix c = <perf> s = <pakname>
	if GlobalExists name = <Cameras_Array> type = array
		CameraCuts_SetArray type = <perf_checksum> array = <Cameras_Array>
		return
	endif
	FormatText checksumname = Cameras_Array '%s_%p' p = $CameraCuts_ArrayPrefix s = <pakname>
	if GlobalExists name = <Cameras_Array> type = array
		CameraCuts_SetArray type = <perf_checksum> array = <Cameras_Array>
		return
	endif
	FormatText checksumname = Cameras_Array '%s_%p_%c' p = $CameraCuts_ArrayPrefix c = <perf> s = 'default'
	if GlobalExists name = <Cameras_Array> type = array
		CameraCuts_SetArray type = <perf_checksum> array = <Cameras_Array>
		return
	endif
	FormatText \{checksumname = Cameras_Array
		'%s_%p'
		p = $CameraCuts_ArrayPrefix
		s = 'default'}
	if GlobalExists name = <Cameras_Array> type = array
		CameraCuts_SetArray type = <perf_checksum> array = <Cameras_Array>
		return
	endif

	ScriptAssert \{'CameraCut Array not found'}
endscript

script set_defaultcameracuts 
	set_defaultcameracut_perf \{perf = 'good'
		perf_checksum = good}
	set_defaultcameracut_perf \{perf = 'normal'
		perf_checksum = medium}
	set_defaultcameracut_perf \{perf = 'poor'
		perf_checksum = poor}
endscript

script create_cameracuts 
	change \{CameraCuts_ArrayPrefix = 'cameras'}
	set_defaultcameracuts
	SetNoteMappings \{section = cameras
		mapping = $CameraCuts_NoteMapping}
	kill_dummy_bg_camera
	change \{CameraCuts_LastType = none}
	change \{CameraCuts_LastDownbeatIndex = 0}
	change \{CameraCuts_ForceChangeTime = 0.0}
	change \{CameraCuts_ForceType = none}
	change \{CameraCuts_NextName = none}
	if ($game_mode = training)
		change \{CameraCuts_ChangeCamEnable = false}
		change \{CameraCuts_AllowNoteScripts = false}
	else
		change \{CameraCuts_ChangeCamEnable = true}
		change \{CameraCuts_AllowNoteScripts = true}
	endif
	change \{CameraCuts_Enabled = true}
	CameraCuts_StartCallback
endscript

script CameraCuts_GetNextDownbeat 
	get_song_prefix song = ($current_song)
	FormatText checksumname = event_array '%s_lightshow_notes' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists name = <event_array> type = array
		return endtime = <endtime>
	endif
	GetArraySize $<event_array>
	array_count = ($CameraCuts_LastDownbeatIndex)
	array_size = (<array_size> - <array_count>)
	if (<array_size> > 0)
		begin
		if ($<event_array> [<array_count>] [1] = 58)
			if ($<event_array> [<array_count>] [0] > <endtime>)
				change CameraCuts_LastDownbeatIndex = <array_count>
				return endtime = ($<event_array> [<array_count>] [0])
			endif
		endif
		array_count = (<array_count> + 1)
		repeat <array_size>
	endif
	return endtime = <endtime>
endscript

script CameraCuts_StartCallback 
	change \{CameraCuts_ChangeNow = false}
	if ($CameraCuts_Enabled = false)
		return
	endif
	if ($CameraCuts_Performance = poor)
		Camera_Array = CameraCuts_Poor_Array
	else
		if ($CameraCuts_Performance = good)
			Camera_Array = CameraCuts_Good_Array
		else
			Camera_Array = CameraCuts_Normal_Array
		endif
	endif
	if CompositeObjectExists \{name = Guitarist}
		Guitarist :get_target_node
	endif
	if NOT ($CameraCuts_NextName = none)
		CameraCut_GetArraySize Camera_Array = <Camera_Array> name = ($CameraCuts_NextName) target_node = <target_node>
	elseif NOT ($CameraCuts_ForceType = none)
		CameraCut_GetArraySize Camera_Array = <Camera_Array> includetype = $CameraCuts_ForceType target_node = <target_node>
	else
		CameraCut_GetArraySize Camera_Array = <Camera_Array> excludetype = $CameraCuts_LastType target_node = <target_node>
	endif
	if (<array_size> = 0)
		newindex = 0
	else
		GetRandomValue name = newindex Integer a = 0 b = (<array_size> - 1)
		CameraCut_GetCameraIndex Camera_Array = <Camera_Array> newindex = <newindex>
	endif
	debug_flags = none
	if NOT ($debug_camera_array = none)
		found = 0
		FormatText \{checksumname = New_Camera_Array
			'%s_%p'
			s = $debug_camera_array_pakname
			p = $debug_camera_array}
		if GlobalExists name = <New_Camera_Array>
			GetArraySize $<New_Camera_Array>
			index = ($debug_camera_array_count)
			if (<index> < <array_size>)
				Camera_Array = <New_Camera_Array>
				newindex = ($debug_camera_array_count)
				found = 1
				debug_flags = update_when_paused
			endif
		endif
		if (found = 0)
			change \{debug_camera_array = none}
			change \{debug_camera_array_pakname = none}
			change \{debug_camera_array_count = none}
		endif
	endif
	change CameraCuts_LastArray = <Camera_Array>
	change \{CameraCuts_LastPerformance = $CameraCuts_Performance}
	change CameraCuts_LastIndex = <newindex>
	if StructureContains Structure = (<Camera_Array> [<newindex>]) type
		change CameraCuts_LastType = ($<Camera_Array> [<newindex>].type)
	elseif StructureContains Structure = (<Camera_Array> [<newindex>]) params
		if StructureContains Structure = (<Camera_Array> [<newindex>].params) type
			change CameraCuts_LastType = ($<Camera_Array> [<newindex>].params.type)
		else
			change \{CameraCuts_LastType = none}
		endif
	else
		change \{CameraCuts_LastType = none}
	endif
	if ($debug_showcameraname = on)
		CameraCuts_UpdateDebugCameraName
	endif
	if ($output_gpu_log = 1)
		CameraCuts_OutputGPULog
	endif
	if StructureContains Structure = (<Camera_Array> [<newindex>]) params
		camStruct = ((<Camera_Array> [<newindex>]).params)
		if NOT StructureContains Structure = <camStruct> dof
			camStruct = (<Camera_Array> [<newindex>])
		endif
	endif
	if StructureContains Structure = <camStruct> dof
		if StructureContains Structure = (<camStruct>.dof) screen_fx
			dofType = (<camStruct>.dof)
			dofParam = (<dofType>.screen_fx [0])
		endif
	else
		dofParam = ($DOF_Off_tod_manager.screen_fx [0])
	endif
	if NOT ScreenFX_FxInstanceExists \{viewport = bg_viewport
			name = venue_DOF}
		ScreenFX_AddFXInstance {
			viewport = bg_viewport
			name = venue_DOF
			<dofParam>
		}
	else
		ScreenFX_UpdateFXInstanceParams {
			viewport = bg_viewport
			name = venue_DOF
			<dofParam>
		}
	endif
	if StructureContains Structure = (<Camera_Array> [<newindex>]) CrowdOff
		enable_crowd_models_cfunc \{active = false}
	else
		enable_crowd_models_cfunc \{active = true}
	endif
	if StructureContains Structure = (<Camera_Array> [<newindex>]) ShadowCasters
		change CameraCuts_ShadowCasters = (<Camera_Array> [<newindex>].ShadowCasters)
	else
		change \{CameraCuts_ShadowCasters = none}
	endif
	if IsNgc
		if StructureContains Structure = (<Camera_Array> [<newindex>]) NGCBloomOff
			DisableNgcBloom
		else
			EnableNgcBloom
		endif
		if StructureContains Structure = (<Camera_Array> [<newindex>]) NGCScreenEffectsOff
			DisableNgcFullscreenEffects
		else
			EnableNgcFullscreenEffects
		endif
		NgcClearGpuRanOver
		if StructureContains Structure = (<Camera_Array> [<newindex>]) ngcNearPlane
			NgcUseExtendedNearPlane ((<Camera_Array> [<newindex>]).ngcNearPlane)
		else
			NgcDontUseExtendedNearPlane
		endif
	endif
	if isps2
		gpu_load = 100.0
		if StructureContains Structure = (<Camera_Array> [<newindex>]) gpu
			gpu_load = ((<Camera_Array> [<newindex>]).gpu)
		endif
		if (<gpu_load> <= 80.0)
			ShowDOF
		else
			HideDOF
		endif
		if (<gpu_load> <= 71.0)
			if StructureContains Structure = (<Camera_Array> [<newindex>]) ShadowOn
				ShowStencilShadow
			else
				HideStencilShadow
			endif
		else
			HideStencilShadow
		endif
	endif
	change \{structurename = guitarist_info
		waiting_for_cameracut = false}
	change \{structurename = bassist_info
		waiting_for_cameracut = false}
	GetSongTimeMs
	change CameraCuts_LastCameraStartTime = <time>
	CamParams = (<Camera_Array> [<newindex>])
	CameraCut_SwapLookAts
	PlayIGCCam {
		time = <camera_time>
		viewport = bg_viewport
		controlscript = CameraCuts_StaticCamControl
		params = {CamParams = <CamParams>}
		<CamParams>
		exitscript = CameraCuts_StartCallback
		Play_hold = 0
		name = CameraCutCam
		<debug_flags>
	}
endscript

script CameraCuts_UpdateDebugCameraName 
	if ScreenElementExists \{id = debug_camera_name_text}
		GetArraySize ($CameraCuts_LastArray)
		cameraname = none
		if ($CameraCuts_LastIndex < <array_size>)
			if StructureContains Structure = (($CameraCuts_LastArray) [$CameraCuts_LastIndex]) params
				if StructureContains Structure = (($CameraCuts_LastArray) [$CameraCuts_LastIndex].params) name
					cameraname = ($CameraCuts_LastArray [$CameraCuts_LastIndex].params.name)
				endif
			endif
			if StructureContains Structure = (($CameraCuts_LastArray) [$CameraCuts_LastIndex]) name
				cameraname = ($CameraCuts_LastArray [$CameraCuts_LastIndex].name)
			endif
		endif
		<Crowd> = 1
		if StructureContains Structure = ($CameraCuts_LastArray [$CameraCuts_LastIndex]) CrowdOff
			<Crowd> = 0
		endif
		FormatText TextName = cameraname '%s type=%t crowd=%c' s = <cameraname> t = $CameraCuts_LastType c = <Crowd> DontAssertForChecksums
		debug_camera_name_text :SetProps text = <cameraname>
		DumpCameraGPU string = <cameraname>
	endif
endscript

script CameraCuts_OutputGPULog 
	GetArraySize ($CameraCuts_LastArray)
	cameraname = none
	if ($CameraCuts_LastIndex < <array_size>)
		if StructureContains Structure = (($CameraCuts_LastArray) [$CameraCuts_LastIndex]) params
			if StructureContains Structure = (($CameraCuts_LastArray) [$CameraCuts_LastIndex].params) name
				cameraname = ($CameraCuts_LastArray [$CameraCuts_LastIndex].params.name)
			endif
		endif
		if StructureContains Structure = (($CameraCuts_LastArray) [$CameraCuts_LastIndex]) name
			cameraname = ($CameraCuts_LastArray [$CameraCuts_LastIndex].name)
		endif
	endif
	<Crowd> = 1
	if StructureContains Structure = ($CameraCuts_LastArray [$CameraCuts_LastIndex]) CrowdOff
		<Crowd> = 0
	endif
	FormatText TextName = text 'Cam: %s, type: %t, crowd: %c ; ; ; 16.667' s = <cameraname> t = $CameraCuts_LastType c = <Crowd> DontAssertForChecksums
	TextOutput text = <text>
endscript

script destroy_cameracuts 
	change \{CameraCuts_Enabled = false}
	KillSpawnedScript \{name = CameraCuts_StartCallback}
	KillCamAnim \{name = CameraCutCam}
	kill_dummy_bg_camera
	ClearNoteMappings \{section = cameras}
	KillSpawnedScript \{name = cameracuts_iterator}
endscript
profiling_cameracuts = false

script profile_camera_cuts \{filename = 'ProfileCameras'}
	if ($profiling_cameracuts = true)
		return
	endif
	change \{profiling_cameracuts = true}
	hide_analog_options
	setslomo \{0.001}
	setslomo_song \{slomo = 0.001}
	dumpprofilestart
	GetPakManCurrentName \{map = zones}
	camera_count = 0
	begin
	switch <camera_count>
		case 0
		suffix = 'cameras_good'
		case 1
		suffix = 'cameras_normal'
		case 2
		suffix = 'cameras_poor'
		case 3
		suffix = 'cameras_good_2p'
		case 4
		suffix = 'cameras_normal_2p'
		case 5
		suffix = 'cameras_poor_2p'
	endswitch
	FormatText checksumname = Camera_Array '%s_%p' s = <pakname> p = <suffix>
	if GlobalExists name = <Camera_Array>
		GetArraySize $<Camera_Array>
		array_count = 0
		begin
		profile_cameracut Camera_Array_pakname = <pakname> Camera_Array = <suffix> array_count = <array_count>
		<array_count> = (<array_count> + 1)
		repeat <array_size>
	endif
	camera_count = (<camera_count> + 1)
	repeat 6
	change \{debug_camera_array = none}
	destroy_cameracuts
	Wait \{3
		gameframes}
	create_cameracuts
	dumpprofileend output_text output_file filename = <filename>
	setslomo \{$current_speedfactor}
	setslomo_song \{slomo = $current_speedfactor}
	change \{profiling_cameracuts = false}
endscript

script profile_cameracut 
	change debug_camera_array = <Camera_Array>
	change debug_camera_array_pakname = <Camera_Array_pakname>
	change debug_camera_array_count = <array_count>
	cpu = $current_cpu
	ToggleMetrics \{mode = 2}
	change \{current_cpu = 6}
	destroy_cameracuts
	Wait \{2
		gameframes}
	create_cameracuts
	Wait \{3
		gameframes}
	profile_camera_gpu
	ToggleMetrics \{mode = 0}
	change current_cpu = <cpu>
endscript

script profile_camera_gpu 
	FormatText \{checksumname = New_Camera_Array
		'%s_%p'
		s = $debug_camera_array_pakname
		p = $debug_camera_array}
	Camera_Array = $<New_Camera_Array>
	if StructureContains Structure = (<Camera_Array> [$debug_camera_array_count]) name
		FormatText TextName = title 'Camera %n Profile Dump' n = ((<Camera_Array> [$debug_camera_array_count]).name) DontAssertForChecksums
	else
		FormatText TextName = title 'Camera %n Profile Dump' n = ((<Camera_Array> [$debug_camera_array_count]).params.name) DontAssertForChecksums
	endif
	dumpprofile cpu = 6 title = <title> current_time_only
endscript

script CameraCuts_EnableChangeCam 
	change CameraCuts_ChangeCamEnable = <enable>
	change \{CameraCuts_ChangeNow = true}
endscript

script CameraCuts_CalcTime 
	if ($CameraCuts_ChangeNow = true)
		camera_time = 0
		GetSongTimeMs
		camera_songtime = (<time> + <camera_time> * 1000)
		return camera_time = <camera_time> camera_songtime = <camera_songtime>
	endif
	if ($CameraCuts_ForceTime = 0)
		if ($CameraCuts_NextTime = 0)
			camera_time = RandomRange (3.0, 8.0)
			GetSongTimeMs
			endtime = (<time> + <camera_time> * 1000)
			CameraCuts_GetNextDownbeat endtime = <endtime>
			camera_time = ((<endtime> - <time>) / 1000.0)
		else
			camera_time = ($CameraCuts_NextTime / 1000.0)
			change \{CameraCuts_NextTime = 0}
		endif
	else
		camera_time = ($CameraCuts_ForceTime)
	endif
	GetSongTimeMs
	camera_songtime = (<time> + <camera_time> * 1000)
	return camera_time = <camera_time> camera_songtime = <camera_songtime>
endscript

script CameraCuts_WaitScript \{camera_time = 0
		camera_songtime = 0}
	GetSongTimeMs
	change CameraCuts_ChangeTime = <camera_songtime>
	begin
	GetSongTimeMs
	if (<time> >= $CameraCuts_ChangeTime ||
			$CameraCuts_ChangeNow = true)
		if ($CameraCuts_ChangeCamEnable = true)
			break
		endif
	endif
	if NOT ($CameraCuts_ForceChangeTime = 0.0)
		if ($CameraCuts_ForceChangeTime < (<time> - $CameraCuts_LastCameraStartTime))
			change \{CameraCuts_ForceChangeTime = 0.0}
			break
		endif
	endif
	if GotParam \{nowait}
		return \{false}
	endif
	WaitOneGameFrame
	repeat
	return \{true}
endscript

script CameraCuts_StaticCamControl 
	CameraCuts_CalcTime
	CCam_DoMorph {
		<CamParams>
	}
	CameraCuts_WaitScript camera_songtime = <camera_songtime>
endscript

script CameraCuts_HandCam \{name = none}
	CameraCuts_CalcTime
	CCam_DoMorph <...>
	zooming = false
	if GotParam \{type}
		if (<type> = longshot)
			GetRandomValue \{name = random_value
				Integer
				a = 0
				b = 100}
			if (<random_value> < 25)
				CCam_DoMorph <...> FOV = 62 time = <camera_time>
				zooming = true
			endif
			if (<random_value> > 95)
				CCam_DoMorph <...> FOV = 78 time = <camera_time>
				zooming = true
			endif
		endif
		if (<type> = mid)
			GetRandomValue \{name = random_value
				Integer
				a = 0
				b = 100}
			if (<random_value> < 5)
				CCam_DoMorph <...> FOV = 64 time = <camera_time>
				zooming = true
			endif
			if (<random_value> > 85)
				CCam_DoMorph <...> FOV = 82 time = <camera_time>
				zooming = true
			endif
		endif
	endif
	if (<zooming> = true)
		amplitudePosition = 0.01
		amplitudeRotation = -0.01
	else
		amplitudePosition = 0.05
		amplitudeRotation = -0.08
	endif
	CameraCuts_SetHandCamParams <...>
	CameraCuts_WaitScript camera_songtime = <camera_songtime>
endscript

script CameraCuts_TwoCam 
	if GotParam \{UseHandCam}
		CameraCuts_SetHandCamParams \{amplitudePosition = 0.05
			amplitudeRotation = -0.08}
	endif
	CameraCuts_CalcTime
	CCam_DoMorph {
		<Cam1>
	}
	CCam_WaitMorph
	CCam_DoMorph {
		<Cam2>
		time = <camera_time>
	}
	CameraCuts_WaitScript camera_songtime = <camera_songtime>
endscript

script CameraCuts_Encore 
	CameraCuts_CalcTime
	CCam_DoMorph {
		<Cam1>
	}
	Wait \{3
		seconds}
	CCam_DoMorph {
		<Cam2>
	}
	Wait \{2.5
		seconds}
	CCam_DoMorph {
		<Cam3>
	}
	Wait \{3
		seconds}
	CCam_DoMorph {
		<Cam4>
	}
	Wait \{2
		seconds}
	CCam_DoMorph {
		<Cam5>
	}
	CameraCuts_WaitScript camera_songtime = <camera_songtime>
endscript

script CameraCuts_Orbit 
	CameraCuts_CalcTime
	CCam_DoMorph {
		<...>
	}
	orbitangle = (3.1409998 * <orbitangle> / 180.0)
	if (<camera_time> > 0)
		CCam_Orbit axis = (0.0, 1.0, 0.0) Speed = (<orbitangle> / <camera_time>)
	endif
	CameraCuts_SetHandCamDriftOnly
	CameraCuts_WaitScript camera_songtime = <camera_songtime>
endscript

script CameraCuts_OrbitAndMorphTwoCam 
	CameraCuts_CalcTime
	if (<camera_time> > 0)
		<orbitangle> = (3.1409998 * <orbitangle> / 180.0)
		<orbitparams> = {axis = (0.0, 1.0, 0.0) Speed = (<orbitangle> / <camera_time>)}
	endif
	CCam_DoMorph {
		<Cam1>
	}
	if (<camera_time> > 0)
		if GotParam \{DisableOrbit1}
			CCam_Orbit \{off}
		else
			CCam_Orbit <orbitparams>
		endif
	endif
	CameraCuts_SetHandCamDriftOnly
	CCam_DoMorph {
		<Cam2>
		time = <camera_time>
	}
	if (<camera_time> > 0)
		if GotParam \{DisableOrbit2}
			CCam_Orbit \{off}
		else
			CCam_Orbit <orbitparams>
		endif
	endif
	CameraCuts_WaitScript camera_songtime = <camera_songtime>
endscript

script CameraCuts_SplineMorph 
	CameraCuts_CalcTime
	CCam_SplineMorph {
		<...>
		total_time = <camera_time>
	}
	CameraCuts_WaitScript camera_songtime = <camera_songtime>
endscript

script CameraCuts_SpecialStepMove 
	CCam_SetSmoothing \{type = all
		on = 1
		slow_lerp_factor = 0.7
		fast_lerp_factor = 0.7
		lerp_dropoff = 2.0}
	CameraCuts_CalcTime
	CCam_DoMorph {
		<Cam1>
	}
	CameraCuts_SetHandCamParams \{amplitudePosition = 0.0
		amplitudeRotation = -0.8}
	origpos = (<Cam1>.pos)
	diry = <StepDir>
	count = 0.0
	timestep = 0.05
	step = (<timestep> / <stepTime>)
	num_jumps = <StepNum>
	dirx = ((<Cam2>.pos) - (<Cam1>.pos))
	jump_multiplier = (<num_jumps> * 360.0)
	count = (<count> + <step>)
	begin
	if (<count> >= 1.0)
		break
	endif
	sin (<count> * <jump_multiplier>)
	pos = (<origpos> + <dirx> * <count> + <diry> * <sin>)
	CCam_DoMorph {
		<...>
		time = <timestep>
		motion = linear
	}
	CCam_WaitMorph
	if CameraCuts_WaitScript camera_songtime = <camera_songtime> nowait
		return
	endif
	count = (<count> + <step>)
	repeat
	CCam_DoMorph {
		<Cam2>
		time = <FinalRotTime>
		motion = smooth
	}
	CameraCuts_WaitScript camera_songtime = <camera_songtime>
endscript

script CameraCuts_ApplyDOF \{dof = $DOF_Medium02_tod_manager
		time = 0.0}
	dofType = <dof>
	dofParam = (<dofType>.screen_fx [0])
	if NOT ScreenFX_FxInstanceExists \{viewport = bg_viewport
			name = venue_DOF}
		ScreenFX_AddFXInstance {
			viewport = bg_viewport
			name = venue_DOF
			<dofParam>
			time = <time>
		}
	else
		ScreenFX_UpdateFXInstanceParams {
			viewport = bg_viewport
			name = venue_DOF
			<dofParam>
			time = <time>
		}
	endif
endscript

script CameraCuts_SetHandCamDriftOnly 
	CCam_EnableHandcam \{ShakeEnabled = false
		DriftEnabled = true}
	driftSlerpMap = [
		(0.1, 0.3)
		(0.2, 0.3)
	]
	if GotParam \{DriftZoneAngles}
		SetArrayElement ArrayName = driftSlerpMap index = 1 newvalue = <DriftZoneAngles>
	endif
	CCam_SetHandcamParams {
		$cinematic_camera_default_handcam_params
		driftSlerpMap = <driftSlerpMap>
	}
endscript

script CameraCuts_SetHandCamParams \{amplitudePosition = 0.01
		amplitudeRotation = -0.01}
	CCam_EnableHandcam \{ShakeEnabled = true
		DriftEnabled = true}
	CCam_SetHandcamParams {
		motionX = {
			amplitude = 0.033999998
			center = 0.0
			periodBase = 0.012999999
			periodMultiples = [
				1 , 3 , 4
			]
		}
		motionY = {
			amplitude = 0.04
			center = 0.0
			periodBase = 0.016999999
			periodMultiples = [
				1 , 3 , 4
			]
		}
		amplitudePosition = {
			amplitude = <amplitudePosition>
			center = 0.0
			periodBase = 0.0023
			periodMultiples = [
				1 , 16
			]
		}
		amplitudeRotation = {
			amplitude = <amplitudeRotation>
			center = 0.0
			periodBase = 0.0023
			periodMultiples = [
				1
			]
		}
		zoomStabilityMap = [
			(1.3, 0.7)
			(30.0, 100.0)
		]
		driftSlerpMap = [
			(0.0, 0.8)
			(0.05, 1.0)
		]
		zoomDriftMap = [
			(1.2, 0.6)
			(30.0, 100.0)
		]
		driftAllowedAmplitude = {
			amplitude = 0.4
			center = 1.0
			periodBase = 0.02
			periodMultiples = [
				1
			]
		}
	}
endscript

script CameraCuts_HandCamZoom2 
	CCam_DoMorph <...>
	zooming = false
	if (<zooming> = true)
		amplitudePosition = 0.01
		amplitudeRotation = -0.01
	else
		amplitudePosition = 0.05
		amplitudeRotation = -0.08
	endif
	CameraCuts_SetHandCamParams <...>
	Wait \{2
		seconds}
	CCam_DoMorph <...> FOV = 50 time = 0.6 motion = smooth
	CCam_WaitMorph
	Wait \{0.1
		seconds}
	CCam_DoMorph <...> FOV = 53 time = 0.25 motion = smooth
	CCam_WaitMorph
	Wait \{0.03
		seconds}
	CCam_DoMorph <...> FOV = 51 time = 0.3 motion = smooth
	CCam_WaitMorph
	CCam_DoMorph <...> FOV = 51
	CameraCuts_CalcTime
	CameraCuts_WaitScript camera_songtime = <camera_songtime>
endscript

script CameraCuts_QuickZoom 
	CCam_DoMorph <...>
	zooming = false
	if (<zooming> = true)
		amplitudePosition = 0.01
		amplitudeRotation = -0.01
	else
		amplitudePosition = 0.05
		amplitudeRotation = -0.08
	endif
	CameraCuts_SetHandCamParams <...>
	CCam_DoMorph {
		<Cam1>
	}
	CCam_WaitMorph
	Wait \{2
		seconds}
	CCam_DoMorph {
		<Cam1>
	}
	CCam_WaitMorph
	CCam_DoMorph {
		<Cam2>
		time = 0.75
		motion = smooth
	}
	CCam_WaitMorph
	CCam_DoMorph {
		<Cam2>
	}
	CCam_WaitMorph
	CameraCuts_CalcTime
	CameraCuts_WaitScript camera_songtime = <camera_songtime>
endscript

script CameraCuts_Pan 
	CameraCuts_SetHandCamParams \{amplitudePosition = 0.05
		amplitudeRotation = -0.08}
	CCam_DoMorph {
		<Cam1>
		time = 0
	}
	Wait \{2
		seconds}
	CCam_DoMorph {
		<Cam2>
		time = 1
		motion = smooth
	}
	CCam_WaitMorph
	CameraCuts_CalcTime
	CameraCuts_WaitScript camera_songtime = <camera_songtime>
endscript

script CameraCuts_ThreePos 
	CameraCuts_CalcTime
	CCam_SplineMorph {
		keyframes =
		[
			{
				<Cam1>
			}
			{
				<Cam2>
			}
			{
				<Cam3>
			}
		]
		total_time = <camera_time>
	}
	CameraCuts_WaitScript camera_songtime = <camera_songtime>
endscript

script CameraCuts_FourPos 
	CameraCuts_CalcTime
	CCam_SplineMorph {
		keyframes =
		[
			{
				<Cam1>
			}
			{
				<Cam2>
			}
			{
				<Cam3>
			}
			{
				<Cam4>
			}
		]
		total_time = <camera_time>
	}
	CameraCuts_WaitScript camera_songtime = <camera_songtime>
endscript
Default_Cameras_Good = [
	{
		name = good_from_stage
		Play_hold = 1
		LockTo = Guitarist
		pos = (1.5175159, 4.1361775, -4.089658)
		Quat = (0.130047, -0.018706, 0.0024160002)
		FOV = 72.0
	}
	{
		name = good_center_stage
		Play_hold = 1
		LockTo = Guitarist
		pos = (2.102435, 1.999219, 7.695495)
		Quat = (-2.6E-05, 0.9999869, -0.0043200003)
		FOV = 72.0
	}
	{
		name = good_stage_left
		Play_hold = 1
		LockTo = Guitarist
		pos = (8.62121, 4.4717703, 6.8967915)
		Quat = (0.093209006, -0.903863, 0.254238)
		FOV = 72.0
	}
	{
		name = good_stage_right
		Play_hold = 1
		LockTo = Guitarist
		pos = (-7.182758, 2.553803, 8.634896)
		Quat = (0.048714, 0.90134895, -0.105318)
		FOV = 72.0
	}
]
Default_Cameras_Normal = [
	{
		name = normal_crowd_center
		Play_hold = 1
		LockTo = Guitarist
		pos = (5.108431, 1.485993, 13.082112)
		Quat = (0.0025400002, -0.9918739, 0.019756)
		FOV = 72.0
	}
	{
		name = normal_crowd_right
		Play_hold = 1
		LockTo = Guitarist
		pos = (10.656881, 1.486412, 12.041036)
		Quat = (0.00589, -0.95563596, 0.019026998)
		FOV = 72.0
	}
	{
		name = normal_crowd_left
		Play_hold = 1
		LockTo = Guitarist
		pos = (-4.8624063, 1.3204769, 14.310162)
		Quat = (0.001153, 0.98261094, -0.006309)
		FOV = 72.0
	}
]
Default_Cameras_Poor = [
	{
		name = poor_crowd_center
		Play_hold = 1
		LockTo = Guitarist
		pos = (-1.573781, 1.4759071, 20.610792)
		Quat = (-0.00064900005, 0.998182, 0.010279999)
		FOV = 72.0
	}
	{
		name = poor_crowd_right
		Play_hold = 1
		LockTo = Guitarist
		pos = (10.420851, 1.5101589, 18.768383)
		Quat = (-0.0024040001, -0.97147197, -0.010015999)
		FOV = 72.0
	}
	{
		name = poor_crowd_left
		Play_hold = 1
		LockTo = Guitarist
		pos = (-9.160233, 1.604391, 20.10081)
		Quat = (-0.0018660001, 0.984061, 0.010129999)
		FOV = 72.0
	}
]
default_cameras_intro = [
	{
		name = crowd_center_zoom
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (0.35540104, 1.766598, 9.495748)
				Quat = (0.00019699999, -0.999465, 0.032123)
				FOV = 72.0
			}
			Cam2 = {
				LockTo = world
				pos = (0.30482104, 3.097976, 5.3770776)
				Quat = (0.0012020001, -0.98061997, 0.195825)
				FOV = 72.0
			}
		}
	}
]
default_cameras_fastintro = [
	{
		name = crowd_center_zoom
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (0.30482104, 3.097976, 5.3770776)
				Quat = (0.0012020001, -0.98061997, 0.195825)
				FOV = 72.0
			}
			Cam2 = {
				LockTo = world
				pos = (0.35540104, 1.766598, 9.495748)
				Quat = (0.00019699999, -0.999465, 0.032123)
				FOV = 72.0
			}
		}
	}
]
default_cameras_dolly = [
	{
		name = Dolly_StageFront
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (-2.467382, 1.2211041, 2.731025)
				Quat = (0.027345998, 0.774946, -0.033513)
				FOV = 72.0
			}
			Cam2 = {
				LockTo = world
				pos = (5.1025147, 1.024014, 1.060797)
				Quat = (-0.021949, -0.780419, -0.026007999)
				FOV = 72.0
			}
		}
	}
	{
		name = Dolly_StageRear
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (-2.467382, 1.2211041, 2.731025)
				Quat = (0.027345998, 0.774946, -0.033513)
				FOV = 72.0
			}
			Cam2 = {
				LockTo = world
				pos = (5.1025147, 1.024014, 1.060797)
				Quat = (-0.021949, -0.780419, -0.026007999)
				FOV = 72.0
			}
		}
	}
]
default_cameras_zoom = [
	{
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (-2.467382, 1.2211041, 2.731025)
				Quat = (0.027345998, 0.774946, -0.033513)
				FOV = 72.0
			}
			Cam2 = {
				LockTo = world
				pos = (5.1025147, 1.024014, 1.060797)
				Quat = (-0.021949, -0.780419, -0.026007999)
				FOV = 72.0
			}
		}
	}
]
default_cameras_zoom_fast = [
	{
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (-2.467382, 1.2211041, 2.731025)
				Quat = (0.027345998, 0.774946, -0.033513)
				FOV = 72.0
			}
			Cam2 = {
				LockTo = world
				pos = (5.1025147, 1.024014, 1.060797)
				Quat = (-0.021949, -0.780419, -0.026007999)
				FOV = 72.0
			}
		}
	}
]
default_cameras_zoom_slow = [
	{
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (-2.467382, 1.2211041, 2.731025)
				Quat = (0.027345998, 0.774946, -0.033513)
				FOV = 72.0
			}
			Cam2 = {
				LockTo = world
				pos = (5.1025147, 1.024014, 1.060797)
				Quat = (-0.021949, -0.780419, -0.026007999)
				FOV = 72.0
			}
		}
	}
]
default_cameras_zoom_out = [
	{
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (-2.467382, 1.2211041, 2.731025)
				Quat = (0.027345998, 0.774946, -0.033513)
				FOV = 72.0
			}
			Cam2 = {
				LockTo = world
				pos = (5.1025147, 1.024014, 1.060797)
				Quat = (-0.021949, -0.780419, -0.026007999)
				FOV = 72.0
			}
		}
	}
]
default_cameras_pan = [
	{
		controlscript = CameraCuts_Pan
		params = {
			Cam1 = {
				LockTo = world
				pos = (-2.467382, 1.2211041, 2.731025)
				Quat = (0.027345998, 0.774946, -0.033513)
				FOV = 72.0
			}
			Cam2 = {
				LockTo = world
				pos = (5.1025147, 1.024014, 1.060797)
				Quat = (-0.021949, -0.780419, -0.026007999)
				FOV = 72.0
			}
		}
	}
]
default_cameras_preencore = [
	{
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = Drummer
				pos = (-2.4889898, 2.2800958, 9.589442)
				Quat = (0.033784002, 0.965961, -0.164262)
				FOV = 72.0
				LookAt = Drummer
				LookAtBone = Bone_Chest
				ScreenOffset = (-0.225398, -0.579956)
			}
			Cam2 = {
				LockTo = Drummer
				pos = (4.951395, 2.2763019, 9.435161)
				Quat = (0.050596002, -0.9369719, 0.15382701)
				FOV = 72.0
				LookAt = Drummer
				LookAtBone = Bone_Chest
				ScreenOffset = (0.26263002, -0.568209)
			}
		}
	}
]
default_cameras_encore = [
	{
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (-2.8748507, 2.11633, 3.001765)
				Quat = (0.055925, 0.88826996, -0.112448)
				FOV = 72.0
			}
			Cam2 = {
				LockTo = world
				pos = (6.485794, 2.790986, 6.2345123)
				Quat = (0.081708, -0.7229049, 0.08677899)
				FOV = 72.0
			}
		}
	}
]
default_cameras_preboss = [
	{
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = Drummer
				pos = (-2.4889898, 2.2800958, 9.589442)
				Quat = (0.033784002, 0.965961, -0.164262)
				FOV = 72.0
				LookAt = Drummer
				LookAtBone = Bone_Chest
				ScreenOffset = (-0.225398, -0.579956)
			}
			Cam2 = {
				LockTo = Drummer
				pos = (4.951395, 2.2763019, 9.435161)
				Quat = (0.050596002, -0.9369719, 0.15382701)
				FOV = 72.0
				LookAt = Drummer
				LookAtBone = Bone_Chest
				ScreenOffset = (0.26263002, -0.568209)
			}
		}
	}
]
default_cameras_boss = [
	{
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (-2.8748507, 2.11633, 3.001765)
				Quat = (0.055925, 0.88826996, -0.112448)
				FOV = 72.0
			}
			Cam2 = {
				LockTo = world
				pos = (6.485794, 2.790986, 6.2345123)
				Quat = (0.081708, -0.7229049, 0.08677899)
				FOV = 72.0
			}
		}
	}
]
default_cameras_guitar_closeup = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			LockTo = world
			LookAt = Guitarist
			LookAtBone = Bone_Guitar_Body
			pos = (-0.073745, 0.7753869, 0.023635)
			Quat = (0.047147997, -0.9942729, -0.005626)
			FOV = 72.0
		}
		dof = $DOF_CloseUp01_tod_manager
	}
]
default_cameras_drummer = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = Drummer_Center
			LockTo = world
			pos = (-3.3800898, 1.184646, -5.141132)
			Quat = (0.00305, -0.97887796, 0.013742999)
			FOV = 85.0
		}
		dof = $DOF_CloseUp02_tod_manager
	}
]
default_cameras_singer = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = Singer_Left
			LockTo = world
			pos = (-6.321385, 0.924312, -2.6622968)
			Quat = (-0.026229998, 0.784364, 0.032947995)
			FOV = 72.0
		}
		dof = $DOF_CloseUp01_tod_manager
	}
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = Singer_Center
			LockTo = world
			pos = (-4.3443885, 0.950269, -0.84059906)
			Quat = (1.9E-05, 0.99112797, -0.001512)
			FOV = 72.0
		}
		dof = $DOF_CloseUp01_tod_manager
	}
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = Singer_Right
			LockTo = world
			pos = (-1.543603, 0.87668294, -1.361017)
			Quat = (-0.008355001, -0.953027, -0.027003)
			FOV = 72.0
		}
		dof = $DOF_CloseUp01_tod_manager
	}
]
default_cameras_singer_closeup = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = singer_closeup
			LockTo = world
			pos = (-1.543603, 0.87668294, -1.361017)
			Quat = (-0.008355001, -0.953027, -0.027003)
			FOV = 72.0
		}
		dof = $DOF_CloseUp01_tod_manager
	}
]
default_cameras_bassist = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = Bassist_Center
			LockTo = world
			pos = (-3.3800898, 1.184646, -5.141132)
			Quat = (0.00305, -0.97887796, 0.013742999)
			FOV = 85.0
		}
		dof = $DOF_CloseUp02_tod_manager
	}
]
default_cameras_solo = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = Guitar_Neck_Normal
			type = Normal
			LockTo = Guitarist
			LockToBone = bone_guitar_neck
			pos = (0.742165, 0.095542006, 0.027762)
			Quat = (-0.31134596, -0.632061, 0.42270902)
			FOV = 57.0
		}
		dof = $DOF_CloseUp03_tod_manager
		CrowdOff
	}
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = Guitar_Body_Normal
			type = Normal
			LockTo = Guitarist
			LockToBone = bone_guitar_neck
			pos = (-0.52196294, 0.206606, 0.228494)
			Quat = (0.066760994, 0.80269796, -0.260841)
			FOV = 76.0
		}
		dof = $DOF_CloseUp03_tod_manager
		CrowdOff
	}
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = Guitar_Neck_Demonik
			type = demonik
			LockTo = Guitarist
			LockToBone = Bone_Guitar_Body
			pos = (1.305142, 0.289514, 0.028687)
			Quat = (-0.260674, -0.64566904, 0.48475105)
			FOV = 72.0
		}
		dof = $DOF_CloseUp03_tod_manager
		CrowdOff
	}
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = Guitar_Body_Demonik
			type = demonik
			LockTo = Guitarist
			LockToBone = Bone_Guitar_Body
			pos = (-0.35794002, 0.470057, 0.060370997)
			Quat = (-0.086646, 0.686242, -0.476262)
			FOV = 72.0
		}
		dof = $DOF_CloseUp03_tod_manager
		CrowdOff
	}
]
default_cameras_orbit = [
	{
		controlscript = CameraCuts_Orbit
		params = {
			name = Orbit_Stage
			LockTo = Guitarist
			pos = (0.61307204, 0.85457504, -1.556369)
			Quat = (-0.055081, -0.325498, -0.019047)
			FOV = 72.0
			orbitangle = 80
		}
		dof = $DOF_CloseUp01_tod_manager
	}
	{
		controlscript = CameraCuts_Orbit
		params = {
			name = Orbit_CloseUp
			LockTo = Guitarist
			pos = (-0.623458, 1.762923, 1.452922)
			Quat = (0.058131002, 0.9316849, -0.172848)
			FOV = 72.0
			orbitangle = 40
		}
		dof = $DOF_CloseUp01_tod_manager
	}
	{
		controlscript = CameraCuts_Orbit
		params = {
			name = Orbit_Mid
			LockTo = Guitarist
			pos = (1.8531569, 1.402983, 2.3796542)
			Quat = (0.047396, -0.89235497, 0.096345)
			FOV = 72.0
			orbitangle = 70
		}
		dof = $DOF_CloseUp01_tod_manager
	}
	{
		controlscript = CameraCuts_Orbit
		params = {
			name = Orbit_Drummer
			LockTo = Drummer
			pos = (-1.155043, 2.428414, 3.3713057)
			Quat = (0.039694, 0.95921797, -0.21765)
			FOV = 72.0
			orbitangle = 50
		}
		dof = $DOF_CloseUp01_tod_manager
	}
	{
		controlscript = CameraCuts_Orbit
		params = {
			name = Orbit_Singer
			LockTo = vocalist
			pos = (-1.155043, 2.428414, 3.3713057)
			Quat = (0.039694, 0.95921797, -0.21765)
			FOV = 72.0
			orbitangle = 50
		}
		dof = $DOF_CloseUp01_tod_manager
	}
]
default_cameras_starpower = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = star_power
			LockTo = world
			pos = (0.622013, 0.681226, 1.318936)
			Quat = (-0.016913, -0.92676395, -0.041992996)
			FOV = 72.0
		}
		dof = $DOF_CloseUp02_tod_manager
	}
]
default_cameras_boss_finish = [
	{
		name = boss_devil_finish
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (0.962169, 0.53960097, 3.2702482)
				Quat = (-0.023288, 0.977894, 0.18821001)
				FOV = 72.0
			}
			Cam2 = {
				LockTo = world
				pos = (0.87311107, 1.4404389, 2.421501)
				Quat = (-0.06923701, 0.920361, 0.168251)
				FOV = 72.0
			}
		}
	}
]
default_cameras_boss_dead = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			LockTo = world
			pos = (3.557984, 1.241251, 3.824588)
			Quat = (-0.024045, -0.90200096, 0.010152999)
			FOV = 96.0
		}
	}
]
default_cameras_walk = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = Walk01
			LockTo = world
			pos = (0.373905, 0.631563, 4.8783784)
			Quat = (-0.016905999, 0.9827779, 0.14206801)
			FOV = 72.0
		}
		dof = $DOF_CloseUp02_tod_manager
	}
]
default_cameras_stagedive = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = StageDive
			LockTo = world
			pos = (0.373905, 0.631563, 4.8783784)
			Quat = (-0.016905999, 0.9827779, 0.14206801)
			FOV = 72.0
		}
		dof = $DOF_CloseUp02_tod_manager
	}
]
default_cameras_win = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = win
			LockTo = world
			pos = (0.622013, 0.681226, 1.318936)
			Quat = (-0.016913, -0.92676395, -0.041992996)
			FOV = 72.0
		}
		dof = $DOF_CloseUp02_tod_manager
	}
]
default_cameras_lose = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = lose
			LockTo = world
			pos = (-0.97144395, 0.90905, 0.850675)
			Quat = (-0.00064100005, -0.99934596, -0.02286)
			FOV = 72.0
		}
		dof = $DOF_CloseUp02_tod_manager
	}
]
default_cameras_vert_drummer = [
	{
		name = VertDrummer01
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (3.039751, 1.553329, 2.9490602)
				Quat = (0.024109, -0.89691794, 0.049145)
				FOV = 71.0
			}
			Cam2 = {
				LockTo = world
				pos = (-7.7150383, 1.4195828, 2.9341018)
				Quat = (0.00736, 0.93007594, -0.018824998)
				FOV = 71.0
			}
		}
	}
]
default_cameras_vert_guitarist = [
	{
		name = VertGuitarist01
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (3.039751, 1.553329, 2.9490602)
				Quat = (0.024109, -0.89691794, 0.049145)
				FOV = 71.0
			}
			Cam2 = {
				LockTo = world
				pos = (-7.7150383, 1.4195828, 2.9341018)
				Quat = (0.00736, 0.93007594, -0.018824998)
				FOV = 71.0
			}
		}
	}
]
default_cameras_vert_stagerear = [
	{
		name = VertStageRear
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (3.039751, 1.553329, 2.9490602)
				Quat = (0.024109, -0.89691794, 0.049145)
				FOV = 71.0
			}
			Cam2 = {
				LockTo = world
				pos = (-7.7150383, 1.4195828, 2.9341018)
				Quat = (0.00736, 0.93007594, -0.018824998)
				FOV = 71.0
			}
		}
	}
]
default_cameras_vert_stagefront = [
	{
		name = VertStageFront
		controlscript = CameraCuts_TwoCam
		params = {
			Cam1 = {
				LockTo = world
				pos = (3.039751, 1.553329, 2.9490602)
				Quat = (0.024109, -0.89691794, 0.049145)
				FOV = 71.0
			}
			Cam2 = {
				LockTo = world
				pos = (-7.7150383, 1.4195828, 2.9341018)
				Quat = (0.00736, 0.93007594, -0.018824998)
				FOV = 71.0
			}
		}
	}
]
default_cameras_special = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = special01
			LockTo = world
			pos = (-6.321385, 0.924312, -2.6622968)
			Quat = (-0.026229998, 0.784364, 0.032947995)
			FOV = 72.0
		}
		dof = $DOF_CloseUp01_tod_manager
	}
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = special02
			LockTo = world
			pos = (-4.3443885, 0.950269, -0.84059906)
			Quat = (1.9E-05, 0.99112797, -0.001512)
			FOV = 72.0
		}
		dof = $DOF_CloseUp01_tod_manager
	}
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = Special03
			LockTo = world
			pos = (-1.543603, 0.87668294, -1.361017)
			Quat = (-0.008355001, -0.953027, -0.027003)
			FOV = 72.0
		}
		dof = $DOF_CloseUp01_tod_manager
	}
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = Special04
			LockTo = world
			pos = (-1.543603, 0.87668294, -1.361017)
			Quat = (-0.008355001, -0.953027, -0.027003)
			FOV = 72.0
		}
		dof = $DOF_CloseUp01_tod_manager
	}
]
default_cameras_boss_closeup_2p = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = Boss_CloseUp
			LockTo = world
			pos = (-6.321385, 0.924312, -2.6622968)
			Quat = (-0.026229998, 0.784364, 0.032947995)
			FOV = 72.0
		}
		dof = $DOF_CloseUp01_tod_manager
	}
]
default_cameras_player_closeup_2p = [
	{
		controlscript = CameraCuts_HandCam
		params = {
			name = Player_CloseUp
			LockTo = world
			pos = (-6.321385, 0.924312, -2.6622968)
			Quat = (-0.026229998, 0.784364, 0.032947995)
			FOV = 72.0
		}
		dof = $DOF_CloseUp01_tod_manager
	}
]
