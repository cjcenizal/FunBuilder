package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.ChangeBlockTypeRequest;
	import com.funbuilder.controller.signals.DeleteBlockRequest;
	import com.funbuilder.controller.signals.SetEditingModeRequest;
	import com.funbuilder.model.EditingModeModel;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.SelectedBlockModel;
	import com.funbuilder.model.vo.ChangeBlockTypeVO;
	
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
		public var selectedBlockModel:SelectedBlockModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
		// Commands.
		
		[Inject]
		public var setEditingModeRequest:SetEditingModeRequest;
		
		[Inject]
		public var deleteBlockRequest:DeleteBlockRequest;
		
		[Inject]
		public var changeBlockTypeRequest:ChangeBlockTypeRequest;
		
		// Private vars.
		
		private const LEFT_ARROW:int = 37;
		private const RIGHT_ARROW:int = 39;
		
		override public function execute():void
		{
			
			if ( !keysModel.keysDown[ code ] ) {
				switch ( code ) {
					case Keyboard.SPACE:
						setEditingModeRequest.dispatch( EditingModeModel.BUILD );
						break;
					case Keyboard.BACKSPACE:
						deleteBlockRequest.dispatch();
						break;
					case LEFT_ARROW:
						changeBlockTypeRequest.dispatch( new ChangeBlockTypeVO( -1 ) );
						break;
					case RIGHT_ARROW:
						changeBlockTypeRequest.dispatch( new ChangeBlockTypeVO( 1 ) );
						break;
				}
				keysModel.keysDown[ code ] = true;
			}
		}
	}
}