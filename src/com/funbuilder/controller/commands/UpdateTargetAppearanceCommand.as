package com.funbuilder.controller.commands
{
	import away3d.materials.ColorMaterial;
	
	import com.funbuilder.controller.signals.ShowSelectionIndicatorRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.EditingModeModel;
	import com.funbuilder.model.SelectedBlocksModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateTargetAppearanceCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var editingModeModel:EditingModeModel;
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		// Commands.
		
		[Inject]
		public var showSelectionIndicatorRequest:ShowSelectionIndicatorRequest;
		
		override public function execute():void
		{
			var material:ColorMaterial;
			if ( editingModeModel.mode == EditingModeModel.BUILD ) {
				if ( selectedBlocksModel.hasAnySelected() ) {
					material = cameraTargetModel.buildSelectedMaterial;
				} else {
					material = cameraTargetModel.buildUnselectedMaterial;
				}
			} else if ( editingModeModel.mode == EditingModeModel.LOOK ) {
				if ( selectedBlocksModel.hasAnySelected() ) {
					material = cameraTargetModel.lookSelectedMaterial;
				} else {
					material = cameraTargetModel.lookUnselectedMaterial;
				}
			}
			cameraTargetModel.setMaterial( material );
			showSelectionIndicatorRequest.dispatch( selectedBlocksModel.hasAnySelected() );
		}
	}
}