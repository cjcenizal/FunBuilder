package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.SetEditingModeRequest;
	import com.funbuilder.model.EditingModeModel;
	
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class KeyUpCommand extends Command
	{
		// Arguments.
		
		[Inject]
		public var code:int;
		
		// Commands.
		
		[Inject]
		public var setEditingModeRequest:SetEditingModeRequest;
		
		override public function execute():void
		{
			switch ( code ) {
				case Keyboard.SPACE:
					setEditingModeRequest.dispatch( EditingModeModel.LOOK );
					break;
			}
		}
	}
}