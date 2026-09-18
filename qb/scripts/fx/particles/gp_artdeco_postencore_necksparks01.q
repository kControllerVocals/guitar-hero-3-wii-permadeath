GP_ArtDeco_PostEncore_NeckSparks01 = {
	pos = (0.0, 0.77766997, -0.779315)
	angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	type = flat
	active
	CreatedAtStart
	attach
	Align
	ApplyPositionOffset
	AttachObject = Z_ArtDeco_TRG_Geo_Dragon
	bone = Bone_Dragon_Neck02
	EmitRangeDims = (0.3, 0.3, 0.3)
	DoCircularEmit
	emit_Target = (0.0, 1.0, -1.0)
	EnableRotate
	EmitAngle = (0.0, 0.0, 0.0)
	force = (0.0, -7.0, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	AngleSpread = 90.0
	BounceHeight = 0.0
	BounceCoeff = 0.2
	BounceCallbackRate = 0.0
	LifeRange = (2.0, 3.0)
	emit_rate = 12.0
	max = 0
	TimeSeed = 0.0
	lifeTime = 0.0
	emitNum = 0
	FollowEmitter = 0.0
	EmitFunction = onoff
	EmitPeriod = 2.5
	SizeRange = [
		(0.04, 0.17140001)
		(0.0, 0.2284)
	]
	SpeedRange = (3.0, 5.0)
	RotVel = (0.0, 0.0)
	RotVelTimeScale = 0.0
	EmitDelayStart = 0.0
	AlignWithPath
	PathFollowTime = 0.04
	History = 2
	HistoryListCoordinateSpace = world
	color = -9568001
	LOD_Default
	QuickMaterial = {
		DiffuseTextureEnabled
		DiffuseTexture = JOW_Spark01
		SpecularPower = 0
		alphacutoff = 96
		blendMode = Add
		Burn
		BurnValue = 0.7
		QuadAnimationFPS = 8
	}
	Knot = [
		(-0.48496202, 0.0, -0.0)
		(-0.48496202, 0.0, -0.0)
		(-0.441017, 0.0, -0.0)
		(-0.013056999, 0.0, -0.0)
		(0.414903, 0.0, -0.0)
		(0.710889, 0.0, -0.0)
		(1.006876, 0.0, -0.0)
		(1.051219, 0.0, -0.0)
		(1.051219, 0.0, -0.0)
	]
	ParticleColor = [
		-1
		-1
		-1
		-1
		-1
		-1
	]
	VertexWeight = [
		0.585781
		1.0
	]
}
