GP_FlamePot01 = {
	pos = (-3.5388658, 0.0, 2.976535)
	angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	type = flat
	active
	CreatedAtStart
	EmitRangeDims = (0.0, 0.0, 0.0)
	emit_Target = (0.0, 1.0, 0.0)
	EmitAngle = (0.0, 0.0, 0.0)
	force = (0.0, -6.0, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	AngleSpread = 10.0
	LifeRange = (0.8, 1.1)
	emit_rate = 15.0
	max = 0
	TimeSeed = 0.4
	lifeTime = 0.3
	emitNum = 8
	FollowEmitter = 0.0
	EmitFunction = constant
	EmitPeriod = 0.5
	SizeRange = [
		(0.5, 1.5)
		(0.25, 1.25)
	]
	SpeedRange = (6.5, 8.5)
	RotVel = (0.0, 0.0)
	RotVelTimeScale = 0.0
	EmitDelayStart = 0.0
	AlignWithPath
	PathFollowTime = 0.5
	History = 2
	HistoryListCoordinateSpace = world
	color = -9233665
	LOD_Default
	QuickMaterial = {
		TextureLayout = Layout2x2
		DiffuseTextureEnabled
		DiffuseTexture = jow_statueflames01
		SpecularPower = 0
		alphacutoff = 16
		blendMode = Add
		Burn
		BurnValue = 0.75
		QuadAnimationFPS = 12
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
