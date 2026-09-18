SE_Brightness = 5
currentTODSettings = Default_tod_manager

script TOD_Proxim_Create_LightFX 
	ScreenFX_ClearFXInstances \{viewport = 0}
	if InSplitScreenGame
		ScreenFX_ClearFXInstances \{viewport = 0}
	endif
	TOD_Proxim_Update_Global_Brightness \{viewport = 0}
	TOD_Proxim_Update_LightFX \{viewport = bg_viewport
		time = 0}
endscript

script TOD_Proxim_Update_LightFX 
	TOD_Proxim_Update_LightFX_Viewport viewport = 0 <...>
	if InSplitScreenGame
		TOD_Proxim_Update_LightFX_Viewport viewport = 0 <...>
	endif
endscript

script toggle_default_sceenfx 

	TOD_Proxim_Update_LightFX_Viewport
	toggle_screenfx_instances
endscript

script TOD_Proxim_Update_LightFX_Viewport \{fxParam = $Default_tod_manager
		viewport = 0
		time = 1}
	ScreenFX_ClearFXInstances viewport = <viewport>
	if (<viewport> = 0)
		TOD_Proxim_Update_Global_Brightness <...>
	elseif (<viewport> = bg_viewport)
		if NOT ScreenFX_FxInstanceExists viewport = <viewport> name = venue_DOF
			ScreenFX_AddFXInstance {
				viewport = <viewport>
				name = venue_DOF
				($DOF_Off_tod_manager.screen_fx [0])
			}
		else
			ScreenFX_UpdateFXInstanceParams {
				viewport = <viewport>
				name = venue_DOF
				($DOF_Off_tod_manager.screen_fx [0])
			}
		endif
	endif
	if StructureContains \{Structure = fxParam
			screen_fx}
		begin
		if GetNextArrayElement (<fxParam>.screen_fx)
			GetUniqueCompositeObjectID \{preferredID = screenFXID}
			ScreenFX_AddFXInstance {
				viewport = <viewport>
				name = <uniqueID>
				<element>
			}
		else
			break
		endif
		repeat
	endif
	if StructureContains \{Structure = fxParam
			atmosphere}
		UpdateAtmosphere (<fxParam>.atmosphere)
	endif
endscript

script TOD_Proxim_Reapply_LightFX 
	TOD_Proxim_Update_LightFX \{fxParam = $currentTODSettings
		time = 0.0}
endscript

script TOD_Proxim_Update_Global_Brightness \{viewport = 0}
	if NOT ScreenFX_FxInstanceExists viewport = <viewport> name = global_brightness
		ScreenFX_AddFXInstance {
			viewport = <viewport>
			name = global_brightness
			on = 1
			brightness = (0.5 + ($SE_Brightness) * 0.1)
			type = bright_sat
		}
	else
		ScreenFX_UpdateFXInstanceParams {
			viewport = <viewport>
			name = global_brightness
			on = 1
			brightness = (0.5 + ($SE_Brightness) * 0.1)
			time = 0
		}
	endif
endscript
