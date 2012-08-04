package com.funbuilder.controller.commands
{
	import com.funbuilder.model.BrushModel;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.SelectedBlocksModel;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class KeyUpCommand extends Command
	{
		// Arguments.
		
		[Inject]
		public var event:KeyboardEvent;
		
		// Models.
		
		[Inject]
		public var keysModel:KeysModel;
		
		[Inject]
		public var brushModel:BrushModel;
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		override public function execute():void
		{
			keysModel.command = event.commandKey;
			keysModel.shift = event.shiftKey;
			keysModel.alt = event.altKey;
			keysModel.control = event.controlKey;
			delete keysModel.keysDown[ event.keyCode ];
			
			var key:int = event.keyCode;
			if ( key == Keyboard.ALTERNATE ) {
				selectedBlocksModel.canDuplicate = false;
			} else if ( key == Keyboard.A ) {
				brushModel.resetPlacement();
			}
		}
	}
}