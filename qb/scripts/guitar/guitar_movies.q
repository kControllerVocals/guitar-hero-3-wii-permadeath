Z_Video_movie_viewport = {
	id = movie1_viewport
	texture = viewport9
	textureasset = `tex/zones/Video_shoot/Video_test.dds`
	texdict = `zones/z_video/z_video.tex`
	TextureSlot = 0
	movie = 'encore_video_shoot'
	start_frame = 0
	loop_start = 0
	loop_end = -1
	viewport_style = cutscene_movie_surface
}
Z_Video_movie_viewport_ps3 = {
	id = movie1_viewport
	texture = viewport9
	textureasset = `tex/zones/Video_shoot/Video_test.dds`
	texdict = `zones/z_video/z_video.tex`
	TextureSlot = 0
	movie = 'encore_video_shoot'
	start_frame = 0
	loop_start = 0
	loop_end = -1
	viewport_style = cutscene_movie_surface_ps3
}

script create_movie_viewport 
	return
	GetPakManCurrentName \{map = zones}
	if IsPs3
		FormatText checksumname = movie_viewport '%s_movie_viewport_ps3' s = <pakname>
	else
		FormatText checksumname = movie_viewport '%s_movie_viewport' s = <pakname>
	endif
	if NOT GlobalExists name = <movie_viewport>
		return
	endif
	CreateScreenElement {
		parent = root_window
		just = [center center]
		type = ViewportElement
		id = ($<movie_viewport>.id)
		texture = ($<movie_viewport>.texture)
		pos = (2000.0, 200.0)
		dims = (64.0, 64.0)
		alpha = 1
		style = ($<movie_viewport>.viewport_style)
	}
	SetSearchAllAssetContexts
	CreateViewportTextureOverride {
		id = ($<movie_viewport>.id)
		viewportid = ($<movie_viewport>.id)
		texture = ($<movie_viewport>.textureasset)
		texdict = ($<movie_viewport>.texdict)
	}
	SetSearchAllAssetContexts \{off}
endscript

script destroy_movie_viewport 
	GetPakManCurrentName \{map = zones}
	FormatText checksumname = movie_viewport '%s_movie_viewport' s = <pakname>
	if NOT GlobalExists name = <movie_viewport>
		return
	endif
	KillMovie TextureSlot = ($<movie_viewport>.TextureSlot)
	if ScreenElementExists id = ($<movie_viewport>.id)
		SetSearchAllAssetContexts
		DestroyViewportTextureOverride id = ($<movie_viewport>.id)
		SetSearchAllAssetContexts \{off}
		DestroyScreenElement id = ($<movie_viewport>.id)
	endif
	KillSpawnedScript \{id = movie_scripts}
endscript

script PauseFullScreenMovie 
	if IsMoviePlaying \{TextureSlot = 0}
		PauseMovie \{TextureSlot = 0}
	endif
endscript

script UnPauseFullScreenMovie 
	if IsMoviePlaying \{TextureSlot = 0}
		ResumeMovie \{TextureSlot = 0}
	endif
endscript

script PlayMovieAndWait 
	if IsNgc
		hide_fps_wii
		fps_hidden = true
	endif
	if NotCD
		if ($show_movies = 0)
			return
		endif
	endif
	mark_unsafe_for_shutdown
	if NOT GotParam \{noblack}
		fadetoblack \{on
			time = 0
			alpha = 1.0
			z_priority = -10}
	endif
	if NOT GotParam \{noletterbox}
		GetDisplaySettings
		if (<widescreen> = true)
			SetScreen \{hardware_letterbox = 0}
		else
			SetScreen \{hardware_letterbox = 1}
		endif
	endif
	if NOT (SkipMovies = 1)
		pre_movie_cleanup

		PlayMovie {TextureSlot = 0
			TexturePri = 1000
			no_looping
			no_hold
			<...>}
		post_movie_reset reset_state = <reset_state>
		Wait \{2
			gameframes}
		if GotParam \{noblack}
			fadetoblack \{off
				time = 0}
		endif
	endif
	NotHeld = 0
	begin
	if NOT IsMoviePlaying \{TextureSlot = 0}
		break
	endif
	GetButtonsPressed \{StartAndA}
	if NOT (<makes> = 0)
		if (<NotHeld> = 1)
			KillMovie \{TextureSlot = 0}
			break
		endif
	else
		NotHeld = 1
	endif
	WaitOneGameFrame
	repeat
	if NOT GotParam \{noblack}
		Wait \{2
			gameframes}

		fadetoblack \{off
			time = 0}
	endif
	if NOT GotParam \{noletterbox}
		SetScreen \{hardware_letterbox = 0}
	endif
	mark_safe_for_shutdown
	if IsNgc
		show_fps_wii
		fps_hidden = false
	endif
endscript
