check_for_unplugged_controllers = 0
AnimLODInterleave2 = 12
AnimLODInterleave4 = 9
PS3_AnimLODInterleave2 = 20
PS3_AnimLODInterleave4 = 12
Xenon_AnimLODInterleave2 = 20
Xenon_AnimLODInterleave4 = 12

script autolaunch 
	if GotParam \{level}
		change current_level = <level>
		startnow = 2
	endif
	if GotParam \{song}
		change current_song = <song>
		startnow = 1
	endif
	if GotParam \{difficulty}
		change current_difficulty = <difficulty>
		startnow = 1
	endif
	if GotParam \{difficulty2}
		change current_difficulty2 = <difficulty2>
		startnow = 1
	endif
	if GotParam \{StartTime}
		change current_starttime = <StartTime>
		startnow = 1
	endif
	if GotParam \{controller}
		change structurename = player1_status controller = <controller>
		change player1_device = <controller>
		change primary_controller = <controller>
		startnow = 1
	endif
	if GotParam \{controller2}
		change structurename = player2_status controller = <controller2>
		startnow = 1
	endif
	if GotParam \{game_mode}
		change game_mode = <game_mode>
		if ($game_mode = p2_faceoff || $game_mode = p2_pro_faceoff)
			change \{current_num_players = 2}
		endif
		startnow = 1
	endif
	if GotParam \{startnow}
		SetGlobalTags \{Progression
			params = {
				current_tier = 1
			}}
		SetGlobalTags \{Progression
			params = {
				current_song_count = 0
			}}
		change autolaunch_startnow = <startnow>
	endif
	if GotParam \{force_encore}
		change \{force_encore_autolaunch = 1}
	endif
	if GotParam \{Guitarist}
		change structurename = player1_status character_id = <Guitarist>
	endif
	translate_gamemode
endscript

script change_level 
	script_assert \{'This is now gone...'}
endscript

script KillElement3d 
	WaitOneGameFrame
	Die
endscript

script setup_ped_speech \{inner_radius = 0.3
		Speed = 0.5
		pad_choose_script = ped_speech_exit}
	if NOT IsCreated <ped_id>
		ScriptAssert \{'tried to set up ped speech on an object that doesn\'t exist'}
	endif
	<ped_id> :Obj_SetInnerRadius <inner_radius>
	ClearEventHandler \{AnyObjectInRadius}
	ClearEventHandler \{ObjectOutOfRadius}
	SetEventHandler event = AnyObjectInRadius Scr = ped_speech_got_trigger reponse = call_script params = <...>
endscript

script ped_speech_got_trigger \{set_script = SetEventHandler
		set_script_scr = ped_speech_got_trigger}
	if NOT <colObjId> :IsLocalSkater
		return
	endif
	if (($dont_create_speech_boxes = 1) || ($game_progress_block_triggers = 1) || ($sysnotify_wait_in_progress = 1))
		return
	endif
	ClearEventHandler \{AnyObjectInRadius}
	if ObjectExists \{id = ped_speech_dialog}
		<should_destroy> = 0
		if skater :IsInBail
			<should_destroy> = 1
		endif
		if SkaterCurrentScorePotGreaterThan \{0}
			<should_destroy> = 1
		endif
		if <colObjId> :DoingTrick
			<should_destroy> = 1
		endif
		if NOT GMan_CanStartGoal
			<should_destroy> = 1
		endif
		if GotParam \{hide_in_goals}
			if GMan_HasActiveGoals
				<should_destroy> = 1
			endif
		endif
		if (<should_destroy> = 1)
			DestroyScreenElement \{id = ped_speech_dialog}
		endif
		<set_script> event = AnyObjectInRadius Scr = <set_script_scr> object = <ped_id> params = <...>
	else
		show_speech_box = 1
		if IsTrue \{$igc_playing}
			show_speech_box = 0
		endif
		if ObjectExists \{id = root_window}
			root_window :GetTags
			if GotParam \{menu_state}
				if (<menu_state> = on)
					show_speech_box = 0
				endif
			endif
		endif
		if NOT GMan_CanStartGoal
			if NOT InNetGame
				show_speech_box = 0
			endif
		endif
		if NOT <colObjId> :OnGround
			show_speech_box = 0
		endif
		if <colObjId> :IsInBail
			show_speech_box = 0
		endif
		if <colObjId> :DoingTrick
			show_speech_box = 0
		endif
		if SkaterCurrentScorePotGreaterThan \{0}
			show_speech_box = 0
		endif
		if GotParam \{hide_in_goals}
			if GMan_HasActiveGoals
				<show_speech_box> = 0
			endif
		endif
		if (<show_speech_box> = 1)
			if GotParam \{dont_allow_pause}
				kill_start_key_binding
			endif
			<ped_id> :Obj_SetOuterRadius <inner_radius>
			<set_script> event = ObjectOutOfRadius Scr = ped_speech_refuse object = <ped_id> params = <...>
			if NOT GotParam \{accept_text}
				if NOT GotParam \{display_name}
					<display_name> = 'Ped'
				endif
				FormatText TextName = accept_text '%s: \\me to talk.' s = <display_name>
			endif
			if ObjectExists \{id = ped_speech_dialog}
				DestroyScreenElement \{id = ped_speech_dialog}
			endif
			create_speech_box {
				anchor_id = ped_speech_dialog
				text = <accept_text>
				no_pad_choose
				no_pad_start
				pad_option_script = ped_speech_accept
				pad_option_params = <...>
				pos = (320.0, 400.0)
				z_priority = 5
			}
			ped_speech_dialog :Obj_SpawnScriptLater ped_speech_die_with_trigger params = {ped_id = <ped_id>}
		else
			<set_script> event = AnyObjectInRadius Scr = <set_script_scr> object = <ped_id> params = <...>
		endif
	endif
endscript

script ped_speech_accept 
	if <colObjId> :IsInBail
		return
	endif
	if <colObjId> :DoingTrick
		return
	endif
	speech_box_exit
	if NOT ObjectExists id = <ped_id>
		return
	endif
	Debounce \{x
		time = 0.5}
	if <colObjId> :OnGround
		if NOT SkaterCurrentScorePotGreaterThan \{0}
			Wait \{5
				frame}
			if <colObjId> :OnGround
				ped_speech_accept2 <...>
			else
				if NOT <colObjId> :RightPressed
					if NOT <colObjId> :LeftPressed
						if NOT <colObjId> :UpPressed
							if NOT <colObjId> :DownPressed
								ped_speech_accept2 <...>
							endif
						endif
					endif
				endif
			endif
		endif
	else
		if NOT <colObjId> :RightPressed
			if NOT <colObjId> :LeftPressed
				if NOT <colObjId> :UpPressed
					if NOT <colObjId> :DownPressed
						ped_speech_accept2 <...>
					endif
				endif
			endif
		endif
	endif
endscript

script ped_speech_accept2 
	if NOT GotParam \{dont_deactivate_goals}
		if NOT GameModeEquals \{Is_SingleSession}
			if NOT GameModeEquals \{is_classic}
				GMan_DeactivateAllGoals
			endif
		endif
	endif
	ClearEventHandler \{AnyObjectInRadius}
	if ScreenElementExists \{id = ped_speech_dialog}
		DestroyScreenElement \{id = ped_speech_dialog}
	endif
	if GotParam \{activation_script}
		<colObjId> :Obj_SpawnScriptLater <activation_script> params = {ped_id = <ped_id> <activation_script_params>}
	endif
	if GotParam \{text}
		create_speech_box <...> no_pad_start
	endif
endscript

script ped_speech_refuse 
	if GotParam \{intId}
		if GotParam \{outIntId}
			if NOT (<outIntId> = <intId>)
				return
			endif
		endif
	endif
	if GotParam \{hint_text}
		ped_utils_hint_dialog_refuse <...>
	endif
	ClearEventHandler \{ObjectOutOfRadius}
	speech_box_exit \{anchor_id = ped_speech_dialog}
	ped_speech_reset <...>
	if GotParam \{dont_allow_pause}
		restore_start_key_binding
	endif
endscript

script ped_speech_reset 
	if GotParam \{outer_radius_script}
		<outer_radius_script> <outer_radius_params>
	endif
	if NOT GotParam \{no_repeat}
		setup_ped_speech <...>
	endif
endscript

script ped_speech_exit 
	unpauseskaters
	speech_box_exit
endscript

script ped_speech_die_with_trigger 
	if NOT GotParam \{ped_id}
		return
	endif
	begin
	if NOT IsCreated <ped_id>
		LaunchEvent \{type = speech_box_destroyed}
		Die
		return
	endif
	WaitOneGameFrame
	repeat
endscript

script script_assert 

	ScriptAssert <...>
endscript

script nullscript 
endscript

script DumpMetrics 
	GetMetrics



endscript
dummy_metrics_struct = {
	mainscene = 0
	skyscene = 0
	metrics = 0
	Sectors = 0
	ColSectors = 0
	Verts = 0
	BasePolys = 0
	TextureMemory = 0
}

script Restore_skater_camera 
endscript

script GetSkaterCam 
	camera_object = skatercam0
	if InSplitScreenGame
		if IsObjectScript
			Obj_GetID
			if NOT ChecksumEquals a = <ObjID> b = 0
				camera_object = skatercam1
			endif
		endif
	endif
	return skatercam = <camera_object>
endscript

script SetSkaterCamOverride 
	GetSkaterCam
	<skatercam> :SC_SetSkaterCamOverride <...>
endscript

script ClearSkaterCamOverride 
	GetSkaterCam
	<skatercam> :SC_ClearSkaterCamOverride <...>
endscript

script empty_script 
endscript

script restore_start_key_binding 

	SetScreenElementProps \{id = root_window
		event_handlers = [
			{
				pad_start
				gh3_start_pressed
			}
		]
		replace_handlers}
endscript

script kill_start_key_binding 

	SetScreenElementProps \{id = root_window
		event_handlers = [
			{
				pad_start
				null_script
			}
		]
		replace_handlers}
	if ($enable_view_goals_select_shortcut = 1)
		SetScreenElementProps \{id = root_window
			event_handlers = [
				{
					pad_select
					null_script
				}
			]
			replace_handlers}
	endif
endscript

script BlockPendingPakManLoads \{map = all
		block_scripts = 0
		noparse = 0}
	if (<block_scripts> = 1)
		PendingPakManLoads map = <map> block_scripts = 1 noparse = <noparse>
		if GotParam \{loaderror}
			return \{false}
		endif
		return \{true}
	endif
	begin
	if NOT (PendingPakManLoads map = <map> noparse = <noparse>)
		break
	endif
	WaitOneGameFrame
	repeat
	if GotParam \{loaderror}
		return \{false}
	endif
	return \{true}
endscript

script SetPakManCurrentBlock \{block_scripts = 0
		noparse = 0}
	SetPakManCurrent map = <map> pak = <pak> pakname = <pakname>
	if NOT BlockPendingPakManLoads map = <map> block_scripts = <block_scripts> noparse = <noparse>
		return \{false}
	endif
	GetPakManCurrentName \{map = zones}
	if GotParam \{pakname}
		FormatText checksumname = zone_setup '%s_setup' s = <pakname>
		if ScriptExists <zone_setup>
			<zone_setup>
		endif
	endif
	set_hidebytype
	if ChecksumEquals a = <map> b = zones
		LightShow_SetVenueTweakParams zone = <pak>
	endif
	return \{true}
endscript

script RefreshPakManCurrent 
	SetPakManCurrentBlock map = <map> pak = <pak> pakname = <pakname>
endscript

script Zones_PakMan_Init 

	zone_name = <pak_name>
	zone_string_name = <pak_string_name>
	FormatText checksumname = sfx_zone_name '%z_sfx' z = <zone_string_name>
	FormatText checksumname = gfx_zone_name '%z_gfx' z = <zone_string_name>
	FormatText checksumname = lfx_zone_name '%z_lfx' z = <zone_string_name>
	FormatText checksumname = mfx_zone_name '%z_mfx' z = <zone_string_name>
	FormatText checksumname = array_name '%z_NodeArray' z = <zone_string_name>
	FormatText checksumname = sfx_array_name '%z_SFX_NodeArray' z = <zone_string_name>
	FormatText checksumname = gfx_array_name '%z_GFX_NodeArray' z = <zone_string_name>
	FormatText checksumname = lfx_array_name '%z_LFX_NodeArray' z = <zone_string_name>
	FormatText checksumname = mfx_array_name '%z_MFX_NodeArray' z = <zone_string_name>
	zone_init <...>
	FormatText checksumname = script_zone_init '%z_init' z = <zone_string_name>
	FormatText checksumname = script_zone_sfx_init '%z_sfx_init' z = <zone_string_name>
	FormatText checksumname = script_zone_gfx_init '%z_gfx_init' z = <zone_string_name>
	FormatText checksumname = script_zone_lfx_init '%z_lfx_init' z = <zone_string_name>
	FormatText checksumname = script_zone_mfx_init '%z_mfx_init' z = <zone_string_name>
	if ScriptExists <script_zone_init>
		<script_zone_init>
	endif
	if ScriptExists <script_zone_sfx_init>
		<script_zone_sfx_init>
	endif
	if ScriptExists <script_zone_gfx_init>
		<script_zone_gfx_init>
	endif
	if ScriptExists <script_zone_lfx_init>
		<script_zone_lfx_init>
	endif
	if ScriptExists <script_zone_mfx_init>
		<script_zone_mfx_init>
	endif
	UpdatePakManVisibility \{map = zones}

endscript

script Zones_PakMan_DeInit 

	zone_name = <pak_name>
	zone_string_name = <pak_string_name>
	FormatText checksumname = sfx_zone_name '%z_sfx' z = <zone_string_name>
	FormatText checksumname = gfx_zone_name '%z_gfx' z = <zone_string_name>
	FormatText checksumname = lfx_zone_name '%z_lfx' z = <zone_string_name>
	FormatText checksumname = mfx_zone_name '%z_mfx' z = <zone_string_name>
	FormatText checksumname = array_name '%z_NodeArray' z = <zone_string_name>
	FormatText checksumname = sfx_array_name '%z_SFX_NodeArray' z = <zone_string_name>
	FormatText checksumname = gfx_array_name '%z_GFX_NodeArray' z = <zone_string_name>
	FormatText checksumname = lfx_array_name '%z_LFX_NodeArray' z = <zone_string_name>
	FormatText checksumname = mfx_array_name '%z_MFX_NodeArray' z = <zone_string_name>
	zone_deinit <...>
	FormatText checksumname = script_zone_deinit '%z_deinit' z = <zone_string_name>
	FormatText checksumname = script_zone_sfx_deinit '%z_sfx_deinit' z = <zone_string_name>
	FormatText checksumname = script_zone_gfx_deinit '%z_gfx_deinit' z = <zone_string_name>
	FormatText checksumname = script_zone_lfx_deinit '%z_lfx_deinit' z = <zone_string_name>
	FormatText checksumname = script_zone_mfx_deinit '%z_mfx_deinit' z = <zone_string_name>
	if ScriptExists <script_zone_deinit>
		<script_zone_deinit>
	endif
	if ScriptExists <script_zone_sfx_deinit>
		<script_zone_sfx_deinit>
	endif
	if ScriptExists <script_zone_gfx_deinit>
		<script_zone_gfx_deinit>
	endif
	if ScriptExists <script_zone_lfx_deinit>
		<script_zone_lfx_deinit>
	endif
	if ScriptExists <script_zone_mfx_deinit>
		<script_zone_mfx_deinit>
	endif
	DestroyParticlesByGroupID \{groupID = zoneparticles}
	DestroyZoneEntities zone_name = <zone_name> zone_string_name = <zone_string_name>
	UpdatePakManVisibility \{map = zones}

endscript
