proximobj_composite_structure = [
	{
		Component = Sound
	}
]
particle_composite_structure = [
	{
		Component = Suspend
	}
	{
		Component = particle
	}
]
moving_particle_composite_structure = [
	{
		Component = Suspend
	}
	{
		Component = motion
	}
	{
		Component = particle
	}
]
flexparticle_composite_structure = [
	{
		Component = Suspend
	}
	{
		Component = flexibleparticle
	}
]
moving_flexparticle_composite_structure = [
	{
		Component = Suspend
	}
	{
		Component = motion
	}
	{
		Component = flexibleparticle
	}
]
viewercam_composite_structure = [
	{
		Component = camera
		far_clip = $camera_default_far_clip
	}
]
levellight_composite_structure = [
	{
		Component = dynamiclight
	}
]
igc_camera_structure = [
	{
		Component = CinematicCamera
		UpdateWhenCameraInactive = false
	}
	{
		Component = camera
	}
]
gridobj_composite_structure = [
	{
		Component = Suspend
	}
]
GeometryObject_structure = [
	{
		Component = GeometryObject
	}
]
master_node_composite_structure = [
	{
		Component = EventCache
	}
	{
		Component = StateMachineManager
	}
]
gameobj_composite_structure = [
	{
		Component = lockobj
		off
	}
	{
		Component = motion
	}
]
constraint_composite_structure = [
	{
		Component = constraint
	}
]
bouncy_composite_structure = [
	{
		Component = Suspend
	}
	{
		Component = rigidbody
	}
	{
		Component = Sound
	}
]

script ProcessorGroup_RegisterDefault 
	RegisterProcessorGroupDesc \{name = ProcessorGroup_CompositeSystem
		processors = [
			{
				name = Processor_Default
				task = {
					name = PTask_Default
				}
			}
		]}
	ProcessorMgr_Init \{group = ProcessorGroup_CompositeSystem}
endscript

script PassGroup_RegisterDefault 
	RegisterPassGroupDesc \{name = PassGroup_CompositeSystem
		passes = [
			{
				name = Pass_Default
				processors = [
					Processor_Default
				]
			}
			{
				name = Pass_Agent
				processors = [
					Processor_Default
				]
			}
			{
				name = Pass_Behavior
				processors = [
					Processor_Default
				]
			}
			{
				name = Pass_Anim
				processors = [
					Processor_Default
				]
			}
			{
				name = Pass_Move
				processors = [
					Processor_Default
				]
			}
			{
				name = Pass_Model
				processors = [
					Processor_Default
				]
			}
		]}
	PassMgr_Init \{group = PassGroup_CompositeSystem}
endscript

script CompositeObjects_RegisterDefault 
	PassDefault_components = [
		{name = Suspend}
		{name = BBox}
		{name = ObjectProximity}
		{name = Sound}
		{name = stream}
	]
	RegisterCompositeObjectDesc {
		name = CompositeHuman
		callback = CompositeAgent_CustomizeComponents
		passes =
		[
			{pass = Pass_Default
				Components = <PassDefault_components>
			}
			{pass = Pass_Agent
				Components = [{name = PedLife}
					{name = AiInfo}
					{name = Agent}
					{name = FAM}
					{name = Locator}
					{name = ItemControl}
					{name = Vision}
					{name = CollisionCache
						params = {bbox_min = (-0.1, -20.0, -0.1)
							bbox_max = (0.1, 10.0, 0.1)
							layer = static_geometry_feeler}}
					{name = navigation}
					{name = motion}
					{name = ragdoll}
				]
			}
			{pass = Pass_Behavior
				Components = [{name = EventCache}
					{name = BehaviorSystem}
					{name = inventory}
					{name = seek}
					{name = Passenger}
					{name = Targetable}
					{name = Proximity}
					{name = Interact}
					{name = SkaterLoopingSound}
					{name = AnimTree}
					{name = lockobj
						params = {lock_to_object_matrix
							off}}
					{name = NavCollision}
					{name = AlignToGround
						params = {off}}
				]
			}
			{pass = Pass_Model
				Components = [{name = skeleton}
					{name = Model}
					{name = SpecialItem}
					{name = ProximTrigger
						params = {trigger_checksum = Ped , cube_length = 0.4}}
				]
			}
		]
	}
	RegisterCompositeObjectDesc {
		name = CompositeVehicle
		callback = CompositeAgent_CustomizeComponents
		passes =
		[
			{pass = Pass_Default
				Components = <PassDefault_components>
			}
			{pass = Pass_Agent
				Components = [{name = PedLife}
					{name = AiInfo}
					{name = Agent}
					{name = FAM}
					{name = Locator}
					{name = ItemControl}
					{name = CollisionCache
						params = {bbox_min = (-0.1, -20.0, -0.1)
							bbox_max = (0.1, 10.0, 0.1)
							layer = static_geometry_feeler}}
					{name = navigation}
					{name = motion}
				]
			}
			{pass = Pass_Behavior
				Components = [{name = EventCache}
					{name = BehaviorSystem}
					{name = seek}
					{name = Interact}
					{name = VehiclePhysics}
					{name = AnimTree}
					{name = Input
						params = {controller = 1}}
				]
			}
			{pass = Pass_Model
				Components = [{name = skeleton}
					{name = Model}
					{name = ProximTrigger
						params = {trigger_checksum = Vehicle , cube_length = 0.4}}
				]
			}]
	}
	RegisterCompositeObjectDesc \{name = CompositeGameObject_SimpleHover
		callback = nullscript
		passes = [
			{
				pass = Pass_Default
				Components = [
					{
						name = Suspend
					}
				]
			}
			{
				pass = Pass_Move
				Components = [
					{
						name = Hover
					}
				]
			}
			{
				pass = Pass_Model
				Components = [
					{
						name = ObjectProximity
					}
					{
						name = Model
					}
				]
			}
		]}
	RegisterCompositeObjectDesc \{name = CompositeGameObject_StandardRigidBody
		callback = nullscript
		passes = [
			{
				pass = Pass_Default
				Components = [
					{
						name = Suspend
					}
				]
			}
			{
				pass = Pass_Move
				Components = [
					{
						name = rigidbody
					}
				]
			}
			{
				pass = Pass_Model
				Components = [
					{
						name = Sound
					}
					{
						name = Model
					}
				]
			}
		]}
	AdObject_components = [{name = Model}
		{name = motion}
	]
endscript

script CompositeAgent_CustomizeComponents 
	if GotParam \{CompassBlipType}
		CreateComponentFromStructure Component = CompassBlip <...>
	endif
	if GotParam \{voice_profile}
		if StructureContains \{Structure = appearance
				voice_profile}
			voice_profile = (<appearance>.voice_profile)
		else
			voice_profile = (<profile>.voice_profile)
		endif
		if StructureContains Structure = $NoticeVoVoiceProfiles <voice_profile>
			has_notice_vo = ($NoticeVoVoiceProfiles.<voice_profile>)
		else
			has_notice_vo = false
		endif
		SetTags {
			profile = <profile>
			voice_profile = <voice_profile>
			has_notice_vo = <has_notice_vo>
		}
	endif
endscript
