GP_StarPower_FlameThrower01 = {
	pos = (0.0, 0.0, -0.35865304)
	angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	type = flat
	active
	CreatedAtStart
	attach
	Align
	ApplyPositionOffset
	AttachObject = Guitarist
	bone = bone_guitar_neck
	EmitRangeDims = (0.0, 0.0, 0.0)
	emit_Target = (0.0, 0.0, -1.0)
	EnableRotate
	EmitAngle = (0.0, 0.0, 0.0)
	force = (0.0, 0.2, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	AngleSpread = 20.0
	LifeRange = (1.0, 1.3)
	emit_rate = 16.0
	max = 0
	TimeSeed = 0.0
	lifeTime = 0.0
	emitNum = 0
	FollowEmitter = 0.2
	EmitFunction = constant
	EmitPeriod = 1.0
	SizeRange = [
		(0.2, 0.1)
		(0.7, 0.1)
	]
	SpeedRange = (1.5, 1.5)
	RotVel = (0.0, 0.0)
	RotVelTimeScale = 0.0
	EmitDelayStart = 0.0
	AlignWithPath
	PathFollowTime = 0.6
	History = 2
	HistoryListCoordinateSpace = world
	color = -1
	LOD_Default
	QuickMaterial = {
		TextureLayout = Layout2x2
		DiffuseTextureEnabled
		DiffuseTexture = jow_statueflames01
		SpecularPower = 0
		alphacutoff = 24
		blendMode = blend
		Burn
		BurnValue = 0.7
		QuadAnimationFPS = 12
	}
	Knot = [
		(-4.8371925, 0.0, -0.0)
		(-4.8371925, 0.0, -0.0)
		(-4.1530046, 0.0, -0.0)
		(-3.4688168, 0.0, -0.0)
		(-2.78463, 0.0, -0.0)
		(-1.26554, 0.0, -0.0)
		(0.253551, 0.0, -0.0)
		(1.7726411, 0.0, -0.0)
		(2.4186692, 0.0, -0.0)
		(3.0646958, 0.0, -0.0)
		(3.7107232, 0.0, -0.0)
		(3.7107232, 0.0, -0.0)
	]
	ParticleColor = [
		-3080192
		-7405568
		-10288897
		-4521729
		-16776961
		-12451585
		-16777216
		-12451840
	]
	VertexWeight = [
		0.240124
		0.773269
		1.0
	]
}
