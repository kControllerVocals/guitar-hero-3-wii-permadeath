WhammyWibble0 = [
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
]
WhammyWibble1 = [
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
	1.0
]

script star_power_reset 
	change structurename = <player_status> star_power_amount = 0.0
	change structurename = <player_status> star_power_sequence = 0
	change structurename = <player_status> star_power_note_count = 0
	change structurename = <player_status> star_power_used = 0
	change structurename = <player_status> current_star_array_entry = 0
endscript

script increase_star_power \{amount = 10.0
		player_status = player1_status}
	if ($game_mode = p2_career || $game_mode = p2_coop)

		increase_star_power_guts amount = <amount> player_status = player1_status
		increase_star_power_guts amount = <amount> player_status = player2_status
	else
		increase_star_power_guts amount = <amount> player_status = <player_status>
	endif
endscript

script increase_star_power_guts 
	if ($game_mode = p2_battle ||
			$boss_battle = 1)
		return
	endif
	if ($<player_status>.star_power_used = 1)
		return
	endif
	old_amount = ($<player_status>.star_power_amount)
	change structurename = <player_status> star_power_amount = ($<player_status>.star_power_amount + <amount>)
	if ($<player_status>.star_power_amount > 100)
		change structurename = <player_status> star_power_amount = 100
	endif
	if (<old_amount> < 50.0)
		if ($<player_status>.star_power_amount >= 50.0)
			ActivateStarPowerPulse player = ($<player_status>.controller) num = 2 length = 20 strength = 8 priority = 100
			change structurename = <player_status> num_star_power = ($<player_status>.num_star_power + 1)
			spawnscriptnow show_star_power_ready params = {player_status = <player_status>}
		endif
	endif
endscript
star_power_ready_on_p1 = 0
star_power_ready_on_p2 = 0

script show_star_power_ready 
	if ($Cheat_PerformanceMode = 1)
		return
	endif
	if ($game_mode = p2_career || $game_mode = p2_coop)
		<player_status> = player1_status
	endif
	SoundEvent \{event = Star_Power_Ready_SFX}
	spawnscriptnow rock_meter_star_power_on params = {player_status = <player_status>}
	FormatText checksumname = player_container 'HUD_Note_Streak_Combo%d' d = ($<player_status>.player)
	begin
	if NOT ScreenElementExists id = <player_container>
		break
	endif
	WaitOneGameFrame
	repeat
	if ($<player_status>.player = 1)
		if ($star_power_ready_on_p1 = 1)
			return
		else
			change \{star_power_ready_on_p1 = 1}
		endif
	else
		if ($star_power_ready_on_p2 = 1)
			return
		else
			change \{star_power_ready_on_p2 = 1}
		endif
	endif
	if ($<player_status>.star_power_used = 1)
		return
	endif
	ExtendCRC star_power_ready_text ($<player_status>.text) out = id
	if (($game_mode = p2_faceoff) || ($game_mode = p2_pro_faceoff))
		if ($<player_status>.player = 1)
			original_pos = (($hud_screen_elements [0].pos) - (225.0, 50.0))
		else
			original_pos = (($hud_screen_elements [0].pos) + (225.0, -50.0))
		endif
		base_scale = 0.8
		scale_big_mult = 1.2
	else
		if ($game_mode = p2_career || $game_mode = p2_coop)
			original_pos = (($hud_screen_elements [0].pos) - (0.0, 60.0))
		else
			original_pos = (($hud_screen_elements [0].pos) - (0.0, 20.0))
		endif
		base_scale = 1.2
		scale_big_mult = 1.5
	endif
	if ScreenElementExists id = <id>
		<id> :DoMorph pos = <original_pos> scale = 4 rgba = [190 225 255 250] alpha = 0 rot_angle = 3
	endif
	if ScreenElementExists id = <id>
		<id> :DoMorph pos = <original_pos> scale = <base_scale> alpha = 1 time = 0.3 rot_angle = -3 motion = ease_in
	endif
	if ScreenElementExists id = <id>
		<id> :DoMorph pos = <original_pos> scale = (<base_scale> * <scale_big_mult>) time = 0.3 rot_angle = 4 motion = ease_out
	endif
	if ScreenElementExists id = <id>
		<id> :DoMorph pos = <original_pos> scale = <base_scale> time = 0.3 rot_angle = -5 rgba = [145 215 235 250] motion = ease_in
	endif
	rotation = 10
	begin
	<rotation> = (<rotation> * -0.7)
	if ScreenElementExists id = <id>
		<id> :DoMorph pos = <original_pos> rot_angle = <rotation> alpha = 1 time = 0.08 motion = ease_out
	endif
	repeat 12
	if ScreenElementExists id = <id>
		<id> :DoMorph pos = <original_pos> rot_angle = 0 motion = ease_out
	endif
	if ScreenElementExists id = <id>
		<id> :DoMorph pos = (<original_pos> - (0.0, 230.0)) scale = (<base_scale> * 0.5) alpha = 0 time = 0.3 motion = ease_in
	endif
	if ($<player_status>.player = 1)
		change \{star_power_ready_on_p1 = 0}
	else
		change \{star_power_ready_on_p2 = 0}
	endif
endscript
showing_raise_axe = 0

script show_coop_raise_axe_for_starpower 
	if ($<player_status>.star_power_used = 1 ||
			$is_attract_mode = 1 || $showing_raise_axe = 1 || $Cheat_PerformanceMode = 1 || $playing_song = 0)
		return
	endif
	ActivateStarPowerPulse player = ($<player_status>.controller) num = 1 length = 10 strength = 11 priority = 1
	change \{showing_raise_axe = 1}
	ExtendCRC coop_raise_axe ($<player_status>.text) out = id
	ExtendCRC coop_raise_axe_cont ($<player_status>.text) out = id_cont
	if ($<player_status>.player = 1)
		original_pos = (($hud_screen_elements [10].pos) - (225.0, 60.0))
		original_pos_cont = (($hud_screen_elements [10].pos) - (225.0, 30.0))
	else
		original_pos = (($hud_screen_elements [10].pos) + (225.0, -60.0))
		original_pos_cont = (($hud_screen_elements [10].pos) + (225.0, -30.0))
	endif
	base_scale = 0.7
	base_scale_cont = 1
	if ScreenElementExists id = <id>
		doScreenElementMorph {
			id = <id>
			pos = <original_pos>
			scale = 0
			alpha = 1
		}
	endif
	if ScreenElementExists id = <id_cont>
		doScreenElementMorph {
			id = <id_cont>
			pos = <original_pos_cont>
			scale = 0
			alpha = 1
		}
	endif
	if ScreenElementExists id = <id>
		doScreenElementMorph id = <id> scale = <base_scale> time = 0.2
	endif
	if ScreenElementExists id = <id_cont>
		doScreenElementMorph id = <id_cont> scale = <base_scale_cont> time = 0.2
	endif
	Wait \{0.2
		seconds}
	if NOT ScreenElementExists id = <id>
		change \{showing_raise_axe = 0}
		return
	endif
	rotation = 4
	begin
	<rotation> = (<rotation> * -1)
	if ScreenElementExists id = <id>
		doScreenElementMorph {
			id = <id>
			rot_angle = <rotation>
			time = 0.1
		}
	endif
	if ScreenElementExists id = <id_cont>
		doScreenElementMorph {
			id = <id_cont>
			rot_angle = <rotation>
			time = 0.1
		}
	endif
	Wait \{0.13
		seconds}
	if NOT ScreenElementExists id = <id>
		change \{showing_raise_axe = 0}
		return
	endif
	repeat 8
	if ScreenElementExists id = <id>
		doScreenElementMorph id = <id> rot_angle = 0
	endif
	if ScreenElementExists id = <id_cont>
		doScreenElementMorph id = <id_cont> rot_angle = 0
	endif
	if ScreenElementExists id = <id>
		doScreenElementMorph {
			id = <id>
			pos = (<original_pos> - (0.0, 400.0))
			scale = (<base_scale> * 0.5)
			time = 0.35000002
		}
	endif
	if ScreenElementExists id = <id_cont>
		doScreenElementMorph {
			id = <id_cont>
			pos = (<original_pos_cont> - (0.0, 400.0))
			scale = (<base_scale_cont> * 0.5)
			time = 0.35000002
		}
	endif
	change \{showing_raise_axe = 0}
endscript

script star_power_hit_note 
	increase_star_power amount = $star_power_hit_note_score player_status = <player_status>
	change structurename = <player_status> star_power_note_count = ($<player_status>.star_power_note_count + 1)
	change structurename = <player_status> star_power_sequence = ($<player_status>.star_power_sequence + 1)
	BroadcastEvent type = star_hit_note data = {song = <song> array_entry = <array_entry> player_status = <player_status>}

	if (<sequence_count> = $<player_status>.star_power_sequence)
		if ($<player_status>.star_power_sequence > $star_power_sequence_min)
			if ($<player_status>.star_power_used = 0)

				BroadcastEvent type = star_sequence_bonus data = {song = <song> array_entry = <array_entry>}
				increase_star_power amount = $star_power_sequence_bonus player_status = <player_status>
			endif
		endif
	endif
endscript

script reset_star_sequence 
	change structurename = <player_status> star_power_sequence = 0
	change structurename = <player_status> star_power_note_count = 0
endscript

script star_power_miss_note 
	change structurename = <player_status> star_power_sequence = 0
	LaunchGemEvent event = star_miss_note player = <player>
	ExtendCRC star_miss_note <player_text> out = id
	BroadcastEvent type = <id> data = {song = <song> array_entry = <array_entry>}
endscript

script star_power_whammy 
	if ($<player_status>.star_power_used = 1)
		return
	endif
	last_x = 0
	last_y = 0
	dir_x = 1
	dir_y = 1
	first = 1
	whammy_on = 0
	whammy_star_on = 0
	whammy_star_off = 0
	ExtendCRC star_whammy_on <player_text> out = id
	BroadcastEvent type = <id> data = {pattern = <pattern> time = <time> guitar_stream = <guitar_stream> song = <song> array_entry = <array_entry> player = <player> player_status = <player_status> player_text = <player_text>}
	<boss> = 0
	if ($boss_battle = 1)
		if (($<player_status>.player) = 2)
			<boss> = 1
		endif
	endif
	<do_blue_whammys> = 1
	if ($game_mode = p2_battle || $boss_battle = 1)
		<do_blue_whammys> = 0
	endif
	begin
	if (($<player_status>.whammy_on) = 0)
		ExtendCRC star_whammy_off <player_text> out = id
		BroadcastEvent type = <id> data = {pattern = <pattern> time = <time> guitar_stream = <guitar_stream> song = <song> array_entry = <array_entry> player = <player> player_status = <player_status> player_text = <player_text> finished = 0}
		break
	endif
	if (<boss> = 0)
		if GuitarGetAnalogueInfo controller = ($<player_status>.controller)
			if IsGuitarController controller = ($<player_status>.controller)
				<px> = ((<rightx> - $<player_status>.resting_whammy_position) / (1.0 - $<player_status>.resting_whammy_position))
				if (<px> < 0)
					<px> = 0
				endif
				if (<first> = 1)
					<last_x> = <px>
					<first> = 0
				endif
				<xdiff> = (<px> - <last_x>)
				if (<xdiff> < 0)
					<xdiff> = (0.0 - <xdiff>)
				endif
				if (<xdiff> > 0.03)
					<whammy_on> = 5
				endif
			else
				<px> = 0
				<py> = 0
				if (<leftlength> > 0)
					<px> = <leftx>
					<py> = <lefty>
				else
					if (<rightlength> > 0)
						<px> = <rightx>
						<py> = <RightY>
					endif
				endif
				if (<first> = 1)
					<last_x> = <px>
					<last_y> = <py>
					<first> = 0
				endif
				<xdiff> = (<px> - <last_x>)
				if (<xdiff> < 0)
					<xdiff> = (0.0 - <xdiff>)
				endif
				<ydiff> = (<py> - <last_y>)
				if (<ydiff> < 0)
					<ydiff> = (0.0 - <ydiff>)
				endif
				if (<xdiff> > 0.03)
					<whammy_on> = 5
				endif
				if (<ydiff> > 0.03)
					<whammy_on> = 5
				endif
			endif
			if (<whammy_on> > 0)
				<whammy_star_off> = 0
				<whammy_star_on> = (<whammy_star_on> + 1)
				beat_time = ($<player_status>.playline_song_beat_time / 1000.0)
				beat_ratio = ($current_deltatime / <beat_time>)
				if ($game_mode = p2_career || $game_mode = p2_coop)
					increase_star_power amount = ($star_power_whammy_add_coop * <beat_ratio>) player_status = <player_status>
				else
					increase_star_power amount = ($star_power_whammy_add * <beat_ratio>) player_status = <player_status>
				endif
				whammy_on = (<whammy_on> - 1)
				if (<do_blue_whammys> = 1)
					if (<whammy_star_on> = 5)
						GetArraySize \{$gem_colors}
						gem_count = 0
						begin
						if ((<pattern> && $button_values [<gem_count>]) = $button_values [<gem_count>])
							FormatText checksumname = whammy_id '%c_%i_whammybar_p%p' c = ($gem_colors_text [<gem_count>]) i = <array_entry> p = ($<player_status>.player) AddToStringLookup = true
							if ScreenElementExists id = <whammy_id>
								bar_name = (<whammy_id> + 1)
								MakeStarWhammy name = <bar_name> player = ($<player_status>.player)
							endif
						endif
						gem_count = (<gem_count> + 1)
						repeat <array_size>
					endif
				endif
			else
				<whammy_star_on> = 0
				<whammy_star_off> = (<whammy_star_off> + 1)
				if (<do_blue_whammys> = 1)
					if (<whammy_star_off> = 5)
						GetArraySize \{$gem_colors}
						gem_count = 0
						begin
						if ((<pattern> && $button_values [<gem_count>]) = $button_values [<gem_count>])
							FormatText checksumname = whammy_id '%c_%i_whammybar_p%p' c = ($gem_colors_text [<gem_count>]) i = <array_entry> p = ($<player_status>.player) AddToStringLookup = true
							if ScreenElementExists id = <whammy_id>
								bar_name = (<whammy_id> + 1)
								MakeNormalWhammy name = <bar_name> player = ($<player_status>.player)
							endif
						endif
						gem_count = (<gem_count> + 1)
						repeat <array_size>
					endif
				endif
			endif
			<last_x> = <px>
			<last_y> = <py>
		endif
	endif
	<time> = (<time> - ($current_deltatime * 1000))
	if (<time> <= 0)
		ExtendCRC star_whammy_off <player_text> out = id
		BroadcastEvent type = <id> data = {pattern = <pattern> time = <time> guitar_stream = <guitar_stream> song = <song> array_entry = <array_entry> player = <player> player_status = <player_status> player_text = <player_text> finished = 1}
		break
	endif
	WaitOneGameFrame
	repeat
endscript

script reset_star_array 
	get_song_struct song = <song_name>
	if (($<player_status>.part) = rhythm)
		<part> = 'rhythm_'
	else
		<part> = ''
	endif
	if ($game_mode = p2_career || $game_mode = p2_coop ||
			($game_mode = training && ($<player_status>.part = rhythm)))
		if StructureContains Structure = <song_struct> use_coop_notetracks
			if (($<player_status>.part) = rhythm)
				<part> = 'rhythmcoop_'
			else
				<part> = 'guitarcoop_'
			endif
		endif
	endif
	get_song_prefix song = <song_name>
	get_difficulty_text_nl difficulty = <difficulty>
	if ($game_mode = p2_battle ||
			$boss_battle = 1)
		FormatText checksumname = song '%s_%p%d_starbattlemode' s = <song_prefix> p = <part> d = <difficulty_text_nl> AddToStringLookup
		change structurename = <player_status> sp_phrases_total = 0
	else
		FormatText checksumname = song '%s_%p%d_star' s = <song_prefix> p = <part> d = <difficulty_text_nl> AddToStringLookup
	endif
	change structurename = <player_status> current_song_star_array = <song>
	change structurename = <player_status> current_star_array_entry = 0
endscript

script is_star_note \{time = 0}
	star_array = ($<player_status>.current_song_star_array)
	GetArraySize $<star_array>
	if (<array_size> = 0)
		return \{false
			star_count = 0}
	endif
	star_start = ($<star_array> [($<player_status>.current_star_array_entry)] [0])
	star_end = (($<star_array> [($<player_status>.current_star_array_entry)] [1]) + <star_start>)
	star_count = ($<star_array> [($<player_status>.current_star_array_entry)] [2])
	if (<time> >= <star_start>)
		if (<time> <= <star_end>)
			return true star_count = <star_count>
		endif
	endif
	if (<time> > <star_end>)
		if ($<player_status>.current_star_array_entry < (<array_size> - 1))
			change structurename = <player_status> current_star_array_entry = ($<player_status>.current_star_array_entry + 1)
		endif
	endif
	return false star_count = <star_count>
endscript
spCaseyShoot = 0

script Do_StarPower_ShotgunFX 
	begin
	if ($spCaseyShoot = 1)
		FormatText checksumname = shotgunID '%p_StarPower_ShotgunFXShotgunID' p = <player_text>
		SafeGetUniqueCompositeObjectID ObjID = (<player_status>.band_member) preferredID = <shotgunID>
		CreateParticleSystem name = <uniqueID> ObjID = (<player_status>.band_member) bone = bone_guitar_neck params_Script = $GP_StarPower_Shotgun01
		FormatText checksumname = smokeID '%p_StarPower_ShotgunFXSmokeID' p = <player_text>
		SafeGetUniqueCompositeObjectID ObjID = (<player_status>.band_member) preferredID = <smokeID>
		CreateParticleSystem name = <uniqueID> ObjID = (<player_status>.band_member) bone = bone_guitar_neck params_Script = $GP_StarPower_ShotgunSmoke01
		change \{spCaseyShoot = 0}
	endif
	Wait \{1
		frame}
	repeat
endscript

script StarPower_ShootShotGun 
	change \{spCaseyShoot = 1}
endscript
spJohnnyFlamesOn = 0
spJohnnyFlamesDur = 0

script Do_StarPower_FlameThrowerFX 
	(<player_status>.band_member) :Obj_GetBonePosition bone = Bone_Pelvis
	bonePos = (<x> * (1.0, 0.0, 0.0) + <y> * (0.0, 1.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	FormatText checksumname = anarchy01ID '%p_StarPower_FlameThrowerFXAnarchy01ID' p = <player_text>
	CreateParticleSystem name = <anarchy01ID> ObjID = (<player_status>.band_member) bone = Bone_Pelvis params_Script = $GP_StarPower_FlameThrowerAnarchy01
	WaitOneGameFrame
	begin
	if ($spJohnnyFlamesOn = 1)
		FormatText checksumname = flameThrowerID '%p_StarPower_FlameThrowerFXFlameThrowerID' p = <player_text>
		CreateParticleSystem name = <flameThrowerID> ObjID = (<player_status>.band_member) bone = bone_guitar_neck params_Script = {$GP_StarPower_FlameThrower01 lifeTime = $spJohnnyFlamesDur}
		change \{spJohnnyFlamesOn = 0}
		break
	endif
	Wait \{1
		frame}
	repeat
endscript

script StarPower_FlameThrowerFlames 
	change spJohnnyFlamesDur = <emitDur>
	change \{spJohnnyFlamesOn = 1}
endscript

script Do_StarPower_HeartsFX 
	(<player_status>.band_member) :Obj_GetBonePosition bone = Bone_Pelvis
	bonePos = (<x> * (1.0, 0.0, 0.0) + <y> * (0.0, 1.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	GetUniqueCompositeObjectID \{preferredID = heartsPoofID01}
	CreateParticleSystem name = <uniqueID> pos = <bonePos> params_Script = $GP_StarPower_HeartsPoof01
	WaitOneGameFrame
	FormatText checksumname = heartsID '%p_StarPower_HeartsFXHeartsID' p = <player_text>
	CreateParticleSystem name = <heartsID> ObjID = (<player_status>.band_member) bone = Bone_Pelvis params_Script = $GP_StarPower_Hearts01
	WaitOneGameFrame
	FormatText checksumname = swirlID '%p_StarPower_HeartsFXSwirlID' p = <player_text>
	CreateParticleSystem name = <swirlID> ObjID = (<player_status>.band_member) bone = Bone_Pelvis params_Script = $GP_StarPower_HeartsSwirl01
	FormatText checksumname = windID '%p_StarPower_HeartsFXWindID' p = <player_text>
	EngineWind create = {
		name = <windID>
		type = Twist
		pos = <bonePos>
		velocity = (0.0, 0.2, 0.0)
		Speed = 8
		tangentWeight = 0.4
		range = 7
		attenuation = INV_DISTANCE
		time = 0
	}
	begin
	(<player_status>.band_member) :Obj_GetBonePosition bone = Bone_Pelvis
	bonePos = (<x> * (1.0, 0.0, 0.0) + <y> * (0.0, 1.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	EngineWind modify = {
		name = <windID>
		pos = <bonePos>
	}
	Wait \{0.05
		seconds}
	repeat
endscript

script Do_StarPower_BatFX 
	(<player_status>.band_member) :Obj_GetBonePosition bone = Bone_Pelvis
	bonePos = (<x> * (1.0, 0.0, 0.0) + <y> * (0.0, 1.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	GetUniqueCompositeObjectID \{preferredID = batPoofID01}
	CreateParticleSystem name = <uniqueID> pos = <bonePos> params_Script = $GP_StarPower_BatsPoof01
	WaitOneGameFrame
	FormatText checksumname = batID '%p_StarPower_BatFXBatID' p = <player_text>
	CreateParticleSystem name = <batID> ObjID = (<player_status>.band_member) bone = Bone_Pelvis params_Script = $GP_StarPower_Bats01
	WaitOneGameFrame
	FormatText checksumname = swirlID '%p_StarPower_BatFXSwirlID' p = <player_text>
	CreateParticleSystem name = <swirlID> ObjID = (<player_status>.band_member) bone = Bone_Pelvis params_Script = $GP_StarPower_BatsSwirl01
	FormatText checksumname = windID '%p_StarPower_BatFXWindID' p = <player_text>
	EngineWind create = {
		name = <windID>
		type = Twist
		pos = <bonePos>
		velocity = (0.0, 0.2, 0.0)
		Speed = 8
		tangentWeight = 0.4
		range = 7
		attenuation = INV_DISTANCE
		time = 0
	}
	begin
	(<player_status>.band_member) :Obj_GetBonePosition bone = Bone_Pelvis
	bonePos = (<x> * (1.0, 0.0, 0.0) + <y> * (0.0, 1.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	EngineWind modify = {
		name = <windID>
		pos = <bonePos>
	}
	Wait \{0.05
		seconds}
	repeat
endscript

script Do_StarPower_ButterfliesFX 
	(<player_status>.band_member) :Obj_GetBonePosition bone = Bone_Pelvis
	bonePos = (<x> * (1.0, 0.0, 0.0) + <y> * (0.0, 1.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	GetUniqueCompositeObjectID \{preferredID = ButterfliesPoofID01}
	CreateParticleSystem name = <uniqueID> pos = <bonePos> params_Script = $GP_StarPower_ButterfliesPoof01
	WaitOneGameFrame
	FormatText checksumname = butterfliesID '%p_StarPower_ButterfliesFXButterfliesID01' p = <player_text>
	CreateParticleSystem name = <butterfliesID> ObjID = (<player_status>.band_member) bone = Bone_Pelvis params_Script = $GP_StarPower_Butterflies01
	WaitOneGameFrame
	FormatText checksumname = butterfliesID '%p_StarPower_ButterfliesFXButterfliesID02' p = <player_text>
	CreateParticleSystem name = <butterfliesID> ObjID = (<player_status>.band_member) bone = Bone_Pelvis params_Script = $GP_StarPower_Butterflies01
	WaitOneGameFrame
	FormatText checksumname = swirlID '%p_StarPower_ButterfliesFXSwirlID' p = <player_text>
	CreateParticleSystem name = <swirlID> ObjID = (<player_status>.band_member) bone = Bone_Pelvis params_Script = $GP_StarPower_ButterfliesSwirl01
	FormatText checksumname = windID '%p_StarPower_ButterfliesFXWindID' p = <player_text>
	EngineWind create = {
		name = <windID>
		type = Twist
		pos = <bonePos>
		velocity = (0.0, 0.1, 0.0)
		Speed = 6
		tangentWeight = 0.4
		range = 7
		attenuation = INV_DISTANCE
		time = 0
	}
	begin
	(<player_status>.band_member) :Obj_GetBonePosition bone = Bone_Pelvis
	bonePos = (<x> * (1.0, 0.0, 0.0) + <y> * (0.0, 1.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	EngineWind modify = {
		name = <windID>
		pos = <bonePos>
	}
	Wait \{0.05
		seconds}
	repeat
endscript

script Do_StarPower_PeaceFX 
	(<player_status>.band_member) :Obj_GetBonePosition bone = Bone_Pelvis
	bonePos = (<x> * (1.0, 0.0, 0.0) + <y> * (0.0, 1.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	GetUniqueCompositeObjectID \{preferredID = peacePoofID01}
	CreateParticleSystem name = <uniqueID> pos = <bonePos> params_Script = $GP_StarPower_PeacePoof01
	WaitOneGameFrame
	FormatText checksumname = peaceID '%p_StarPower_PeaceFXPeaceID' p = <player_text>
	CreateParticleSystem name = <peaceID> ObjID = (<player_status>.band_member) bone = Bone_Pelvis params_Script = $GP_StarPower_Peace01
	WaitOneGameFrame
	FormatText checksumname = swirlID '%p_StarPower_PeaceFXSwirlID' p = <player_text>
	CreateParticleSystem name = <swirlID> ObjID = (<player_status>.band_member) bone = Bone_Pelvis params_Script = $GP_StarPower_PeaceSwirl01
	FormatText checksumname = windID '%p_StarPower_PeaceFXWindID' p = <player_text>
	EngineWind create = {
		name = <windID>
		type = Twist
		pos = <bonePos>
		velocity = (0.0, 0.1, 0.0)
		Speed = 4
		tangentWeight = 0.4
		range = 7
		attenuation = INV_DISTANCE
		time = 0
	}
	begin
	(<player_status>.band_member) :Obj_GetBonePosition bone = Bone_Pelvis
	bonePos = (<x> * (1.0, 0.0, 0.0) + <y> * (0.0, 1.0, 0.0) + <z> * (0.0, 0.0, 1.0))
	EngineWind modify = {
		name = <windID>
		pos = <bonePos>
	}
	Wait \{0.05
		seconds}
	repeat
endscript

script Kill_StarPower_StageFX \{ifEmpty = 1}
	FormatText checksumname = scriptID '%p_StarPower_StageFX' p = <player_text>
	KillSpawnedScript id = <scriptID>
	switch (<player_status>.character_id)
		case Casey
		change \{spCaseyShoot = 0}
		case Johnny
		FormatText checksumname = flameThrowerID '%p_StarPower_FlameThrowerFXFlameThrowerID' p = <player_text>
		MangleChecksums a = <flameThrowerID> b = (<player_status>.band_member) p = <player_text>
		if IsCreated <mangled_ID>
			<mangled_ID> :EmitRate rate = 0
			<mangled_ID> :destroy ifEmpty = <ifEmpty>
		endif
		FormatText checksumname = anarchy01ID '%p_StarPower_FlameThrowerFXAnarchy01ID' p = <player_text>
		MangleChecksums a = <anarchy01ID> b = (<player_status>.band_member)
		if IsCreated <mangled_ID>
			<mangled_ID> :EmitRate rate = 0
			<mangled_ID> :destroy ifEmpty = <ifEmpty>
		endif
		change \{spJohnnyFlamesOn = 0}
		case judy
		FormatText checksumname = heartsID '%p_StarPower_HeartsFXHeartsID' p = <player_text>
		MangleChecksums a = <heartsID> b = (<player_status>.band_member)
		if IsCreated <mangled_ID>
			<mangled_ID> :EmitRate rate = 0
			<mangled_ID> :destroy ifEmpty = <ifEmpty>
		endif
		FormatText checksumname = swirlID '%p_StarPower_HeartsFXSwirlID' p = <player_text>
		MangleChecksums a = <swirlID> b = (<player_status>.band_member)
		if IsCreated <mangled_ID>
			<mangled_ID> :EmitRate rate = 0
			<mangled_ID> :destroy ifEmpty = <ifEmpty>
		endif
		FormatText checksumname = windID '%p_StarPower_HeartsFXWindID' p = <player_text>
		EngineWind remove <windID>
		case Lars
		case RIPPER
		case satan
		FormatText checksumname = batID '%p_StarPower_BatFXBatID' p = <player_text>
		MangleChecksums a = <batID> b = (<player_status>.band_member)
		if IsCreated <mangled_ID>
			<mangled_ID> :EmitRate rate = 0
			<mangled_ID> :destroy ifEmpty = <ifEmpty>
		endif
		FormatText checksumname = swirlID '%p_StarPower_BatFXSwirlID' p = <player_text>
		MangleChecksums a = <swirlID> b = (<player_status>.band_member)
		if IsCreated <mangled_ID>
			<mangled_ID> :EmitRate rate = 0
			<mangled_ID> :destroy ifEmpty = <ifEmpty>
		endif
		FormatText checksumname = windID '%p_StarPower_BatFXWindID' p = <player_text>
		EngineWind remove <windID>
		case Midori
		FormatText checksumname = butterfliesID '%p_StarPower_ButterfliesFXButterfliesID01' p = <player_text>
		MangleChecksums a = <butterfliesID> b = (<player_status>.band_member)
		if IsCreated <mangled_ID>
			<mangled_ID> :EmitRate rate = 0
			<mangled_ID> :destroy ifEmpty = <ifEmpty>
		endif
		FormatText checksumname = butterfliesID '%p_StarPower_ButterfliesFXButterfliesID02' p = <player_text>
		MangleChecksums a = <butterfliesID> b = (<player_status>.band_member)
		if IsCreated <mangled_ID>
			<mangled_ID> :EmitRate rate = 0
			<mangled_ID> :destroy ifEmpty = <ifEmpty>
		endif
		FormatText checksumname = swirlID '%p_StarPower_ButterfliesFXSwirlID' p = <player_text>
		MangleChecksums a = <swirlID> b = (<player_status>.band_member)
		if IsCreated <mangled_ID>
			<mangled_ID> :EmitRate rate = 0
			<mangled_ID> :destroy ifEmpty = <ifEmpty>
		endif
		FormatText checksumname = windID '%p_StarPower_ButterfliesFXWindID' p = <player_text>
		EngineWind remove <windID>
		case Xavier
		FormatText checksumname = peaceID '%p_StarPower_PeaceFXPeaceID' p = <player_text>
		MangleChecksums a = <peaceID> b = (<player_status>.band_member)
		if IsCreated <mangled_ID>
			<mangled_ID> :EmitRate rate = 0
			<mangled_ID> :destroy ifEmpty = <ifEmpty>
		endif
		FormatText checksumname = swirlID '%p_StarPower_PeaceFXSwirlID' p = <player_text>
		MangleChecksums a = <swirlID> b = (<player_status>.band_member)
		if IsCreated <mangled_ID>
			<mangled_ID> :EmitRate rate = 0
			<mangled_ID> :destroy ifEmpty = <ifEmpty>
		endif
		FormatText checksumname = windID '%p_StarPower_PeaceFXWindID' p = <player_text>
		EngineWind remove <windID>
		default
		if (<ifEmpty> = 0)
			DestroyParticlesByGroupID \{groupID = starPowerFX}
		endif
		i = 1
		begin
		FormatText checksumname = scriptID '%p_StarPower_TeslaFX%i' p = <player_text> i = <i>
		FormatText checksumname = teslaFXID '%p_StarPower_TeslaFXID%i' p = <player_text> i = <i>
		KillSpawnedScript id = <scriptID>
		DeleteTeslaEffectObject name = <teslaFXID>
		i = (<i> + 1)
		repeat 4
	endswitch
endscript
using_starpower_camera = false

script Do_StarPower_Camera 
	if ($using_starpower_camera = true || $using_walk_camera = true)
		return
	endif
	change \{using_starpower_camera = true}
	WaitOneGameFrame
	change \{CameraCuts_AllowNoteScripts = false}
	CameraCuts_SetArrayPrefix \{prefix = 'cameras_starpower'
		changetime = 2500
		length = 7000}
	Wait \{7
		seconds}
	CameraCuts_SetArrayPrefix \{prefix = 'cameras'}
	change \{CameraCuts_AllowNoteScripts = true}
	change \{using_starpower_camera = false}
endscript

script Kill_StarPower_Camera \{changecamera = 1}
	if ($using_starpower_camera = false)
		return
	endif
	KillSpawnedScript \{name = Do_StarPower_Camera}
	if (<changecamera> = 1)
		CameraCuts_SetArrayPrefix \{prefix = 'cameras'}
	endif
	change \{CameraCuts_AllowNoteScripts = true}
	change \{using_starpower_camera = false}
endscript
