GP_ArtDeco_DragonSparks01_02 = {
	pos = (0.003022, 2.1533198, -2.535198)
	angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	type = flat
	active
	CreatedAtStart
	attach
	Align
	ApplyPositionOffset
	bone = Bone_Dragon_Jaw
	EmitRangeDims = (0.2, 0.2, 0.2)
	emit_Target = (0.0, 0.0, -1.0)
	EnableRotate
	EmitAngle = (45.0, 0.0, 0.0)
	force = (0.0, 3.0, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	AngleSpread = 25.0
	LifeRange = (0.7, 1.0)
	emit_rate = 48.0
	max = 0
	TimeSeed = 0.0
	lifeTime = 0.0
	emitNum = 0
	FollowEmitter = 0.0
	EmitFunction = constant
	EmitPeriod = 1.0
	SizeRange = [
		(0.05, 0.05)
		(0.05, 0.05)
	]
	SpeedRange = (4.0, 6.0)
	RotVel = (0.0, 0.0)
	RotVelTimeScale = 0.0
	EmitDelayStart = 0.0
	PathFollowTime = 0.2
	History = 2
	HistoryListCoordinateSpace = world
	color = -1
	LOD_Distances = (20.0, 30.0)
	NoVisibilityTest
	QuickMaterial = {
		DiffuseTextureEnabled
		DiffuseTexture = JOW_Spark02
		SpecularPower = 0
		alphacutoff = 1
		blendMode = Add
		SortGroup = 3
		DrawOrder = 20.0
		QuadAnimationFPS = 0
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
		-8126209
		-5242625
		-12517121
		-8191745
		-16777216
		-600834048
	]
	VertexWeight = [
		0.585781
		1.0
	]
}
