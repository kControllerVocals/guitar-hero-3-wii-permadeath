GP_SparkPot01 = {
	pos = (-5.221416, -0.211548, 0.35191903)
	angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	type = flat
	active
	CreatedAtStart
	EmitRangeDims = (0.15, 0.0, 0.15)
	emit_Target = (0.0, 1.0, 0.0)
	EmitAngle = (0.0, 0.0, 0.0)
	force = (0.0, -7.0, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	AngleSpread = 15.0
	LifeRange = (1.0, 1.3)
	emit_rate = 200.0
	max = 0
	TimeSeed = 0.4
	lifeTime = 0.3
	emitNum = 0
	FollowEmitter = 0.0
	EmitFunction = constant
	EmitPeriod = 1.0
	SizeRange = [
		(0.1, 0.1)
		(0.05, 0.1)
	]
	SpeedRange = (6.0, 8.0)
	RotVel = (0.0, 0.0)
	RotVelTimeScale = 0.0
	EmitDelayStart = 0.0
	AlignWithPath
	PathFollowTime = 0.1
	History = 2
	HistoryListCoordinateSpace = world
	color = -9233665
	LOD_Default
	QuickMaterial = {
		DiffuseTextureEnabled
		DiffuseTexture = JOW_Spark01
		SpecularPower = 0
		alphacutoff = 16
		blendMode = Add
		Burn
		BurnValue = 0.7
		QuadAnimationFPS = 0
	}
	Knot = [
		(0.0, 0.0, -0.204028)
		(0.0, 0.0, -0.204028)
		(0.0, 0.0, -0.128626)
		(0.0, 0.0, -0.053225)
		(0.0, 0.0, 0.022177)
		(0.0, 0.0, 0.075402)
		(0.0, 0.0, 0.128626)
		(0.0, 0.0, 0.181851)
		(0.0, 0.0, 0.181851)
	]
	ParticleColor = [
		-1
		-1
		-1
		-1
		-256
		-256
	]
	VertexWeight = [
		0.5862069
		1.0
	]
}
