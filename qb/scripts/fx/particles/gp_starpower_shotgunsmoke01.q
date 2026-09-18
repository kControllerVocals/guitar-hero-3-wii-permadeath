GP_StarPower_ShotgunSmoke01 = {
	pos = (0.0, 0.0, -0.63)
	angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	type = flat
	active
	CreatedAtStart
	attach
	Align
	ApplyPositionOffset
	bone = bone_guitar_neck
	EmitRangeDims = (0.1, 0.1, 0.1)
	DoCircularEmit
	emit_Target = (0.0, 0.0, -1.0)
	EnableRotate
	EmitAngle = (0.0, 0.0, 0.0)
	force = (0.0, 0.0, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	Radiate
	ElevSpread = (90.0, 120.0)
	SweepSpread = (0.0, 360.0)
	LifeRange = (1.0, 1.5)
	emit_rate = 99.0
	max = 0
	TimeSeed = 0.0
	lifeTime = 0.0
	emitNum = 8
	FollowEmitter = 0.0
	EmitFunction = constant
	EmitPeriod = 1.0
	SizeRange = [
		(0.3, 0.3)
		(0.6, 0.6)
	]
	SpeedRange = (0.0, 0.2)
	RotVel = (-0.5, 0.5)
	RotVelTimeScale = 1.0
	EmitDelayStart = 0.0
	PathFollowTime = 1.0
	History = 2
	HistoryListCoordinateSpace = world
	color = -1
	LOD_Distances = (20.0, 30.0)
	NoVisibilityTest
	QuickMaterial = {
		TextureLayout = Layout2x2
		DiffuseTextureEnabled
		DiffuseTexture = JOW_Steam02
		SpecularPower = 0
		alphacutoff = 32
		blendMode = blend
		Burn
		BurnValue = 0.2
		QuadAnimationFPS = 0
	}
	Knot = [
		(-4.8371935, 0.0, -0.0)
		(-4.8371935, 0.0, -0.0)
		(-4.1530046, 0.0, -0.0)
		(-2.719257, 0.0, -0.0)
		(-1.2855101, 0.0, -0.0)
		(0.431565, 0.0, -0.0)
		(2.1486409, 0.0, -0.0)
		(3.6677308, 0.0, -0.0)
		(4.3137593, 0.0, -0.0)
	]
	ParticleColor = [
		-10142721
		-7470961
		926365695
		1667458047
		926365440
		1667457792
	]
	VertexWeight = [
		0.41760302
		1.0
	]
}
