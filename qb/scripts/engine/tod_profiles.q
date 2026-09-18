Default_tod_manager_bloomNoBlur = {
	tod = {
		sun_on = 1
		sun_theta = 330.0
		sun_phi = 0.0
		sun_red = 255.0
		sun_green = 173.0
		sun_blue = 97.0
		lev_red = 135
		lev_green = 130
		lev_blue = 125
	}
	atmosphere = {
		SmallParticlesRGB = [
			128
			128
			128
		]
		LargeParticlesRGB = [
			128
			128
			128
		]
		phase = 0
		strength = 0
		atmosphere = s_default
		SmallScale = 10
		LargeScale = 10
	}
	screen_fx = [
		{
			scefName = BnS
			type = bright_sat
			on = 1
			contrast = 1
			red_mix = [
				1
				0
				0
			]
			green_mix = [
				0
				1
				0
			]
			blue_mix = [
				0
				0
				1
			]
			brightness = 1
			saturation = 1
			hue = 1
		}
		{
			scefName = sbloom
			type = Simple_Bloom
			on = 1
			Bloom1 = 0.35000002
			materialfilter = 1
			bloom2 = 0.0
			AutoLuminanceMod = 0
			DistanceMod = 0.0
			strength = [
				255
				255
				255
			]
			color = [
				68
				68
				68
			]
			FallOff1 = 5
			FallOff2 = 0.0
		}
	]
}
Default_tod_manager_bloomBlur = {
	tod = {
		sun_on = 1
		sun_theta = 330.0
		sun_phi = 0.0
		sun_red = 255.0
		sun_green = 173.0
		sun_blue = 97.0
		lev_red = 135
		lev_green = 130
		lev_blue = 125
	}
	atmosphere = {
		SmallParticlesRGB = [
			128
			128
			128
		]
		LargeParticlesRGB = [
			128
			128
			128
		]
		phase = 0
		strength = 0
		atmosphere = s_default
		SmallScale = 10
		LargeScale = 10
	}
	screen_fx = [
		{
			scefName = BnS
			type = bright_sat
			on = 1
			contrast = 1
			red_mix = [
				1
				0
				0
			]
			green_mix = [
				0
				1
				0
			]
			blue_mix = [
				0
				0
				1
			]
			brightness = 1
			saturation = 1
			hue = 1
		}
		{
			scefName = sbloom
			type = Simple_Bloom
			on = 1
			Bloom1 = 0.35000002
			materialfilter = 1
			bloom2 = 1.0
			AutoLuminanceMod = 0
			DistanceMod = 0.0
			strength = [
				255
				255
				255
			]
			color = [
				68
				68
				68
			]
			FallOff1 = 5
			FallOff2 = 0.0
		}
	]
}
Default_tod_manager = Default_tod_manager_bloomBlur
DOF_CloseUp01_tod_manager = {
	tod = {
		sun_on = 0
		sun_theta = 0.0
		sun_phi = 0.0
		sun_red = 0.0
		sun_green = 0.0
		sun_blue = 0.0
		lev_red = 0
		lev_green = 0
		lev_blue = 0
	}
	atmosphere = {
		SmallParticlesRGB = [
			128
			128
			128
		]
		LargeParticlesRGB = [
			128
			128
			128
		]
		phase = 0
		strength = 0
		atmosphere = s_default
		SmallScale = 10
		LargeScale = 10
	}
	screen_fx = [
		{
			scefName = dof
			type = dof
			on = 1
			BackDist = 0.02
			FrontDist = 0
			strength = 0.6
			BlurRadius = 6
			BlurResolution = quarter
		}
	]
}
DOF_CloseUp02_tod_manager = {
	tod = {
		sun_on = 0
		sun_theta = 0.0
		sun_phi = 0.0
		sun_red = 0.0
		sun_green = 0.0
		sun_blue = 0.0
		lev_red = 0
		lev_green = 0
		lev_blue = 0
	}
	atmosphere = {
		SmallParticlesRGB = [
			128
			128
			128
		]
		LargeParticlesRGB = [
			128
			128
			128
		]
		phase = 0
		strength = 0
		atmosphere = s_default
		SmallScale = 10
		LargeScale = 10
	}
	screen_fx = [
		{
			scefName = dof
			type = dof
			on = 1
			BackDist = 0.012
			FrontDist = 0
			strength = 0.8
			BlurRadius = 6
			BlurResolution = quarter
		}
	]
}
DOF_CloseUp03_tod_manager = {
	tod = {
		sun_on = 0
		sun_theta = 0.0
		sun_phi = 0.0
		sun_red = 0.0
		sun_green = 0.0
		sun_blue = 0.0
		lev_red = 0
		lev_green = 0
		lev_blue = 0
	}
	atmosphere = {
		SmallParticlesRGB = [
			128
			128
			128
		]
		LargeParticlesRGB = [
			128
			128
			128
		]
		phase = 0
		strength = 0
		atmosphere = s_default
		SmallScale = 10
		LargeScale = 10
	}
	screen_fx = [
		{
			scefName = dof
			type = dof
			on = 1
			BackDist = 0.012
			FrontDist = 0
			strength = 1
			BlurRadius = 6
			BlurResolution = quarter
		}
	]
}
DOF_Medium01_tod_manager = {
	tod = {
		sun_on = 0
		sun_theta = 0.0
		sun_phi = 0.0
		sun_red = 0.0
		sun_green = 0.0
		sun_blue = 0.0
		lev_red = 0
		lev_green = 0
		lev_blue = 0
	}
	atmosphere = {
		SmallParticlesRGB = [
			128
			128
			128
		]
		LargeParticlesRGB = [
			128
			128
			128
		]
		phase = 0
		strength = 0
		atmosphere = s_default
		SmallScale = 10
		LargeScale = 10
	}
	screen_fx = [
		{
			scefName = dof
			type = dof
			on = 1
			BackDist = 0.1
			FrontDist = 0
			strength = 0.7
			BlurRadius = 6
			BlurResolution = quarter
		}
	]
}
DOF_Medium02_tod_manager = {
	tod = {
		sun_on = 0
		sun_theta = 0.0
		sun_phi = 0.0
		sun_red = 0.0
		sun_green = 0.0
		sun_blue = 0.0
		lev_red = 0
		lev_green = 0
		lev_blue = 0
	}
	atmosphere = {
		SmallParticlesRGB = [
			128
			128
			128
		]
		LargeParticlesRGB = [
			128
			128
			128
		]
		phase = 0
		strength = 0
		atmosphere = s_default
		SmallScale = 10
		LargeScale = 10
	}
	screen_fx = [
		{
			scefName = dof
			type = dof
			on = 1
			BackDist = 0.55
			FrontDist = 0
			strength = 0.8
			BlurRadius = 6
			BlurResolution = quarter
		}
	]
}
DOF_Medium03_TOD_Manager = {
	tod = {
		sun_on = 0
		sun_theta = 0.0
		sun_phi = 0.0
		sun_red = 0.0
		sun_green = 0.0
		sun_blue = 0.0
		lev_red = 0
		lev_green = 0
		lev_blue = 0
	}
	atmosphere = {
		SmallParticlesRGB = [
			128
			128
			128
		]
		LargeParticlesRGB = [
			128
			128
			128
		]
		phase = 0
		strength = 0
		atmosphere = s_default
		SmallScale = 10
		LargeScale = 10
	}
	screen_fx = [
		{
			scefName = dof
			type = dof
			on = 1
			BackDist = 0.05
			FrontDist = 0
			strength = 0.8
			BlurRadius = 6
			BlurResolution = quarter
		}
	]
}
DOF_Medium04_TOD_Manager = {
	tod = {
		sun_on = 0
		sun_theta = 0.0
		sun_phi = 0.0
		sun_red = 0.0
		sun_green = 0.0
		sun_blue = 0.0
		lev_red = 0
		lev_green = 0
		lev_blue = 0
	}
	atmosphere = {
		SmallParticlesRGB = [
			128
			128
			128
		]
		LargeParticlesRGB = [
			128
			128
			128
		]
		phase = 0
		strength = 0
		atmosphere = s_default
		SmallScale = 10
		LargeScale = 10
	}
	screen_fx = [
		{
			scefName = dof
			type = dof
			on = 1
			BackDist = 0.07
			FrontDist = 0
			strength = 1
			BlurRadius = 6
			BlurResolution = quarter
		}
	]
}
DOF_Off_tod_manager = {
	tod = {
		sun_on = 0
		sun_theta = 0.0
		sun_phi = 0.0
		sun_red = 0.0
		sun_green = 0.0
		sun_blue = 0.0
		lev_red = 0
		lev_green = 0
		lev_blue = 0
	}
	atmosphere = {
		SmallParticlesRGB = [
			128
			128
			128
		]
		LargeParticlesRGB = [
			128
			128
			128
		]
		phase = 0
		strength = 0
		atmosphere = s_default
		SmallScale = 10
		LargeScale = 10
	}
	screen_fx = [
		{
			scefName = dof
			type = dof
			on = 0
			BackDist = 1
			FrontDist = 0
			strength = 0
			BlurRadius = 0
			BlurResolution = quarter
		}
	]
}
DOF_Temp_tod_manager = {
	tod = {
		sun_on = 0
		sun_theta = 0.0
		sun_phi = 0.0
		sun_red = 0.0
		sun_green = 0.0
		sun_blue = 0.0
		lev_red = 0
		lev_green = 0
		lev_blue = 0
	}
	atmosphere = {
		SmallParticlesRGB = [
			128
			128
			128
		]
		LargeParticlesRGB = [
			128
			128
			128
		]
		phase = 0
		strength = 0
		atmosphere = s_default
		SmallScale = 10
		LargeScale = 10
	}
	screen_fx = [
		{
			scefName = dof
			type = dof
			on = 1
			BackDist = 0.1
			FrontDist = 0
			strength = 0.3
			BlurRadius = 3
			BlurResolution = half
		}
	]
}
ScreenFlash_TOD_Manager = {
	tod = {
		sun_on = 1
		sun_theta = 330.0
		sun_phi = 45.0
		sun_red = 255.0
		sun_green = 173.0
		sun_blue = 97.0
		lev_red = 135
		lev_green = 130
		lev_blue = 125
	}
	atmosphere = {
		SmallParticlesRGB = [
			27
			51
			255
		]
		LargeParticlesRGB = [
			187
			153
			137
		]
		phase = 1.05
		strength = 0.45000002
		atmosphere = ph_dome
		SmallScale = 55
		LargeScale = 1
	}
	screen_fx = [
		{
			scefName = BS
			type = bright_sat
			on = 1
			contrast = 0.6
			red_mix = [
				1
				0
				0
			]
			green_mix = [
				0
				1
				0
			]
			blue_mix = [
				0
				0
				1
			]
			brightness = 2.5
			saturation = 1
			hue = 1
		}
	]
}
ScreenToBlack_TOD_Manager = {
	tod = {
		sun_on = 0
		sun_theta = 0.0
		sun_phi = 0.0
		sun_red = 0.0
		sun_green = 0.0
		sun_blue = 0.0
		lev_red = 0
		lev_green = 0
		lev_blue = 0
	}
	atmosphere = {
		SmallParticlesRGB = [
			128
			128
			128
		]
		LargeParticlesRGB = [
			128
			128
			128
		]
		phase = 0
		strength = 0
		atmosphere = ph_dome
		SmallScale = 10
		LargeScale = 10
	}
	screen_fx = [
		{
			scefName = VG
			type = Vignette
			on = 1
			inner_radius = 1.0
			outer_radius = 1.5
			alpha = 0
		}
	]
}
