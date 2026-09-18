GP_ButtonFlames01 = {
	pos = (200.0, -99.49771, 4.686832)
	angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	type = flat
	active
	CreatedAtStart
	EmitRangeDims = (0.0, 0.0, 0.0)
	emit_Target = (0.0, 1.0, 0.0)
	EmitAngle = (0.0, 0.0, 0.0)
	force = (0.0, 0.0, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	Radiate
	AngleSpread = 30.0
	BounceHeight = -99.9
	BounceCoeff = 0.6
	BounceCallbackRate = 0.0
	LifeRange = (1.0, 1.5)
	emit_rate = 2.0
	max = 0
	TimeSeed = 0.0
	lifeTime = 0.0
	emitNum = 0
	FollowEmitter = 0.0
	EmitFunction = constant
	EmitPeriod = 1.0
	SizeRange = [
		(0.6, 1.0)
		(0.8, 1.2)
	]
	SpeedRange = (0.3, 0.3)
	RotVel = (0.0, 0.0)
	RotVelTimeScale = 1.0
	EmitDelayStart = 0.0
	PathFollowTime = 0.0
	History = 2
	HistoryListCoordinateSpace = world
	color = -12451585
	LOD_Default
	QuickMaterial = {
		TextureLayout = Layout2x1
		DiffuseTextureEnabled
		DiffuseTexture = JOW_ButtonFlames01
		SpecularPower = 0
		alphacutoff = 32
		blendMode = Add
		QuadAnimationFPS = 0
	}
	Knot = [
		(-0.61986405, 0.0, -0.0)
		(-0.61986405, 0.0, -0.0)
		(-0.36443204, 0.0, -0.0)
		(-0.12410301, 0.0, -0.0)
		(0.131329, 0.0, -0.0)
		(0.24032901, 0.0, -0.0)
		(0.36443204, 0.0, -0.0)
		(0.47343102, 0.0, -0.0)
		(0.47343102, 0.0, -0.0)
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
		0.68709105
		1.0
	]
}
