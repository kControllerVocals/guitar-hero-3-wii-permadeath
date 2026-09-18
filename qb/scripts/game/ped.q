ped_use_GELAI = 0
Ped_StaticAnimTree = {
	type = PartialSwitch
	id = PedBlendRoot
	[
		{
			type = DegenerateBlend
			id = PedFAMAnimParentNode
		}
		{
			type = DegenerateBlend
			id = PedMainAnimParentNode
		}
	]
}
Ped_StaticAnimTreeWithFace = {
	type = Ik
	[
		{
			type = applydifference
			id = PedWithFace
			[
				{
					type = DegenerateBlend
					id = Face
				}
				{
					type = PartialSwitch
					id = PedBlendRoot
					[
						{
							type = DegenerateBlend
							id = PedFAMAnimParentNode
						}
						{
							type = DegenerateBlend
							id = PedMainAnimParentNode
						}
					]
				}
			]
		}
	]
}
Ped_AnimBranch_Standard = {
	type = param_timer_type
	id = BodyTimer
	Speed = param_speed
	start = param_start
	Anim = param_anim
	anim_events = on
	[
		{
			id = BodySource
			type = Source
			Anim = param_anim
		}
	]
}
Ped_AnimBranch_LookAt = {
	id = LookAtController
	type = DifferenceLookAt
	params = param_lookat_params
	target = param_lookat_target
	[
		{
			$Ped_AnimBranch_Standard
		}
	]
}
Ped_AnimBranch_FAMStandard = {
	type = param_timer_type
	id = FamTimer
	Speed = param_speed
	start = param_start
	Anim = param_anim
	anim_events = on
	[
		{
			id = PedFAMAnimNode
			type = Source
			Anim = param_anim
		}
	]
}
Ped_AnimBranch_FAMEmpty = {
	type = Blank
}
Ped_AnimBranch_Flipped = {
	type = flip
	id = BodyFlip
	[
		{
			$Ped_AnimBranch_Standard
		}
	]
}
Ped_AnimBranch_Overlay = {
	type = param_timer_type
	id = BodyTimer
	Speed = param_speed
	start = param_start
	Anim = param_anim
	anim_events = on
	[
		{
			id = BodyOverlay
			type = Overlay
			Anim = param_overlay
			[
				{
					id = BodySource
					type = Source
					Anim = param_anim
				}
			]
		}
	]
}
GameObj_AnimTree = {
	type = DegenerateBlend
	id = Body
}
GameObj_RagdollAnimTree = {
	type = ragdoll
	[
		{
			type = DegenerateBlend
			id = Body
		}
	]
}
GameObj_StandardAnimBranch = {
	type = TimerType
	id = BodyTimer
	Anim = Anim
	anim_events = AnimEvents
	Speed = Speed
	start = start
	[
		{
			type = Source
			Anim = Anim
		}
	]
}

script Ped_InitStaticAnimTree \{Tree = $Ped_StaticAnimTree}
	Anim_UnInitTree
	Anim_InitTree Tree = <Tree> NodeIdDeclaration = [
		PedMainAnimParentNode
		PedFAMAnimParentNode
		PedBlendRoot
		FamTimer
		PedFAMAnimNode
		BodyTimer
		BodySource
		BodyOverlay
		LookAtController
		PedWithFace
		Face
		faceidle_timer
		face_timer
		face_source
	]
endscript

script Ped_AddDegenerateBlendBranch 
	Ped_Anim_Command \{command = DegenerateBlend_AddBranch
		params = {
			Tree = $Ped_AnimBranch_Standard
			params = {
				param_timer_type = Play
				param_anim = Ped_M_Idle1
			}
		}}
	Anim_UpdatePose
	Anim_Command \{command = DegenerateBlend_SetNextBlendDuration
		params = {
			0.0
		}}
endscript

script Ped_PlayAnim \{Anim = 0
		target = PedMainAnimParentNode
		Tree = $Ped_AnimBranch_Standard
		Source = BodySource
		Flipped = 0}
	if GotParam \{norestart}
		if Ped_Anim_Command target = <Source> command = Source_AnimEquals params = {<Anim>}
			return
		endif
	endif
	timer_type = Play
	if GotParam \{Cycle}
		timer_type = Cycle
	endif
	if GotParam \{Wobble}
		timer_type = Wobble
	endif
	if (<Flipped> = 1)
		<Tree> = Ped_AnimBranch_Flipped
	endif
	if GotParam \{PartialAnimOverlay}
		Ped_Anim_Command target = Ped_AnimBranch_Overlay command = DegenerateBlend_AddBranch params = {
			BlendDuration = <BlendPeriod>
			Tree = <Tree> params = {
				param_timer_type = <timer_type>
				param_anim = <Anim>
				param_overlay = <PartialAnimOverlay>
				param_speed = <Speed>
				param_start = <start>
			}
		}
	else
		Ped_Anim_Command target = <target> command = DegenerateBlend_AddBranch params = {
			BlendDuration = <BlendPeriod>
			Tree = <Tree> params = {
				param_timer_type = <timer_type>
				param_anim = <Anim>
				param_speed = <Speed>
				param_start = <start>
				param_lookat_params = <lookat_params>
				param_lookat_target = <lookat_target>
			}
		}
	endif
	if (DEBUG_PEDINFO = 1)
		SetTags LastAnim = <Anim>
	endif
endscript

script Ped_Anim_Command 
	Anim_Command <...>
	Obj_GetID
	GetSingleTag \{board_id}
	if GotParam \{board_id}
		if IsCreated <board_id>
			<board_id> :Anim_Command <...>
		endif
	endif
endscript

script Ped_WaitAnimFinished \{Timer = BodyTimer}
	Ped_Anim_Command target = <Timer> command = Timer_Wait
endscript

script Ped_WaitAnim 
	Ped_Anim_Command target = BodyTimer command = Timer_Wait params = {<...>}
endscript

script Ped_AnimComplete \{Timer = BodyTimer}
	if Anim_Command target = <Timer> command = Timer_IsAnimComplete
		return \{scriptresult = 1}
	else
		return \{scriptresult = 0}
	endif
endscript

script Ped_AnimEquals 
	if Anim_Command target = BodySource command = Source_AnimEquals params = {<...>}
		return \{1}
	endif
	return \{0}
endscript

script Ped_GetAnimDuration \{Timer = BodyTimer}
	Anim_Command target = <Timer> command = Timer_GetAnimDuration
	return <duration>
endscript

script Ped_SetAnimCycleMode 
	timer_type = Cycle
	if GotParam \{off}
		timer_type = Play
	endif
	Anim_Command \{target = BodySource
		command = Source_GetAnimName}
	Anim = <AnimName>
	Anim_Command \{target = BodyTimer
		command = Timer_GetFrameFactor}
	start = <framefactor>
	Anim_Command target = PedMainAnimParentNode command = DegenerateBlend_AddBranch params = {
		BlendDuration = <BlendPeriod>
		Tree = $Ped_AnimBranch_Standard params = {
			param_timer_type = <timer_type>
			param_anim = <Anim>
			param_speed = <Speed>
			param_start = <start>
		}
	}
endscript

script Ped_Flip 
endscript

script gameobj_init_animtree 
	if GotParam \{profile}
		AddParams <profile>
	endif
	if GotParam \{AnimTargets}
		Anim_InitTree {
			Tree = <Tree>
			DefaultCommandTarget = <DefaultCommandTarget>
			NodeIdDeclaration = <AnimTargets>
			params = <AnimTreeParams>
			AnimEventTableName = <AnimEventTableName>
		}
		Anim_Enable \{off}
	endif
endscript

script GameObj_PlayAnim \{target = Body
		Tree = $GameObj_StandardAnimBranch
		TimerType = Play
		Speed = 1.0
		start = 0.0
		AnimEvents = off
		BlendDuration = -1.0}
	if NOT GotParam \{Anim}
		Anim_GetDefaultAnimName
		Anim = <DefaultAnimName>
	endif
	Anim_Enable
	Anim_Command target = <target> command = DegenerateBlend_AddBranch params = {
		Tree = <Tree>
		BlendDuration = <BlendDuration>
		params = {
			Anim = <Anim>
			Speed = <Speed>
			TimerType = <TimerType>
			start = <start>
			AnimEvents = <AnimEvents>
		}
	}
endscript

script GameObj_WaitAnimFinished \{Timer = BodyTimer}
	Anim_Command target = <Timer> command = Timer_WaitAnimComplete
endscript

script GameObj_WaitAnim 
	Anim_Command target = BodyTimer command = Timer_Wait params = {<...>}
endscript

script GameObj_AnimComplete \{Timer = BodyTimer}
	if Anim_Command target = <Timer> command = Timer_IsAnimComplete
		return \{scriptresult = 1}
	else
		return \{scriptresult = 0}
	endif
endscript

script CreateObjLabel 
	Obj_GetID
	SpawnScriptLater MaintainObjLabel params = {ObjID = <ObjID>}
endscript

script MaintainObjLabel 
	<id> = (<ObjID> + 5)
	begin
	if CompositeObjectExists name = <ObjID>
		<ObjID> :Obj_GetPosition
		FormatText TextName = text '%a' a = <ObjID> nowarning
		if ObjectExists id = <id>
			SetScreenElementProps id = <id> text = <text> pos3D = (<pos> + (0.0, 80.0, 0.0)) rgba = [100 0 0 128]
		else
			create_object_label id = <id> text = <text> pos3D = (<pos> + (0.0, 80.0, 0.0)) rgba = [100 0 0 128]
		endif
	else
		if ScreenElementExists id = <id>
			DestroyScreenElement id = <id>
		endif
		break
	endif
	Wait \{1
		frame}
	repeat
endscript

script ped_disable_bones 
endscript

script ped_enable_bones 
endscript

script Ped_InitBehaviorFromProfile 
	if GotParam \{BehaviorInitScript}
		<BehaviorInitScript>
	endif
endscript

script create_ped_label 
	SetScreenElementLock \{id = root_window
		off}
	CreateScreenElement {
		id = <id>
		type = TextBlockElement
		parent = root_window
		font = text_a1
		text = ''
		scale = 1.0
		pos = (0.0, 0.0)
		rgba = [0 128 0 128]
		dims = (250.0, 0.0)
		allow_expansion
		just = [center top]
	}
endscript

script destroy_ped_label 
	if ObjectExists id = <id>
		DestroyScreenElement id = <id>
	endif
endscript

script destroy_global_peds_in_zone 
	if NOT ($disable_global_pedestrians = 1)
		if NOT InNetGame
			if IsCOIMInited

				CleanupGlobalPedNodeArray name = 'zones/z_peds/z_peds.qb' zone = <zone>
			endif
		endif
	endif
endscript

script spawn_global_peds_in_zone 
	if NOT ($disable_global_pedestrians = 1)
		if NOT InNetGame
			if IsCOIMInited

				ParseGlobalPedNodeArray name = 'zones/z_peds/z_peds.qb' zone = <zone>
			endif
		endif
	endif
endscript
