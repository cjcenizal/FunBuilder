package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.controller.signals.SetEditingModeRequest;
	import com.funbuilder.controller.signals.UpdateTargetAppearanceRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.EditingModeModel;
	
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class KeyDownCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var code:int;
		
		// Models.
		
		[Inject]
		public var editingModeModel:EditingModeModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
				
		// Commands.
		
		[Inject]
		public var setEditingModeRequest:SetEditingModeRequest;
		
		[Inject]
		public var updateTargetAppearanceRequest:UpdateTargetAppearanceRequest;
		
		[Inject]
		public var deselectBlockRequest:DeselectBlockRequest;
		
		
		override public function execute():void
		{
			if ( code == Keyboard.SPACE ) {
				// Toggle between Selection and Exploration mode.
				if ( editingModeModel.mode == EditingModeModel.LOOK ) {
					setEditingModeRequest.dispatch( EditingModeModel.BUILD );
				} else {
					setEditingModeRequest.dispatch( EditingModeModel.LOOK );
				}
			}
		}
	}
}