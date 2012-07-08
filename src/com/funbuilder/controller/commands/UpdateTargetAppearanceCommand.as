package com.funbuilder.controller.commands
{
	import away3d.materials.ColorMaterial;
	
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.EditingModeModel;
	
	import org.robotlegs.mvcs.Command;
	import com.funbuilder.model.CurrentBlockModel;
	
	public class UpdateTargetAppearanceCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var editingModeModel:EditingModeModel;
		
		[Inject]
		public var currentBlockModel:CurrentBlockModel;
		
		override public function execute():void
		{
			var material:ColorMaterial;
			if ( editingModeModel.mode == EditingModeModel.BUILD ) {
				if ( currentBlockModel.block ) {
					material = cameraTargetModel.buildSelectedMaterial;
				} else {
					material = cameraTargetModel.buildUnselectedMaterial;
				}
			} else if ( editingModeModel.mode == EditingModeModel.LOOK ) {
				if ( currentBlockModel.block ) {
					material = cameraTargetModel.lookSelectedMaterial;
				} else {
					material = cameraTargetModel.lookUnselectedMaterial;
				}
			}
			cameraTargetModel.target.material = material;
		}
	}
}