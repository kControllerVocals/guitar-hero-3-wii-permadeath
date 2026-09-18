use_pcmcia = 'true'
viewer_ip = '10.2.1.1'
viewer_subnet = '255.252.0.0'
viewer_gateway = '10.2.0.1'
use_qbr = 0

script startup 
endscript
show_old_songs = 0
build_label_string = 'BUILD LABEL'

script create_build_label 
	if NOT ScreenElementExists \{id = build_label_container}
		CreateScreenElement \{type = ContainerElement
			id = build_label_container
			parent = root_window
			pos = (250.0, 500.0)
			just = [
				left
				top
			]
			z_priority = 4}
		CreateScreenElement \{type = SpriteElement
			id = build_label_logo
			parent = build_label_container
			texture = Budcat
			pos = (0.0, 0.0)
			dims = (96.0, 96.0)}
		CreateScreenElement {
			type = TextElement
			id = build_label_text
			parent = build_label_container
			text = ($build_label_string)
			font = text_a1
			pos = (64.0, 0.0)
			scale = (1.0, 1.0)
			rgba = [210 0 0 250]
			just = [left center]
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
		}
	endif
endscript

script destroy_build_label 
	if ScreenElementExists \{id = build_label_container}
		DestroyScreenElement \{id = build_label_container}
	endif
endscript
