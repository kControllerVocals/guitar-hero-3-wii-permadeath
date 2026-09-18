igc_custom_camera_name = custom_igc_cam

script PlayIGCCamScene 
	hide_all_hud_sprites
	PlayIGCCam {
		name = $igc_custom_camera_name
		<...>
		exitscript = show_all_hud_sprites
		allow_pause = 1
	}
endscript

script PlayIGCCamSceneWithHUD 
	PlayIGCCam {
		<...>
		allow_pause = 1
	}
endscript

script freeze_skater_for_cinematic 
	skater :SwitchOffAtomic \{Board}
	skater :PausePhysics
	skater :Pause
	skater :Disableplayerinput
	skater :SkaterLoopingSound_TurnOff
endscript

script unfreeze_skater_after_cinematic 
	skater :UnPausePhysics
	skater :Enableplayerinput
	skater :UnPause
	skater :Input_Debounce \{x}
	if NOT skater :walking
		skater :SkaterLoopingSound_TurnOn
	endif
endscript

script fadetoblack \{time = 0.5
		alpha = 0.5
		z_priority = 9000
		rgba = [
			0
			0
			0
			255
		]
		scale = (600.0, 400.0)
		texture = black
		id = screenfader
		pos = (320.0, 240.0)
		parent = root_window}
	if GotParam \{on}
		if NOT ScreenElementExists id = <id>
			SetScreenElementLock off id = <parent>
			if NOT GotParam \{create_script}
				CreateScreenElement {
					type = SpriteElement
					parent = <parent>
					id = <id>
					texture = <texture>
					pos = <pos>
					rgba = <rgba>
					just = [center center]
					scale = <scale>
					alpha = 0
					z_priority = <z_priority>
					no_zwrite
				}
			else
				<create_script>
			endif
		else
			TerminateObjectsScripts id = <id>
			<id> :RemoveTags [waiting_to_die]
		endif
		doScreenElementMorph id = <id> time = <time> alpha = <alpha>
	endif
	if GotParam \{off}
		if ScreenElementExists id = <id>
			doScreenElementMorph id = <id> time = <time> alpha = 0
			if GotParam \{no_wait}
				RunScriptOnScreenElement id = <id> fadetoblack_wait_and_die params = {time = <time>}
			else
				<id> :SetTags waiting_to_die
				if (<time> > 0.0)

					Wait <time> seconds
				endif
				if ScreenElementExists id = <id>
					if <id> :GetSingleTag waiting_to_die
						DestroyScreenElement id = <id>
					endif
				endif
			endif
		endif
	endif
endscript

script fadetoblack_wait_and_die 
	if GotParam \{time}
		Wait <time> seconds
	endif
	Die
endscript

script igc_fadeout \{time = 0.75}
	fadetoblack on alpha = 1.0 time = <time>
	Wait (<time> + 0.1) seconds
endscript

script igc_fadeout_fast 
	fadetoblack \{on
		alpha = 1.0
		time = 0.0}
endscript

script igc_fadein_fast 
	fadetoblack \{off
		time = 0.0}
endscript

script igc_fadein \{time = 0.75}
	fadetoblack off time = <time> no_wait
endscript
