package com.funbuilder.controller.commands
{
	import away3d.materials.ColorMaterial;
	
	import com.funbuilder.controller.signals.UpdateTargetAppearanceRequest;
	import com.funbuilder.model.CameraTargetModel;
	
	import org.robotlegs.mvcs.Command;
	import com.funbuilder.model.SelectedBlockModel;
	
	public class DeselectBlockCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var currentBlockModel:SelectedBlockModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		// Commands.
		
		[Inject]
		public var updateTargetAppearanceRequest:UpdateTargetAppearanceRequest;
		
		override public function execute():void
		{
			// TO-DO:
			// Intersecting an existing block flashes red and doesn't allow you to leave it there
			// (i.e. deselect it)
			
			
			currentBlockModel.clearBlock();
			updateTargetAppearanceRequest.dispatch();
		}
	}
}