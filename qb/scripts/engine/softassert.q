enable_soft_asserts = 0
soft_assert_active = 0

script soft_assert 
	DumpHeaps
	printstruct <...>
	printf 'SOFT ASSERT: %s' s = <reason>
	if IsTrue \{$enable_soft_asserts}
		if IsTrue \{$soft_assert_active}
			printf \{'Soft Assert already active, ignoring!'}
		else
			pause_game = 1
			if GlobalExists \{type = Integer
					name = view_mode}
				if ($view_mode > 0)
					pause_game = 0
				endif
			endif
			if (<pause_game> = 1)
				if GameIsPaused
					FormatText TextName = full_message 'SOFT ASSERT: %r (game was paused, so promoted to hard assert)' r = <reason>
					ScriptAssert <full_message>
				endif
				PauseMusic \{1}
				PauseStream \{1}
				PauseGame
			endif
			change \{soft_assert_active = 1}
			startrendering
			Hideloadingscreen
			ScreenShot \{filename = 'Assert'}
			soft_assert_message <...>
		endif
	endif
endscript

script soft_assert_keep_player_paused 
	MangleChecksums \{a = 0
		b = 0}
	begin
	if CompositeObjectExists name = <mangled_ID>
		<mangled_ID> :Pause
	endif
	WaitOneGameFrame
	repeat
endscript

script soft_assert_confirm 
	unpause_game = 1
	if GlobalExists \{type = Integer
			name = view_mode}
		if ($view_mode > 0)
			unpause_game = 0
		endif
	endif
	if (<unpause_game> = 1)
		UnPauseGame
		PauseMusic \{0}
		PauseStream \{0}
	endif
	change \{soft_assert_active = 0}
	DestroyScreenElement \{id = soft_assert_anchor}
endscript

script soft_assert_message \{message = ''}
	if GotParam \{file}
		FormatText TextName = message '%m\\c2File:\\c0 %f\\n' m = <message> f = <file>
	endif
	if GotParam \{line}
		FormatText TextName = message '%m\\c2Line:\\c0 %l\\n' m = <message> l = <line>
	endif
	if GotParam \{sig}
		FormatText TextName = message '%m\\c2Signature:\\c0 %s\\n' m = <message> s = <sig>
	endif
	if GotParam \{reason}
		FormatText TextName = message '%m\\n\\c2Message:\\c0 %r\\n' m = <message> r = <reason>
	endif
	if ScreenElementExists \{id = soft_assert_anchor}
		DestroyScreenElement \{id = soft_assert_anchor}
	endif
	SetScreenElementLock \{id = root_window
		off}
	top = (0.0, 40.0)
	CreateScreenElement \{type = ContainerElement
		id = soft_assert_anchor
		parent = root_window
		z_priority = 10000}
	CreateScreenElement \{type = SpriteElement
		parent = soft_assert_anchor
		rgba = [
			0
			0
			0
			70
		]
		dims = (1280.0, 720.0)
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	CreateScreenElement {
		type = TextElement
		parent = soft_assert_anchor
		font = text_a1
		text = '\\c2ASSERTION:'
		rgba = [255 255 255 255]
		alpha = 1
		scale = 0.65000004
		pos = ((640.0, 0.0) + <top>)
		just = [center top]
		z_priority = 10002
	}
	if ($highdefviewer = 1)
		<this_text_scale> = 0.45000002
	else
		<this_text_scale> = 0.6
	endif
	CreateScreenElement {
		type = TextBlockElement
		parent = soft_assert_anchor
		font = text_a1
		text = <message>
		rgba = [255 255 255 255]
		alpha = 1
		scale = <this_text_scale>
		pos = ((100.0, 50.0) + <top>)
		dims = (880.0, 0.0)
		allow_expansion
		just = [left top]
		internal_just = [left top]
	}
	GetScreenElementDims id = <id>
	if GotParam \{callstack}
		dim_h = (325 - <Height>)
		if (<dim_h> < 100)
			dim_h = 100
		endif
		CreateScreenElement {
			type = VScrollingMenu
			parent = soft_assert_anchor
			id = soft_assert_callstack_v
			just = [left top]
			pos = ((120.0, 90.0) + (<Height> * (0.0, 0.85)))
			dims = ((840.0, 0.0) + (<dim_h> * (0.0, 1.0)))
			z_priority = 10005
		}
		CreateScreenElement \{type = VMenu
			id = soft_assert_callstack
			parent = soft_assert_callstack_v
			internal_just = [
				left
				top
			]
			dont_allow_wrap}
		GetArraySize <callstack>
		i = 0
		begin
		CreateScreenElement {
			type = TextBlockElement
			parent = soft_assert_callstack
			font = text_a1
			text = (<callstack> [<i>])
			rgba = [160 160 255 255]
			scale = <this_text_scale>
			just = [left top]
			dims = (880.0, 0.0)
			allow_expansion
			internal_just = [left top]
		}
		i = (<i> + 1)
		repeat <array_size>
		Height = 330
		LaunchEvent \{type = focus
			target = soft_assert_callstack}
	endif
	CreateScreenElement {
		type = SpriteElement
		parent = soft_assert_anchor
		rgba = [0 0 0 70]
		dims = (1100.0, 720.0)
		pos = ((640.0, 0.0) + <top>)
		just = [center top]
	}
	create_helper_text \{helper_text_elements = [
			{
				text = '\\be - \\bf - \\be = Continue'
			}
		]
		parent = soft_assert_anchor
		z_priority = 10004}
	soft_assert_input
	LaunchEvent \{type = focus
		target = soft_assert_anchor}
	RunScriptOnScreenElement \{id = soft_assert_anchor
		soft_assert_keep_player_paused}
endscript

script soft_assert_input \{step = 0}
	steps = [
		{event_name = pad_l1 button_name = L1}
		{event_name = pad_r1 button_name = R1}
		{event_name = pad_l1 button_name = L1}
	]
	if GotParam \{Wait}
		Wait <Wait> seconds
	endif
	GetArraySize <steps>
	if NOT (<step> < <array_size>)
		i = 0
		begin
		Debounce (<steps> [<i>].button_name)
		ControllerDebounce (<steps> [<i>].button_name)
		i = (<i> + 1)
		repeat <array_size>
		goto \{soft_assert_confirm}
	endif
	i = 0
	begin
	if (<step> = <i>)
		event_handlers = [{(<steps> [<i>].event_name) soft_assert_input params = {step = (<step> + 1)}}]
	else
		event_handlers = [{(<steps> [<i>].event_name) nullscript}]
	endif
	soft_assert_anchor :SetProps event_handlers = <event_handlers> replace_handlers
	i = (<i> + 1)
	if GotParam \{reset}
		if NOT (<i> < <array_size>)
			goto \{soft_assert_input}
		endif
	else
		if (<i> > <step>)
			break
		endif
	endif
	repeat
	soft_assert_anchor :Obj_KillSpawnedScript \{name = soft_assert_input}
	soft_assert_anchor :Obj_SpawnScriptLater \{soft_assert_input
		params = {
			Wait = 0.3
			reset
		}}
endscript
