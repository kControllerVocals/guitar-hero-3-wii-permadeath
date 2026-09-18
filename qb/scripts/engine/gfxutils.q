ISOLATE_2D_RENDER = 0
pix_output = 0

script HiResScreenshot \{scale = 1}
	if CutsceneFinished \{name = cutscene}
		PauseGame
		GetCurrentCameraObject
	else
		PlayIGCCam \{name = hires_cutscene_hack
			interrupt_current
			Play_hold}
		WaitOneGameFrame
		GetSkaterCamAnimParams \{name = hires_cutscene_hack}
		<cameraid> = <cam_object_id>
	endif
	<cameraid> = <camid>
	printstruct <...>
	<i> = 0
	Wait \{30
		frames
		ignoreslomo}
	printf \{'11111111111111111111111111111111111111'}
	begin
	<j> = 0
	begin
	printf \{'222222222222222222222222222222222'}
	FormatText TextName = text 'hi_res_screen_%a_%b_' a = <i> b = <j>
	sub = ((<i> * <scale>) + <j>)
	<cameraid> :SetSubFrustum res = <scale> subImage = <sub>
	Wait \{16
		frame
		ignoreslomo}
	ScreenShot filename = <text>
	Wait \{16
		frames
		ignoreslomo}
	<j> = (<j> + 1)
	repeat <scale>
	<i> = (<i> + 1)
	repeat <scale>
	<cameraid> :SetSubFrustum res = 1 subImage = 0
	root_window :DoMorph \{alpha = 1}
	if GotParam \{Do2D}
		if isXenon
			change \{ISOLATE_2D_RENDER = 1}
			Wait \{3
				frames}
			<i> = 0
			begin
			<j> = 0
			begin
			FormatText TextName = text 'hi_res_screen_2d_%a_%b_' a = <i> b = <j>
			sub = ((<i> * <scale>) + <j>)
			<cameraid> :SetSubFrustum res = <scale> subImage = <sub>
			Wait \{16
				frames}
			ScreenShot filename = <text>
			Wait \{16
				frames}
			<j> = (<j> + 1)
			repeat <scale>
			<i> = (<i> + 1)
			repeat <scale>
			<cameraid> :SetSubFrustum res = 1 subImage = 0
			change \{ISOLATE_2D_RENDER = 0}
		endif
	endif
	if CutsceneFinished \{name = cutscene}
		UnPauseGame
	else
		KillSkaterCamAnim \{name = hires_cutscene_hack}
	endif
endscript

script SpawnHiResScreenShot 
	SpawnScriptLater HiResScreenshot params = <...>
endscript

script CubeMapScreenshots 
	change \{Show_Zone_budget_Warnings = 0}
	change \{no_render_metrics = 1}
	root_window :DoMorph \{alpha = 0}
	if CompositeObjectExists \{skater}
		skater :hide
	endif
	SetScreen \{Aspect = 1.0}
	lock_cam_cube_dir \{dir = (1.0, 0.0, 0.0)}
	Wait \{16
		gameframes}
	ScreenShot \{filename = 'cubemap_screen_A'}
	Wait \{16
		gameframes}
	lock_cam_cube_dir \{dir = (-1.0, 0.0, 0.0)}
	Wait \{16
		gameframes}
	ScreenShot \{filename = 'cubemap_screen_B'}
	Wait \{16
		gameframes}
	lock_cam_cube_dir \{dir = (0.0, 1.0, 0.0)}
	Wait \{16
		gameframes}
	ScreenShot \{filename = 'cubemap_screen_C'}
	Wait \{16
		gameframes}
	lock_cam_cube_dir \{dir = (0.0, -1.0, 0.0)}
	Wait \{16
		gameframes}
	ScreenShot \{filename = 'cubemap_screen_D'}
	Wait \{16
		gameframes}
	lock_cam_cube_dir \{dir = (0.0, 0.0, 1.0)}
	Wait \{16
		gameframes}
	ScreenShot \{filename = 'cubemap_screen_F'}
	Wait \{16
		gameframes}
	lock_cam_cube_dir \{dir = (0.0, 0.0, -1.0)}
	Wait \{16
		gameframes}
	ScreenShot \{filename = 'cubemap_screen_E'}
	Wait \{16
		gameframes}
	SetScreen \{Aspect = 1.3333334}
	root_window :DoMorph \{alpha = 1}
	skater :unhide
	KillSkaterCamAnim \{all}
	change \{Show_Zone_budget_Warnings = 1}
	change \{no_render_metrics = 0}
endscript

script SpawnCubeMapScreenshots 
	SpawnScriptLater CubeMapScreenshots params = <...>
endscript

script lock_cam_top_down 
	KillSkaterCamAnim \{all}
	GetCurrentCameraObject
	<camid> :Obj_GetPosition
	<camid> :GetHFov
	PlayIGCCam {
		facing = (0.0, -1.0, 0.0)
		pos = <pos>
		FOV = <hfov>
		Play_hold
	}
endscript

script lock_cam_cube_dir \{dir = (1.0, 0.0, 0.0)}
	KillSkaterCamAnim \{all}
	GetCurrentCameraObject
	<camid> :Obj_GetPosition
	<camid> :GetHFov
	PlayIGCCam {
		facing = <dir>
		pos = <pos>
		FOV = 90.0
		Play_hold
	}
endscript
