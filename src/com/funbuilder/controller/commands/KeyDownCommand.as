package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.ChangeBlockTypeRequest;
	import com.funbuilder.controller.signals.DeleteBlockRequest;
	import com.funbuilder.controller.signals.DeselectAllBlocksRequest;
	import com.funbuilder.controller.signals.HandleKeyMovementRequest;
	import com.funbuilder.controller.signals.SetEditingModeRequest;
	import com.funbuilder.model.EditingModeModel;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.ChangeBlockTypeVO;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class KeyDownCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var event:KeyboardEvent;
		
		// Models.
		
		[Inject]
		public var keysModel:KeysModel;
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		// Commands.
		
		[Inject]
		public var setEditingModeRequest:SetEditingModeRequest;
		
		[Inject]
		public var deleteBlockRequest:DeleteBlockRequest;
		
		[Inject]
		public var changeBlockTypeRequest:ChangeBlockTypeRequest;
		
		[Inject]
		public var deselectAllBlocksRequest:DeselectAllBlocksRequest;
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var handleKeyMovementRequest:HandleKeyMovementRequest;
		
		// Private vars.
		
		private const LEFT_ARROW:int = 37;
		private const RIGHT_ARROW:int = 39;
		
		override public function execute():void
		{
			keysModel.command = event.commandKey;
			keysModel.shift = event.shiftKey;
			keysModel.alt = event.altKey;
			keysModel.control = event.controlKey;
			
			
			if ( !keysModel.keysDown[ event.keyCode ] ) {
				keysModel.keysDown[ event.keyCode ] = true;
				
				/*
				switch ( event.keyCode ) {
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
					case Keyboard.ESCAPE:
						addHistoryRequest.dispatch();
						deselectAllBlocksRequest.dispatch();
						break;
				}*/
				
				//selectedBlocksModel.resetTimeUntilMovement();
				handleKeyMovementRequest.dispatch();
			}
		}
	}
}