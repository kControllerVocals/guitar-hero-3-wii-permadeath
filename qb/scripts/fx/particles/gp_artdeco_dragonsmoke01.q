GP_ArtDeco_DragonSmoke01 = {
	pos = (0.003022, 0.80188, -0.7862879)
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
	bone = Bone_Dragon_Jaw
	EmitRangeDims = (0.0, 0.0, 0.0)
	emit_Target = (0.0, 0.0, -1.0)
	EnableRotate
	EmitAngle = (40.0, 0.0, 0.0)
	force = (0.0, 3.0, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	AngleSpread = 10.0
	LifeRange = (0.6, 0.9)
	emit_rate = 24.0
	max = 0
	TimeSeed = 0.0
	lifeTime = 0.0
	emitNum = 0
	FollowEmitter = 0.0
	EmitFunction = constant
	EmitPeriod = 1.0
	SizeRange = [
		(0.5, 0.5)
		(2.5, 2.5)
	]
	SpeedRange = (4.0, 6.0)
	RotVel = (-0.5, 0.5)
	RotVelTimeScale = 1.0
	EmitDelayStart = 0.0
	PathFollowTime = 0.2
	History = 2
	HistoryListCoordinateSpace = world
	color = -1
	LOD_Default
	QuickMaterial = {
		TextureLayout = Layout2x2
		DiffuseTextureEnabled
		DiffuseTexture = JOW_Steam02
		SpecularPower = 0
		alphacutoff = 16
		blendMode = blend
		QuadAnimationFPS = 0
	}
	Knot = [
		(-0.48496202, 0.0, -0.0)
		(-0.48496202, 0.0, -0.0)
		(-0.46225402, 0.0, -0.0)
		(-0.20386702, 0.0, -0.0)
		(-0.0021040002, 0.0, -0.0)
		(0.271848, 0.0, -0.0)
		(0.40935102, 0.0, -0.0)
		(0.54685503, 0.0, -0.0)
		(0.776865, 0.0, -0.0)
		(1.006876, 0.0, -0.0)
		(1.051219, 0.0, -0.0)
		(1.051219, 0.0, -0.0)
	]
	ParticleColor = [
		1917271552
		1730948096
		1580798719
		-1823339009
		1697717952
		1544556743
		488447232
		623191296
	]
	VertexWeight = [
		0.314324
		0.67167693
		1.0
	]
}
