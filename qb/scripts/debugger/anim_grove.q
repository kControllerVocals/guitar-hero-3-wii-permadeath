AnimPreviewBaseTree = {
	type = DegenerateBlend
	id = PreviewTreeAnimNode
}

script AnimTreePreview_UpdateBlendValues 
	if CompositeObjectExists \{name = AnimTreePreviewObject}
		AnimTreePreviewObject :AnimPreview_SetSourceValues <...>
	endif
endscript

script TestAnimScript 
	Anim_Command target = PreviewTreeAnimNode command = DegenerateBlend_AddBranch params = {Tree = <Tree> params = <Tree_Params>}
	Obj_ForceUpdate
endscript

script AnimTreePreview_NxCommon \{targetObject = skater}
	if CompositeObjectExists \{name = AnimTreePreviewObject}
		AnimTreePreviewRestore
	endif
	dump <Tree>
	if NOT GotParam \{skeleton}
		<targetObject> :Skeleton_GetSkeletonName
		skeleton = <SkeletonName>
	endif
	if NOT GotParam \{ragdoll}
		if <targetObject> :ContainsComponent ragdoll
			if <targetObject> :ragdoll_getragdollname
				ragdoll = <ragdollName>
			endif
		endif
	endif
	SetSearchAllAssetContexts
	CreateFakePlayer PositionFrom = <targetObject> CloneFrom = <targetObject> Model = <Model> ragdoll = <ragdoll> skeleton = <skeleton> appearance = <appearance> active_value_sources = <active_value_sources>
	AnimTreePreviewObject :Anim_InitTree \{Tree = $AnimPreviewBaseTree
		NodeIdDeclaration = [
			PreviewTreeAnimNode
		]}
	if AnimTreePreviewObject :anim_loadanims Tree = <Tree> params = <Tree_Params>
		AnimTreePreviewObject :Obj_SwitchScript TestAnimScript params = {Tree = <Tree> Tree_Params = <Tree_Params>}
		<targetObject> :hide
		<targetObject> :Pause
	else
		AnimTreePreviewObject :Die
	endif
	dump <Tree>
endscript

script CreateFakePlayer 
	if NOT CompositeObjectExists <CloneFrom>
		return
	endif
	if NOT CompositeObjectExists <PositionFrom>
		return
	endif
	if CompositeObjectExists \{AnimTreePreviewObject}
		AnimTreePreviewObject :Die
	endif
	<PositionFrom> :Obj_GetPosition
	<PositionFrom> :Obj_GetQuat
	Components = []
	if GotParam \{ragdoll}
		RagdollComponents = [
			{
				Component = ragdoll
				ragdollName = <ragdoll>
				initialize_empty = false
			}
		]
		Components = (<Components> + <RagdollComponents>)
	endif
	BasicComponents = [
		{
			Component = AnimPreview
			active_value_source_list = <active_value_sources>
			preload_model = <Model>
		}
		{
			Component = AnimInfo
			active_value_set = preview
		}
		{
			Component = AnimTree
			ReferenceChecksum = <skeleton>
			AnimEventTableName = SkaterAnimEventTable
		}
		{
			Component = skeleton
		}
		{
			Component = SetDisplayMatrix
		}
	]
	Components = (<Components> + <BasicComponents>)
	if GotParam \{Model}
		ModelComponent = [
			{
				Component = Model
				Model = <Model>
			}
		]
	else
		ModelComponent = [
			{
				Component = Model
				CloneFrom = <CloneFrom>
			}
		]
	endif
	Components = (<Components> + <ModelComponent>)
	CreateCompositeObject {
		Components = <Components>
		params = {
			SkeletonName = <skeleton>
			name = AnimTreePreviewObject
			pos = <pos>
			Orientation = <Quat>
			assetcontext = AnimPreviewObject
			<appearance>
		}
	}
endscript
