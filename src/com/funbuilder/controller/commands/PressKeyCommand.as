package com.funbuilder.controller.commands
{
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
		
		// Private vars.
		
		private const SPACE:int = 32;
		
		override public function execute():void
		{
			
			// Dispatch into system, to either echo back or change mode.
			if ( code == SPACE ) {
				// Toggle between Selection and Exploration mode.
				if ( editingModeModel.mode == EditingModeModel.LOOK ) {
					editingModeModel.mode = EditingModeModel.SELECT;
				} else {
					editingModeModel.mode = EditingModeModel.LOOK;
				}
				setEditingModeRequest.dispatch( editingModeModel.mode );
				
				
				// Space bar switches: 1) move block / camera mode, 2) block selection/addition mode
				// Selection: 1) select block and choose new type (or switch to moving to move it around)
				// 2) drag new blocks from library into scene
				// Intersecting an existing block flashes red and doesn't allow you to leave it there
				// (i.e. deselect it)
				
			} else if ( editingModeModel.mode == EditingModeModel.LOOK ) {
				pressKeyToLookRequest.dispatch( code );
			}
		}
	}
}