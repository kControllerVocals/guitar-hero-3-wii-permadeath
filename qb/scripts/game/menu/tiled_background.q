
script TileSprite \{parent = root_window
		container_type = ContainerElement
		tile_dims = (1280.0, 720.0)
		pos = (0.0, 0.0)
		sprite_props = {
		}
		container_props = {
		}}
	if isps2
	endif
	GetPlatform
	if (<platform> = Ps2 || <platform> = ngc)
	endif
	if NOT GotParam \{texture}

		return
	endif
	CreateScreenElement {
		type = <container_type>
		parent = <parent>
		dims = <tile_dims>
		pos = <pos>
		just = [left top]
		child_anchor = [left top]
		<container_props>
	}
	<container_id> = <id>
	if NOT GotParam \{dims}
		CreateScreenElement {
			type = SpriteElement
			parent = <parent>
			texture = <texture>
		}
		GetScreenElementDims id = <id>
		if ((<width> < 1) || (<Height> < 1))

			DestroyScreenElement id = <container_id>
			return
		endif
		DestroyScreenElement id = <id>
	else
		<width> = (<dims> [0])
		<Height> = (<dims> [1])
	endif
	<container_id> :SetTags {
		width = <width>
		Height = <Height>
		pos = <pos>
	}
	if GotParam \{flip_h}
		<container_id> :SetTags {
			flip_h
		}
	endif
	if GotParam \{flip_v}
		<container_id> :SetTags {
			flip_v
		}
	endif
	<x> = 0
	<y> = 0
	<row> = 0
	<column> = 0
	<count> = 0
	begin
	<flip> = {}
	if GotParam \{flip_h}
		Mod a = <row> b = (2)
		if (<Mod> = 0)
			<flip> = {flip_h}
		endif
	endif
	if GotParam \{flip_v}
		Mod a = <column> b = (2)
		if (<Mod> = 0)
			<flip> = {<flip> flip_v}
		endif
	endif
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		texture = <texture>
		dims = <dims>
		just = [left top]
		pos = (((1.0, 0.0) * <x>) + ((0.0, 1.0) * <y>))
		<sprite_props>
		<flip>
	}
	<count> = (<count> + 1)
	<x> = (<x> + <width>)
	<column> = (<column> + 1)
	if (<x> > (<tile_dims> [0]))
		<x> = 0
		<y> = (<y> + <Height>)
		<row> = (<row> + 1)
		<column> = 0
		if (<y> > (<tile_dims> [1]))
			return {id = <container_id> count = <count>}
		endif
	endif
	repeat
endscript

script TileSpriteLoop \{move_x = 1
		move_y = 0}
	GetTags
	if GotParam \{flip_v}
		<width> = (<width> * 2)
	endif
	if GotParam \{flip_h}
		<Height> = (<Height> * 2)
	endif
	if ((<move_x> > <width>) || (<move_x> < (<width> * -1)))

		return
	endif
	if ((<move_y> > <Height>) || (<move_y> < (<Height> * -1)))

		return
	endif
	<x> = 0
	<y> = 0
	begin
	<x> = (<x> + <move_x>)
	<y> = (<y> + <move_y>)
	if (<x> > <width>)
		<x> = (<x> - <width>)
		DoMorph {
			pos = {((-1.0, 0.0) * <width>) relative}
		}
	endif
	if (<x> < (<width> * -1))
		<x> = (<width> + <x>)
		DoMorph {
			pos = {((1.0, 0.0) * <width>) relative}
		}
	endif
	if (<y> > <Height>)
		<y> = (<y> - <Height>)
		DoMorph {
			pos = {((0.0, -1.0) * <Height>) relative}
		}
	endif
	if (<y> < (<Height> * -1))
		<y> = (<Height> + <y>)
		DoMorph {
			pos = {((0.0, 1.0) * <Height>) relative}
		}
	endif
	DoMorph {
		pos = (((1.0, 0.0) * ((<pos> [0]) + <x>)) + ((0.0, 1.0) * ((<pos> [1]) + <y>)))
		time = 0.1
	}
	repeat
endscript
