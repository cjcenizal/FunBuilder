package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.SetEditingModeRequest;
	import com.funbuilder.model.EditingModeModel;
	import com.funbuilder.model.KeysModel;
	
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class KeyUpCommand extends Command
	{
		// Arguments.
		
		[Inject]
		public var code:int;
		
		// Models.
		
		[Inject]
		public var keysModel:KeysModel;
		
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
			delete keysModel.keysDown[ code ];
		}
	}
}