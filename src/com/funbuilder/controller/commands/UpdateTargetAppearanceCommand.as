package com.funbuilder.controller.commands
{
	import away3d.materials.ColorMaterial;
	
	import com.funbuilder.controller.signals.ShowSelectionIndicatorRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.EditingModeModel;
	import com.funbuilder.model.SelectedBlockModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateTargetAppearanceCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var editingModeModel:EditingModeModel;
		
		[Inject]
		public var currentBlockModel:SelectedBlockModel;
		
		// Commands.
		
		[Inject]
		public var showSelectionIndicatorRequest:ShowSelectionIndicatorRequest;
		
		override public function execute():void
		{
			trace("update");
			var material:ColorMaterial;
			if ( editingModeModel.mode == EditingModeModel.BUILD ) {
				if ( currentBlockModel.hasBlock() ) {
					material = cameraTargetModel.buildSelectedMaterial;
				} else {
					material = cameraTargetModel.buildUnselectedMaterial;
				}
			} else if ( editingModeModel.mode == EditingModeModel.LOOK ) {
				if ( currentBlockModel.hasBlock() ) {
					material = cameraTargetModel.lookSelectedMaterial;
				} else {
					material = cameraTargetModel.lookUnselectedMaterial;
				}
			}
			cameraTargetModel.setMaterial( material );
			showSelectionIndicatorRequest.dispatch( currentBlockModel.hasBlock() );
		}
	}
}