package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.ToggleLibraryRequest;
	import com.funbuilder.model.KeyboardModel;
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
		public var keysModel:KeyboardModel;
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var toggleLibraryRequest:ToggleLibraryRequest;
		
		override public function execute():void
		{
			keysModel.command = event.commandKey;
			keysModel.shift = event.shiftKey;
			keysModel.alt = event.altKey;
			keysModel.control = event.controlKey;
			delete keysModel.keysDown[ event.keyCode ];
			
			var key:int = event.keyCode;
			switch ( key ) {
				case Keyboard.ALTERNATE:
					selectedBlocksModel.canDuplicate = false;
					break;
				case Keyboard.TAB:
					toggleLibraryRequest.dispatch( false );
					break;
			}
		}
	}
}