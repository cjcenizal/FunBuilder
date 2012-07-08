package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.controller.signals.PressKeyToLookRequest;
	import com.funbuilder.controller.signals.SetEditingModeRequest;
	import com.funbuilder.model.EditingModeModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class PressKeyCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var code:int;
		
		// Models.
		
		[Inject]
		public var editingModeModel:EditingModeModel;
		
		// Commands.
		
		[Inject]
		public var pressKeyToLookRequest:PressKeyToLookRequest;
		
		[Inject]
		public var setEditingModeRequest:SetEditingModeRequest;
		
		[Inject]
		public var deselectBlockRequest:DeselectBlockRequest;
		
		// Private vars.
		
		private const ESC:int = 27;
		private const SPACE:int = 32;
		
		override public function execute():void
		{
			if ( code == ESC ) {
				// Deselect current block.
				deselectBlockRequest.dispatch();
			} else if ( code == SPACE ) {
				// Toggle between Selection and Exploration mode.
				if ( editingModeModel.mode == EditingModeModel.LOOK ) {
					editingModeModel.mode = EditingModeModel.SELECT;
				} else {
					editingModeModel.mode = EditingModeModel.LOOK;
				}
				setEditingModeRequest.dispatch( editingModeModel.mode );
			} else if ( editingModeModel.mode == EditingModeModel.LOOK ) {
				// Send key back into MainView to move the camera.
				pressKeyToLookRequest.dispatch( code );
			}
		}
	}
}