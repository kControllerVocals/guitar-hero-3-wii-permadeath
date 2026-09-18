
script Check_Alt_Acc_Anims \{name = Guitarist
		desc_id = Guitarist_Judy_Outfit1_Style1}
	ExtendCRC <name> '_Info' out = character_struct
	get_musician_body_size
	index = 0
	begin
	get_musician_body_struct index = <index>
	if ((<info_struct>.desc_id) = <desc_id>)
		if StructureContains Structure = <info_struct> alt_acc_anims
			change structurename = <character_struct> outfit = 2
		endif
		break
	endif
	index = (<index> + 1)
	repeat <array_size>
endscript

script create_band_member \{name = Guitarist
		lightgroup = Band
		async = 0
		animpak = 1}
	create_band_member_wait_for_lock

	FormatText checksumname = bandmember_body_pak '%s_%p_pak_file' s = ($character_pak_crc_to_text.<name>) p = ($character_pak_crc_to_text.Body)
	FormatText checksumname = bandmember_anim_pak '%s_%p_pak_file' s = ($character_pak_crc_to_text.<name>) p = ($character_pak_crc_to_text.Anim)
	FormatText checksumname = bandmember_instrument_pak '%s_%p_pak_file' s = ($character_pak_crc_to_text.<name>) p = ($character_pak_crc_to_text.instrument)
	pos = (0.0, 0.0, 0.0)
	dir = (0.0, 0.0, 1.0)
	if GotParam \{start_node}
		if DoesWayPointExist name = <start_node>
			GetWaypointPos name = <start_node>
			GetWaypointDir name = <start_node>
		endif
	endif
	if CompositeObjectExists <name>
		if GotParam \{useOldPos}
			<name> :Obj_GetPosition
			<name> :Obj_GetOrientation
			dir = ((1.0, 0.0, 0.0) * <x> + (0.0, 1.0, 0.0) * <y> + (0.0, 0.0, 1.0) * <z>)
		endif
		<name> :Die
	endif
	unload_musician_pak_file desc_id = ($<bandmember_body_pak>) async = <async> type = Body
	unload_musician_pak_file desc_id = ($<bandmember_anim_pak>) async = <async> type = Anim
	unload_musician_pak_file desc_id = ($<bandmember_instrument_pak>) async = <async> type = instrument
	change globalname = <bandmember_body_pak> newvalue = no_pak_id
	change globalname = <bandmember_anim_pak> newvalue = no_pak_id
	change globalname = <bandmember_instrument_pak> newvalue = no_pak_id
	if (<name> = Guitarist || <name> = bassist)
		startslot = 0
	else
		startslot = 2
	endif
	body_asset_context = 0
	if StructureContains Structure = <profile> musician_body
		if NOT load_musician_pak_file profile = <profile> async = <async> type = Body
			create_band_member_unlock
			return \{false}
		endif
		change globalname = <bandmember_body_pak> newvalue = <filename_crc>
		Check_Alt_Acc_Anims name = <name> desc_id = ((<profile>.musician_body).desc_id)
		body_asset_context = <assetcontext>
		if (<animpak> = 1)
			if NOT load_musician_pak_file profile = <profile> async = <async> type = Anim startslot = <startslot>
				create_band_member_unlock
				return \{false}
			endif
			change globalname = <bandmember_anim_pak> newvalue = <filename_crc>
		endif
	endif
	if StructureContains Structure = <profile> musician_instrument
		if NOT load_musician_pak_file profile = <profile> async = <async> type = instrument
			create_band_member_unlock
			return \{false}
		endif
		change globalname = <bandmember_instrument_pak> newvalue = <filename_crc>
	endif
	dump_pak_info
	GetPakManCurrent \{map = zones}
	switch <pak>
		case z_training
		case z_viewer
		lightgroup = none
		default
		if (<name> = Guitarist)
			lightgroup = Alt_Band
		endif
	endswitch
	if ($soundcheck_in_store = 1)
		<lightgroup> = Guitar_center_band
	endif
	skeleton_name = (<profile>.skeleton)
	ragdoll_name = (<profile>.ragdoll)
	collision_group = (<profile>.ragdoll_collision_group)
	if StructureContains Structure = <profile> outfit
		if (<profile>.outfit = 2)
			skeleton_name = (<profile>.skeleton2)
			ragdoll_name = (<profile>.ragdoll2)
			collision_group = (<profile>.ragdoll_collision_group2)
		endif
	endif
	if StructureContains Structure = <profile> ik_params
		ik_params = (<profile>.ik_params)
	else
		ik_params = Hero_Ik_params
	endif
	if GotParam \{body_id}
		get_pak_filename desc_id = <body_id> type = Body
		get_musician_body_struct index = <pak_index>
	endif
	if StructureContains Structure = <info_struct> shadow_volumes
		shadow_models = (<info_struct>.shadow_volumes)
		CreateCompositeObject {
			Components = [
				{
					Component = ragdoll
					initialize_empty = false
					SkeletonName = <skeleton_name>
					ragdollName = <ragdoll_name>
					RagdollCollisionGroup = $<collision_group>
				}
				{
					Component = SetDisplayMatrix
				}
				{
					Component = AnimTree
					AnimEventTableName = ped_animevents
					SkeletonName = <skeleton_name>
				}
				{
					Component = skeleton
					SkeletonName = <skeleton_name>
				}
				{
					Component = Model
					lightgroup = <lightgroup>
				}
				{
					Component = motion
				}
				{
					Component = shadow
					ShadowType = volume
					ShadowVolumeModels = <shadow_models>
				}
			]
			params = {
				name = <name>
				pos = <pos>
				<profile>
				object_type = bandmember
				profilebudget = 800
			}
		}
	else
		CreateCompositeObject {
			Components = [
				{
					Component = ragdoll
					initialize_empty = false
					SkeletonName = <skeleton_name>
					ragdollName = <ragdoll_name>
					RagdollCollisionGroup = $<collision_group>
				}
				{
					Component = SetDisplayMatrix
				}
				{
					Component = AnimTree
					AnimEventTableName = ped_animevents
					SkeletonName = <skeleton_name>
				}
				{
					Component = skeleton
					SkeletonName = <skeleton_name>
				}
				{
					Component = Model
					lightgroup = <lightgroup>
				}
				{
					Component = motion
				}
			]
			params = {
				name = <name>
				pos = <pos>
				<profile>
				object_type = bandmember
				profilebudget = 800
			}
		}
	endif
	<name> :Obj_SetOrientation dir = <dir>
	<name> :Obj_InitModelFromProfile struct = <profile> buildScript = create_ped_model_from_appearance params = {lightgroup = <lightgroup>}
	switch (<name>)
		case vocalist
		desired_tree = vocalist_static_tree
		case Drummer
		desired_tree = drummer_static_tree
		default
		desired_tree = guitarist_static_tree
	endswitch
	<name> :Anim_InitTree {
		Tree = $<desired_tree>
		AnimEventTableName = ped_animevents
		NodeIdDeclaration = [
			Base
			Body
			BodyTimer
			Acc
			AccTimer
			StrumTimer
			FretTimer
			FingerTimer
			FacialTimer
			Ik
			Standard_Branch
			Turn_Branch
			LeftArmPartial
			LeftHandPartial
			RightArmPartial
			DrummerLeftArm
			DrummerRightArm
			leftarm_timer
			rightarm_timer
			LeftArm
			LeftHand
			RightArm
			Face
			cymbal1
			cymbal2
			cymbal3
			cymbal4
			CymbalTimer1
			CymbalTimer2
			CymbalTimer3
			CymbalTimer4
			leftfoot
			leftfoot_timer
			rightfoot
			rightfoot_timer
			BodyTwist
			bodytwist_timer
			bodytwist_branch
			arm_branch
			left_arm_branch
			right_arm_branch
		]
		params = {
			ik_params = <ik_params>
		}
	}
	create_band_member_unlock
	return \{true}
endscript

script preload_band_member \{name = Guitarist
		async = 0}
	create_band_member_wait_for_lock
	filename_crc = none
	instrument_crc = none
	create_guitarist_profile <...>
	if (<found> = 1)
		if StructureContains Structure = <profile> musician_instrument
			if NOT load_musician_pak_file profile = <profile> async = <async> type = instrument
				create_band_member_unlock
				return \{false}
			endif
			instrument_crc = <filename_crc>
		endif
		if StructureContains Structure = <profile> musician_body
			if NOT load_musician_pak_file profile = <profile> async = <async> type = Body
				create_band_member_unlock
				return \{false}
			endif
		endif
	endif
	create_band_member_unlock
	return filename_crc = <filename_crc> instrument_crc = <instrument_crc> true
endscript

script preload_band_member_finish \{name = Guitarist
		async = 0}
	create_band_member_wait_for_lock
	if NOT (<instrument_crc> = none)
		unload_musician_pak_file desc_id = <instrument_crc> async = <async> type = instrument
	endif
	if NOT (<filename_crc> = none)
		unload_musician_pak_file desc_id = <filename_crc> async = <async> type = Body
	endif
	create_band_member_unlock
endscript
create_band_member_lock_queue = 0
create_band_member_lock = 0

script create_band_member_unlock 
	change \{create_band_member_lock = 0}
endscript

script create_band_member_wait_for_lock 
	begin
	if ($create_band_member_lock_queue = 0)
		break
	endif
	WaitOneGameFrame
	repeat
	change \{create_band_member_lock_queue = 1}
	begin
	if ($create_band_member_lock = 0)
		break
	endif
	WaitOneGameFrame
	repeat
	change \{create_band_member_lock_queue = 0}
	change \{create_band_member_lock = 1}
endscript

script destroy_band 
	destroy_band_member \{name = Guitarist}
	destroy_band_member \{name = bassist}
	destroy_band_member \{name = Drummer}
	destroy_band_member \{name = vocalist}
	if GotParam \{unload_paks}
		force_unload_all_character_paks
	endif
endscript

script destroy_band_member 
	if CompositeObjectExists name = <name>
		<name> :Die
		FormatText checksumname = bandmember_body_pak '%s_%p_pak_file' s = ($character_pak_crc_to_text.<name>) p = ($character_pak_crc_to_text.Body)
		FormatText checksumname = bandmember_anim_pak '%s_%p_pak_file' s = ($character_pak_crc_to_text.<name>) p = ($character_pak_crc_to_text.Anim)
		FormatText checksumname = bandmember_instrument_pak '%s_%p_pak_file' s = ($character_pak_crc_to_text.<name>) p = ($character_pak_crc_to_text.instrument)
		unload_musician_pak_file desc_id = ($<bandmember_body_pak>) async = <async> type = Body
		unload_musician_pak_file desc_id = ($<bandmember_anim_pak>) async = <async> type = Anim
		unload_musician_pak_file desc_id = ($<bandmember_instrument_pak>) async = <async> type = instrument
		change globalname = <bandmember_body_pak> newvalue = no_pak_id
		change globalname = <bandmember_anim_pak> newvalue = no_pak_id
		change globalname = <bandmember_instrument_pak> newvalue = no_pak_id
	endif
endscript

script kill_character_scripts 

	if CompositeObjectExists \{name = Guitarist}
		Guitarist :Obj_SwitchScript \{EmptyScript}
	endif
	if CompositeObjectExists \{name = bassist}
		bassist :Obj_SwitchScript \{EmptyScript}
	endif
	if CompositeObjectExists \{name = vocalist}
		vocalist :Obj_SwitchScript \{EmptyScript}
	endif
	if CompositeObjectExists \{name = Drummer}
		Drummer :Obj_SwitchScript \{EmptyScript}
	endif
endscript

script EmptyScript 
endscript

script hero_pause_anim 
	if Anim_AnimNodeExists \{id = BodyTimer}
		Anim_Command \{target = BodyTimer
			command = Timer_SetSpeed
			params = {
				Speed = 0.0
			}}
	endif
endscript

script hero_unpause_anim 
	if Anim_AnimNodeExists \{id = BodyTimer}
		Anim_Command \{target = BodyTimer
			command = Timer_SetSpeed
			params = {
				Speed = 1.0
			}}
	endif
endscript

script hero_play_turn_anim \{BlendDuration = 0.2
		turnBlend = 1.0}
	Anim_Command {
		target = Body
		command = DegenerateBlend_AddBranch
		params = {
			Tree = $Hero_turning_tree
			BlendDuration = <BlendDuration>
			params = {
				timer_type = Play
				anim_name = <Idleanim>
				second_anim_name = <turnAnim>
				second_anim_blend = <turnBlend>
			}
		}
	}
endscript

script hero_play_blended_anim \{BlendDuration = 0.2
		blend = 1.0}
	if GotParam \{Cycle}
		timer_type = Cycle
	else
		timer_type = Play
	endif
	Anim_Command {
		target = Body
		command = DegenerateBlend_AddBranch
		params = {
			Tree = $Hero_turning_tree
			BlendDuration = <BlendDuration>
			params = {
				timer_type = <timer_type>
				anim_name = <first_anim>
				second_anim_name = <second_anim>
				second_anim_blend = <blend>
			}
		}
	}
endscript

script hero_play_drum_anim \{BlendDuration = $drum_blend_time}
	if Anim_AnimNodeExists \{id = cymbal1}
		Anim_Command {
			target = Body
			command = DegenerateBlend_AddBranch
			params = {
				Tree = $hero_cymbal_branch
				BlendDuration = <BlendDuration>
				params = {
					fret_anim = <Anim>
				}
			}
		}
	endif
endscript

script hero_cymbal_anim \{BlendDuration = $fret_blend_time}
	if Anim_AnimNodeExists \{id = cymbal1}
		Anim_Command {
			target = cymbal1
			command = DegenerateBlend_AddBranch
			params = {
				Tree = $hero_cymbal_branch
				BlendDuration = <BlendDuration>
				params = {
					fret_anim = <Anim>
				}
			}
		}
	endif
endscript

script hero_play_facial_anim \{BlendDuration = 0.0}
	if Anim_AnimNodeExists \{id = Face}
		Anim_Command {
			target = Face
			command = DegenerateBlend_AddBranch
			params = {
				Tree = $hero_face_branch
				BlendDuration = <BlendDuration>
				params = {
					facial_anim = <Anim>
				}
			}
		}
	endif
endscript

script hero_wait_until_anim_finished \{Timer = BodyTimer}
	begin
	if hero_anim_complete Timer = <Timer>
		break
	endif
	WaitOneGameFrame
	repeat
endscript

script hero_wait_until_anim_near_end \{Timer = BodyTimer
		time_from_end = 0.2}
	begin
	if hero_anim_near_end Timer = <Timer> time_from_end = <time_from_end>
		break
	endif
	WaitOneGameFrame
	repeat
endscript

script hero_anim_near_end \{Timer = BodyTimer}
	if NOT Anim_AnimNodeExists id = <Timer>
		return \{true}
	else
		if Anim_Command target = <Timer> command = Timer_Wait params = {SecondsFromEnd = <time_from_end>}
			return \{true}
		else
			return \{false}
		endif
	endif
endscript

script hero_disable_arms \{blend_time = 0.25}
	if Anim_AnimNodeExists \{id = arm_branch}
		if (<blend_time> = 0.0)
			Anim_Command \{target = arm_branch
				command = Modulate_SetStrength
				params = {
					strength = 0.0
					BlendDuration = 2.0
				}}
		else
			Anim_Command {
				target = arm_branch
				command = Modulate_StartBlend
				params = {
					blendcurve = [0.0 1.0]
					BlendDuration = <blend_time>
				}
			}
		endif
	endif
	if Anim_AnimNodeExists \{id = Ik}
		Obj_GetID
		if (<ObjID> = Drummer)
			Anim_Command {
				target = Ik
				command = IK_SetChainStrength
				params = {
					strength = 0.0
					BlendDuration = <blend_time>
					chain = Bone_IK_Hand_Slave_R
				}
			}
			Anim_Command {
				target = Ik
				command = IK_SetChainStrength
				params = {
					strength = 0.0
					BlendDuration = <blend_time>
					chain = Bone_IK_Hand_Slave_L
				}
			}
		else
			Anim_Command {
				target = Ik
				command = IK_SetChainStrength
				params = {
					strength = 0.0
					BlendDuration = <blend_time>
					chain = Bone_IK_Hand_Guitar_R
				}
			}
			Anim_Command {
				target = Ik
				command = IK_SetChainStrength
				params = {
					strength = 0.0
					BlendDuration = <blend_time>
					chain = Bone_IK_Hand_Guitar_L
				}
			}
		endif
	endif
endscript

script hero_enable_arms \{blend_time = 0.25}
	if Anim_AnimNodeExists \{id = arm_branch}
		Anim_Command {
			target = arm_branch
			command = Modulate_StartBlend
			params = {
				blendcurve = [1.0 0.0]
				BlendDuration = <blend_time>
			}
		}
	endif
	if Anim_AnimNodeExists \{id = Ik}
		Obj_GetID
		if (<ObjID> = Drummer)
			Anim_Command {
				target = Ik
				command = IK_SetChainStrength
				params = {
					strength = 1.0
					BlendDuration = <blend_time>
					chain = Bone_IK_Hand_Slave_R
				}
			}
			Anim_Command {
				target = Ik
				command = IK_SetChainStrength
				params = {
					strength = 1.0
					BlendDuration = <blend_time>
					chain = Bone_IK_Hand_Slave_L
				}
			}
		else
			Anim_Command {
				target = Ik
				command = IK_SetChainStrength
				params = {
					strength = 1.0
					BlendDuration = <blend_time>
					chain = Bone_IK_Hand_Guitar_R
				}
			}
			Anim_Command {
				target = Ik
				command = IK_SetChainStrength
				params = {
					strength = 1.0
					BlendDuration = <blend_time>
					chain = Bone_IK_Hand_Guitar_L
				}
			}
		endif
	endif
endscript

script hero_toggle_arms \{num_arms = 2
		prev_num_arms = 0
		blend_time = 0.25}
	disable_left_arm = false
	enable_left_arm = false
	disable_right_arm = false
	enable_right_arm = false
	if (<num_arms> = 0)
		if (<prev_num_arms> = 1)
			disable_right_arm = true
		elseif (<prev_num_arms> = 2)
			disable_left_arm = true
			disable_right_arm = true
		endif
	elseif (<num_arms> = 1)
		if (<prev_num_arms> = 2)
			disable_right_arm = true
			enable_left_arm = true
		endif
	elseif (<num_arms> = 2)
		if (<prev_num_arms> = 0)
			enable_left_arm = true
			enable_right_arm = true
		elseif (<prev_num_arms> = 1)
			enable_right_arm = true
		endif
	endif
	Obj_GetID
	if (<ObjID> = Drummer)
		left_hand_bone = Bone_IK_Hand_Slave_L
		right_hand_bone = Bone_IK_Hand_Slave_R
	else
		left_hand_bone = Bone_IK_Hand_Guitar_L
		right_hand_bone = Bone_IK_Hand_Guitar_R
	endif
	if (<disable_left_arm> = true)

		if Anim_AnimNodeExists \{id = left_arm_branch}
			if (<blend_time> = 0.0)
				Anim_Command \{target = left_arm_branch
					command = Modulate_SetStrength
					params = {
						strength = 0.0
						BlendDuration = 2.0
					}}
			else
				Anim_Command {
					target = left_arm_branch
					command = Modulate_StartBlend
					params = {
						blendcurve = [0.0 1.0]
						BlendDuration = <blend_time>
					}
				}
			endif
		else

		endif
		if Anim_AnimNodeExists \{id = Ik}
			Anim_Command {
				target = Ik
				command = IK_SetChainStrength
				params = {
					strength = 0.0
					BlendDuration = <blend_time>
					chain = <left_hand_bone>
				}
			}
		else

		endif
	endif
	if (<disable_right_arm> = true)
		if Anim_AnimNodeExists \{id = right_arm_branch}
			if (<blend_time> = 0.0)
				Anim_Command \{target = right_arm_branch
					command = Modulate_SetStrength
					params = {
						strength = 0.0
						BlendDuration = 2.0
					}}
			else
				Anim_Command {
					target = right_arm_branch
					command = Modulate_StartBlend
					params = {
						blendcurve = [0.0 1.0]
						BlendDuration = <blend_time>
					}
				}
			endif
		endif
		if Anim_AnimNodeExists \{id = Ik}
			Anim_Command {
				target = Ik
				command = IK_SetChainStrength
				params = {
					strength = 0.0
					BlendDuration = <blend_time>
					chain = <right_hand_bone>
				}
			}
		endif
	endif
	if (<enable_left_arm> = true)
		if Anim_AnimNodeExists \{id = left_arm_branch}
			Anim_Command {
				target = left_arm_branch
				command = Modulate_StartBlend
				params = {
					blendcurve = [1.0 0.0]
					BlendDuration = <blend_time>
				}
			}
		endif
		if Anim_AnimNodeExists \{id = Ik}
			Anim_Command {
				target = Ik
				command = IK_SetChainStrength
				params = {
					strength = 1.0
					BlendDuration = <blend_time>
					chain = <left_hand_bone>
				}
			}
		endif
	endif
	if (<enable_right_arm> = true)
		if Anim_AnimNodeExists \{id = right_arm_branch}
			Anim_Command {
				target = right_arm_branch
				command = Modulate_StartBlend
				params = {
					blendcurve = [1.0 0.0]
					BlendDuration = <blend_time>
				}
			}
		endif
		if Anim_AnimNodeExists \{id = Ik}
			Anim_Command {
				target = Ik
				command = IK_SetChainStrength
				params = {
					strength = 1.0
					BlendDuration = <blend_time>
					chain = <right_hand_bone>
				}
			}
		endif
	endif
endscript

script drummer_twist 
	if Anim_AnimNodeExists \{id = bodytwist_branch}
		Anim_Command {
			target = bodytwist_branch
			command = Modulate_SetStrength
			params = {
				strength = <strength>
			}
		}
	endif
endscript
generic_static_tree = {
	type = DegenerateBlend
	id = Body
}
guitarist_static_tree = {
	type = Ik
	two_bone_chains = ik_params
	id = Ik
	[
		{
			type = PartialSwitch
			state = on
			[
				{
					type = DegenerateBlend
					id = Face
				}
				{
					type = applydifference
					id = LeftHandPartial
					[
						{
							$hero_arm_branch
						}
						{
							type = PartialSwitch
							state = on
							[
								{
									type = DegenerateBlend
									id = Acc
								}
								{
									type = DegenerateBlend
									id = Body
								}
							]
						}
					]
				}
			]
		}
	]
}
hero_arm_branch = {
	type = modulate
	strength = 1.0
	id = arm_branch
	[
		{
			type = Add
			[
				{
					type = modulate
					strength = 1.0
					id = left_arm_branch
					[
						{
							type = Add
							[
								{
									type = DegenerateBlend
									id = LeftArm
								}
								{
									type = DegenerateBlend
									id = LeftHand
								}
							]
						}
					]
				}
				{
					type = modulate
					strength = 1.0
					id = right_arm_branch
					[
						{
							type = DegenerateBlend
							id = RightArm
						}
					]
				}
			]
		}
	]
}
hero_body_branch = {
	type = timer_type
	id = BodyTimer
	Anim = anim_name
	Speed = Speed
	anim_events = on
	[
		{
			type = source_type
			Anim = anim_name
		}
	]
}
hero_accessory_branch = {
	type = timer_type
	id = AccTimer
	Anim = anim_name
	Speed = Speed
	[
		{
			type = Source
			Anim = anim_name
		}
	]
}
hero_strumming_branch = {
	type = Play
	id = StrumTimer
	Anim = strum_name
	[
		{
			type = Source
			Anim = strum_name
		}
	]
}
hero_fret_branch = {
	type = Play
	id = FretTimer
	Anim = fret_anim
	[
		{
			type = Source
			Anim = fret_anim
		}
	]
}
hero_finger_branch = {
	type = Play
	id = FingerTimer
	Anim = finger_anim
	[
		{
			type = Source
			Anim = finger_anim
		}
	]
}
hero_face_branch = {
	type = Play
	id = FacialTimer
	Anim = facial_anim
	[
		{
			type = Source
			Anim = facial_anim
		}
	]
}
hero_drumming_branch = {
	type = timer_type
	id = timer_id
	Anim = anim_name
	Speed = Speed
	[
		{
			type = Source
			Anim = anim_name
		}
	]
}
drummer_twist_branch = {
	type = Play
	id = bodytwist_timer
	Anim = anim_name
	[
		{
			type = modulate
			strength = 1.0
			id = bodytwist_branch
			[
				{
					type = Source
					Anim = anim_name
				}
			]
		}
	]
}
Hero_turning_tree = {
	type = timer_type
	id = BodyTimer
	Anim = anim_name
	[
		{
			type = blend
			blend_factor = second_anim_blend
			[
				{
					type = MotionExtractedSource
					Anim = anim_name
				}
				{
					type = MotionExtractedSource
					Anim = second_anim_name
				}
			]
		}
	]
}
vocalist_static_tree = {
	type = PartialSwitch
	state = on
	[
		{
			type = DegenerateBlend
			id = Face
		}
		{
			type = PartialSwitch
			state = on
			[
				{
					type = DegenerateBlend
					id = Acc
				}
				{
					type = DegenerateBlend
					id = Body
				}
			]
		}
	]
}
drummer_static_tree = {
	type = Ik
	two_bone_chains = drummer_IK_params
	id = Ik
	[
		{
			type = PartialSwitch
			state = on
			[
				{
					$drummer_cymbals_branch
				}
				{
					type = applydifference
					[
						{
							type = DegenerateBlend
							id = BodyTwist
						}
						{
							type = PartialSwitch
							state = on
							[
								{
									type = modulate
									strength = 1.0
									id = arm_branch
									[
										{
											type = Add
											[
												{
													type = Add
													[
														{
															type = DegenerateBlend
															id = DrummerLeftArm
														}
														{
															type = DegenerateBlend
															id = DrummerRightArm
														}
													]
												}
												{
													type = Add
													[
														{
															type = DegenerateBlend
															id = leftfoot
														}
														{
															type = DegenerateBlend
															id = rightfoot
														}
													]
												}
											]
										}
									]
								}
								{
									type = DegenerateBlend
									id = Body
								}
							]
						}
					]
				}
			]
		}
	]
}
hero_cymbal_branch = {
	type = Play
	id = cymbal_timer_id
	Anim = cymbal_anim
	[
		{
			type = Source
			Anim = cymbal_anim
		}
	]
}
drummer_cymbals_branch = {
	type = Add
	[
		{
			type = Add
			[
				{
					type = DegenerateBlend
					id = cymbal1
				}
				{
					type = DegenerateBlend
					id = cymbal2
				}
			]
		}
		{
			type = Add
			[
				{
					type = DegenerateBlend
					id = cymbal3
				}
				{
					type = DegenerateBlend
					id = cymbal4
				}
			]
		}
	]
}
Hero_Ik_params = [
	{
		bone0 = Bone_Bicep_R
		bone1 = Bone_Forearm_R
		bone2 = Bone_Palm_R
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Guitar_R
	}
	{
		bone0 = Bone_Bicep_L
		bone1 = Bone_Forearm_L
		bone2 = Bone_Palm_L
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Guitar_L
	}
]
Satan_Ik_params = [
	{
		bone0 = Bone_Bicep_R
		bone1 = Bone_Forearm_R
		bone2 = Bone_Palm_R
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Guitar_R
	}
	{
		bone0 = Bone_Bicep_L
		bone1 = Bone_Forearm_L
		bone2 = Bone_Palm_L
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Guitar_L
	}
]
singer_IK_Params = [
	{
		bone0 = Bone_Thigh_L
		bone1 = Bone_Knee_L
		bone2 = Bone_Ankle_L
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_L
	}
	{
		bone0 = Bone_Thigh_R
		bone1 = Bone_Knee_R
		bone2 = Bone_Ankle_R
		HingeAxis = (0.0, 0.0, 1.0)
		CosMaxHingeAngle = -0.98999995
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Foot_Slave_R
	}
]
drummer_IK_params = [
	{
		bone0 = Bone_Bicep_R
		bone1 = Bone_Forearm_R
		bone2 = Bone_Palm_R
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Slave_R
	}
	{
		bone0 = Bone_Bicep_L
		bone1 = Bone_Forearm_L
		bone2 = Bone_Palm_L
		HingeAxis = (0.0, 0.0, -1.0)
		CosMaxHingeAngle = -0.96999997
		CosMinHingeAngle = 0.96999997
		boneTarget = Bone_IK_Hand_Slave_L
	}
]
hero_ConstraintBones = [
	{
		type = Twistchild
		bone = Bone_Twist_Wrist_L
		target = Bone_Palm_L
		amount = 0.5
	}
	{
		type = Twistchild
		bone = Bone_Twist_Wrist_R
		target = Bone_Palm_R
		amount = 0.5
	}
	{
		type = Twist
		bone = Bone_Twist_Bicep_Mid_R
		target = Bone_Bicep_R
		amount = 0.5
	}
	{
		type = Twist
		bone = Bone_Twist_Bicep_Mid_L
		target = Bone_Bicep_L
		amount = 0.5
	}
	{
		type = Twist
		bone = Bone_Twist_Bicep_Top_R
		target = Bone_Bicep_R
		amount = 1.0
	}
	{
		type = Twist
		bone = Bone_Twist_Bicep_Top_L
		target = Bone_Bicep_L
		amount = 1.0
	}
	{
		type = Twist
		bone = Bone_Twist_Thigh_R
		target = Bone_Thigh_R
		amount = 0.5
	}
	{
		type = Twist
		bone = Bone_Twist_Thigh_L
		target = Bone_Thigh_L
		amount = 0.5
	}
	{
		type = Split
		bone = Bone_Split_Knee_R
		target = Bone_Knee_R
		amount = 0.5
	}
	{
		type = Split
		bone = Bone_Split_Knee_L
		target = Bone_Knee_L
		amount = 0.5
	}
	{
		type = SplitR
		bone = Bone_Split_Ass_R
		target = Bone_Twist_Thigh_R
		amount = 0.5
	}
	{
		type = SplitR
		bone = Bone_Split_Ass_L
		target = Bone_Twist_Thigh_L
		amount = 0.5
	}
	{
		type = Split
		bone = Bone_Split_Elbow_R
		target = Bone_Forearm_R
		amount = 0.5
	}
	{
		type = Split
		bone = Bone_Split_Elbow_L
		target = Bone_Forearm_L
		amount = 0.5
	}
]
