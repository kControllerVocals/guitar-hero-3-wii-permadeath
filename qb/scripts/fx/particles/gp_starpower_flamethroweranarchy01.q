GP_StarPower_FlameThrowerAnarchy01 = {
	pos = (0.35688803, 2.835854, 0.071378)
	angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	type = flat
	active
	CreatedAtStart
	attach
	AttachObject = Guitarist
	bone = Bone_Pelvis
	EmitRangeDims = (0.7, 0.7, 0.7)
	emit_Target = (0.0, 1.0, 0.0)
	EmitAngle = (0.0, 0.0, 0.0)
	force = (0.0, 0.0, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	AngleSpread = 45.0
	LifeRange = (0.2, 0.4)
	emit_rate = 6.0
	max = 0
	TimeSeed = 0.2
	lifeTime = 0.0
	emitNum = 0
	FollowEmitter = 0.0
	EmitFunction = constant
	EmitPeriod = 1.0
	SizeRange = [
		(0.2, 0.2)
		(0.6, 0.6)
	]
	SpeedRange = (0.0, 0.0)
	RotVel = (-0.1, 0.1)
	RotVelTimeScale = 1.0
	EmitDelayStart = 0.0
	PathFollowTime = 0.2
	History = 6
	HistoryListCoordinateSpace = world
	color = -16776961
	NoVisibilityTest
	QuickMaterial = {
		DiffuseTextureEnabled
		DiffuseTexture = JOW_Anarchy01
		SpecularPower = 0
		TwoSide
		alphacutoff = 76
		blendMode = diffuse
		QuadAnimationFPS = 0
	}
	Knot = [
		(-5.710207, 0.0, -0.28551)
		(-5.710207, 0.0, -0.28551)
		(-5.15332, 0.0, -0.25833598)
		(0.055202, 0.0, -0.23116201)
		(5.2637234, 0.0, -0.20398802)
		(5.2637234, 0.0, -0.20398802)
	]
	ParticleColor = [
		-892679425
		-256
		-892679425
		-1
	]
	VertexWeight = [
		1.0
	]
}
