points_per_note = {
	easy = 50.0
	medium = 50.0
	hard = 50.0
	expert = 50.0
}
points_per_note_per_beat = {
	easy = 25.0
	medium = 25.0
	hard = 25.0
	expert = 25.0
}

script reset_score 
	change structurename = <player_status> score = 0
	change structurename = <player_status> notes_hit = 0
	change structurename = <player_status> total_notes = 0
	change structurename = <player_status> best_run = 0
	change structurename = <player_status> current_run = 0
	change structurename = <player_status> num_star_power = 0
	change structurename = <player_status> num_star_power_used = 0
	change structurename = <player_status> sp_phrases_hit = 0
	change structurename = <player_status> multiplier_count = 0
	change structurename = <player_status> num_multiplier = 0
	change structurename = <player_status> time_in_lead = 0.0
	last_time_in_lead = 0.0
	last_time_in_lead_player = -1
	get_song_prefix song = ($current_song)
	FormatText checksumname = song_section_array '%s_markers' s = <song_prefix>
	change current_section_array = <song_section_array>
	change \{current_section_array_entry = 0}
	FormatText checksumname = detailstats_array '%s_last_song_detailed_stats' s = (<player_status>.text)
	change structurename = <player_status> current_detailedstats_array_entry = 0
	change structurename = <player_status> current_detailedstats_array = <detailstats_array>
	FormatText checksumname = detailstats_array_max '%s_last_song_detailed_stats_max' s = (<player_status>.text)
	change structurename = <player_status> current_detailedstats_max_array = <detailstats_array_max>
	GetArraySize ($<detailstats_array>)
	array_count = 0
	begin
	SetArrayElement ArrayName = <detailstats_array> GlobalArray index = <array_count> newvalue = 0
	SetArrayElement ArrayName = <detailstats_array_max> GlobalArray index = <array_count> newvalue = 0
	array_count = (<array_count> + 1)
	repeat <array_size>
	change \{whammy_mania_achievement_invalidated = 0}
endscript

script calc_songscoreinfo \{player_status = player1_status}
	get_song_prefix song = ($current_song)
	CalcSongScoreInfo <...>
	return
endscript

script hit_note 
	change structurename = <player_status> notes_hit = ($<player_status>.notes_hit + 1)
	change structurename = <player_status> current_run = ($<player_status>.current_run + 1)
	change structurename = <player_status> total_notes = ($<player_status>.total_notes + 1)
	if ($<player_status>.current_run > $<player_status>.best_run)
		change structurename = <player_status> best_run = ($<player_status>.current_run)
	endif
	get_current_multiplier player_status = <player_status>
	difficulty = $current_difficulty
	change structurename = <player_status> score = ($<player_status>.score + (<multiplier> * $points_per_note.<difficulty>))
endscript

script miss_note 
	change structurename = <player_status> total_notes = ($<player_status>.total_notes + 1)
	change structurename = <player_status> current_run = 0
endscript

script unnecessary_note 
	change structurename = <player_status> current_run = 0
endscript

script update_score_fast 
	UpdateScoreFastInit player_status = <player_status>
	begin
	wait_for_correct_frame player = ($<player_status>.player)
	WaitOneGameFrame
	GetSongTimeMs
	UpdateScoreFastPerFrame player_status = <player_status> time = <time>
	repeat
endscript

script update_score 
	last_score = -1
	last_star = -1.0
	last_health = -1.0
	last_run = -1
	ExtendCRC ScoreMeter_Wheel_100000 <player_text> out = Wheel_100000
	ExtendCRC ScoreMeter_Wheel_10000 <player_text> out = Wheel_10000
	ExtendCRC ScoreMeter_Wheel_1000 <player_text> out = Wheel_1000
	ExtendCRC ScoreMeter_Wheel_100 <player_text> out = Wheel_100
	ExtendCRC ScoreMeter_Wheel_10 <player_text> out = Wheel_10
	ExtendCRC ScoreMeter_Wheel_1 <player_text> out = Wheel_1
	ExtendCRC RockMeter_Bulb0 <player_text> out = Bulb0
	ExtendCRC RockMeter_Bulb1 <player_text> out = Bulb1
	ExtendCRC RockMeter_Bulb2 <player_text> out = Bulb2
	ExtendCRC RockMeter_Bulb3 <player_text> out = Bulb3
	ExtendCRC RockMeter_Bulb4 <player_text> out = Bulb4
	ExtendCRC RockMeter_Bulb5 <player_text> out = Bulb5
	ExtendCRC RockMeter_Bulb_Lit0 <player_text> out = Bulb_Lit0
	ExtendCRC RockMeter_Bulb_Lit1 <player_text> out = Bulb_Lit1
	ExtendCRC RockMeter_Bulb_Lit2 <player_text> out = Bulb_Lit2
	ExtendCRC RockMeter_Bulb_Lit3 <player_text> out = Bulb_Lit3
	ExtendCRC RockMeter_Bulb_Lit4 <player_text> out = Bulb_Lit4
	ExtendCRC RockMeter_Bulb_Lit5 <player_text> out = Bulb_Lit5
	begin
	<score> = ($<player_status>.score)
	if NOT (<last_score> = <score>)
		<last_score> = <score>
		<score_1000000> = (<score> / 1000000)
		<score_100000> = (<score> / 100000)
		<score_10000> = (<score> / 10000)
		<score_1000> = (<score> / 1000)
		<score_100> = (<score> / 100)
		<score_10> = (<score> / 10)
		<score_1> = (<score> - (<score_10> * 10))
		<score_10> = (<score_10> - (<score_100> * 10))
		<score_100> = (<score_100> - (<score_1000> * 10))
		<score_1000> = (<score_1000> - (<score_10000> * 10))
		<score_10000> = (<score_10000> - (<score_100000> * 10))
		<score_100000> = (<score_100000> - (<score_1000000> * 10))
		<step> = ((3.1415927 * 2.0) / 10.0)
		SetScreenElementProps id = <Wheel_100000> anglex = (<step> * <score_100000>)
		SetScreenElementProps id = <Wheel_10000> anglex = (<step> * <score_10000>)
		SetScreenElementProps id = <Wheel_1000> anglex = (<step> * <score_1000>)
		SetScreenElementProps id = <Wheel_100> anglex = (<step> * <score_100>)
		SetScreenElementProps id = <Wheel_10> anglex = (<step> * <score_10>)
		SetScreenElementProps id = <Wheel_1> anglex = (<step> * <score_1>)
	endif
	<star> = ($<player_status>.star_power_amount)
	if NOT (<last_star> = <star>)
		<last_star> = <star>
		<amount_per_bulb> = (100.0 / 6.0)
		if (<star> >= <amount_per_bulb>)
			doScreenElementMorph id = <Bulb0> alpha = 0
			doScreenElementMorph id = <Bulb_Lit0> alpha = 1
		else
			doScreenElementMorph id = <Bulb0> alpha = 1
			doScreenElementMorph id = <Bulb_Lit0> alpha = 0
		endif
		if (<star> >= (<amount_per_bulb> * 2))
			doScreenElementMorph id = <Bulb1> alpha = 0
			doScreenElementMorph id = <Bulb_Lit1> alpha = 1
		else
			doScreenElementMorph id = <Bulb1> alpha = 1
			doScreenElementMorph id = <Bulb_Lit1> alpha = 0
		endif
		if (<star> >= (<amount_per_bulb> * 3))
			doScreenElementMorph id = <Bulb2> alpha = 0
			doScreenElementMorph id = <Bulb_Lit2> alpha = 1
		else
			doScreenElementMorph id = <Bulb2> alpha = 1
			doScreenElementMorph id = <Bulb_Lit2> alpha = 0
		endif
		if (<star> >= (<amount_per_bulb> * 4))
			doScreenElementMorph id = <Bulb3> alpha = 0
			doScreenElementMorph id = <Bulb_Lit3> alpha = 1
		else
			doScreenElementMorph id = <Bulb3> alpha = 1
			doScreenElementMorph id = <Bulb_Lit3> alpha = 0
		endif
		if (<star> >= (<amount_per_bulb> * 5))
			doScreenElementMorph id = <Bulb4> alpha = 0
			doScreenElementMorph id = <Bulb_Lit4> alpha = 1
		else
			doScreenElementMorph id = <Bulb4> alpha = 1
			doScreenElementMorph id = <Bulb_Lit4> alpha = 0
		endif
		if (<star> >= (<amount_per_bulb> * 6))
			doScreenElementMorph id = <Bulb5> alpha = 0
			doScreenElementMorph id = <Bulb_Lit5> alpha = 1
		else
			doScreenElementMorph id = <Bulb5> alpha = 1
			doScreenElementMorph id = <Bulb_Lit5> alpha = 0
		endif
	endif
	<health> = ($health_scale - $<player_status>.current_health)
	if NOT (<last_health> = <health>)
		<last_health> = <health>
		<rot> = (((<health> / $health_scale) * (0.65000004 * 2.0)) - 0.65000004)
		ExtendCRC RockMeter_Needle <player_text> out = needle
		SetScreenElementProps id = <needle> anglez = <rot>
	endif
	<run> = ($<player_status>.current_run)
	if NOT (<last_run> = <run>)
		<last_run> = <run>
		<bulbs> = 0
		if (<run> > 40)
			<bulbs> = 10
		else
			if (<run> > 30)
				<bulbs> = (<run> - 30)
			else
				if (<run> > 20)
					<bulbs> = (<run> - 20)
				else
					if (<run> > 10)
						<bulbs> = (<run> - 10)
					else
						<bulbs> = <run>
					endif
				endif
			endif
		endif
		index = 0
		begin
		FormatText checksumname = dark_bulb 'ScoreMeter_Bulb%n%p' n = <index> p = <player_text>
		FormatText checksumname = lit_bulb 'ScoreMeter_Bulb_Lit%n%p' n = <index> p = <player_text>
		if (<bulbs> > <index>)
			doScreenElementMorph id = <dark_bulb> alpha = 0
			doScreenElementMorph id = <lit_bulb> alpha = 1
		else
			doScreenElementMorph id = <dark_bulb> alpha = 1
			doScreenElementMorph id = <lit_bulb> alpha = 0
		endif
		<index> = (<index> + 1)
		repeat 10
		get_current_multiplier <...>
		mults = [1 , 2 , 3 , 4 , 6 , 8]
		idx = 0
		begin
		<index> = (<mults> [<idx>])
		FormatText checksumname = multiplier_element 'ScoreMeter_Multiplier%n%p' n = <index> p = <player_text>
		if (<multiplier> = <index>)
			doScreenElementMorph id = <multiplier_element> alpha = 1
		else
			doScreenElementMorph id = <multiplier_element> alpha = 0
		endif
		<idx> = (<idx> + 1)
		repeat 6
	endif
	WaitOneGameFrame
	repeat
endscript

script get_current_multiplier 
	multiplier = 4
	if ($<player_status>.current_run < 10)
		<multiplier> = 1
	elseif ($<player_status>.current_run < 20)
		<multiplier> = 2
	elseif ($<player_status>.current_run < 30)
		<multiplier> = 3
	endif
	if ($<player_status>.star_power_used = 1)
		<multiplier> = (<multiplier> * 2)
	endif
	return <...>
endscript
