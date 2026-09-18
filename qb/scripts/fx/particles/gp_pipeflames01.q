GP_PipeFlames01 = {
	pos = (2.0216632, 5.1616206, -1.478416)
	angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	type = flat
	active
	CreatedAtStart
	EmitRangeDims = (0.2, 0.2, 0.1)
	emit_Target = (0.0, 0.4, 1.0)
	EmitAngle = (0.0, 0.0, 0.0)
	force = (0.0, -1.0, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	Radiate
	AngleSpread = 25.0
	LifeRange = (0.1, 0.5)
	emit_rate = 48.0
	max = 0
	TimeSeed = 0.0
	lifeTime = 0.0
	emitNum = 0
	FollowEmitter = 0.0
	EmitFunction = constant
	EmitPeriod = 1.0
	SizeRange = [
		(1.5, 1.5)
		(0.5, 0.5)
	]
	SpeedRange = (5.0, 6.0)
	RotVel = (0.0, 0.0)
	RotVelTimeScale = 0.0
	EmitDelayStart = 0.0
	AlignWithPath
	PathFollowTime = 0.3
	History = 2
	HistoryListCoordinateSpace = world
	color = -9223425
	LOD_Distances = (20.0, 30.0)
	NoVisibilityTest
	QuickMaterial = {
		TextureLayout = Layout2x2
		DiffuseTextureEnabled
		DiffuseTexture = jow_statueflames01
		SpecularPower = 0
		alphacutoff = 16
		blendMode = Add
		Burn
		BurnValue = 0.8
		SortGroup = 3
		DrawOrder = 12.0
		QuadAnimationFPS = 12
	}
	Knot = [
		(-0.46765104, 0.0, -0.0)
		(-0.46765104, 0.0, -0.0)
		(-0.24335201, 0.0, -0.0)
		(-0.019053001, 0.0, -0.0)
		(0.205247, 0.0, -0.0)
		(0.292715, 0.0, -0.0)
		(0.380183, 0.0, -0.0)
		(0.46765104, 0.0, -0.0)
		(0.46765104, 0.0, -0.0)
	]
	ParticleColor = [
		-1
		-1
		-12566273
		-6973953
		-12566528
		-15066624
	]
	VertexWeight = [
		0.719445
		1.0
	]
}
