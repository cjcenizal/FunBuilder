package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.BrushBlockRequest;
	import com.funbuilder.controller.signals.ChangeBlockTypeRequest;
	import com.funbuilder.controller.signals.DeleteBlockRequest;
	import com.funbuilder.controller.signals.DeselectAllBlocksRequest;
	import com.funbuilder.controller.signals.DeselectBrushRequest;
	import com.funbuilder.controller.signals.ToggleLibraryRequest;
	import com.funbuilder.model.BrushModel;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.SelectedBlocksModel;
	
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
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var brushModel:BrushModel;
		
		// Commands.
		
		[Inject]
		public var deleteBlockRequest:DeleteBlockRequest;
		
		[Inject]
		public var changeBlockTypeRequest:ChangeBlockTypeRequest;
		
		[Inject]
		public var deselectAllBlocksRequest:DeselectAllBlocksRequest;
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var toggleLibraryRequest:ToggleLibraryRequest;
		
		[Inject]
		public var deselectBrushRequest:DeselectBrushRequest;
		
		[Inject]
		public var brushBlockRequest:BrushBlockRequest;
		
		// Private vars.
		
		private const LEFT_ARROW:int = 37;
		private const RIGHT_ARROW:int = 39;
		
		override public function execute():void
		{
			keysModel.command = event.commandKey;
			keysModel.shift = event.shiftKey;
			keysModel.alt = event.altKey;
			keysModel.control = event.controlKey;
			
			var key:int = event.keyCode;
			if ( !keysModel.keysDown[ key ] ) {
				keysModel.keysDown[ key ] = true;
				// Snap camera to selected blocks.
				if ( key == Keyboard.SPACE && selectedBlocksModel.numBlocks > 0 ) {
					cameraTargetModel.moveTo( selectedBlocksModel.centroid.x, cameraTargetModel.targetY, selectedBlocksModel.centroid.z );
				} else if ( key == Keyboard.ESCAPE ) {
					deselectBrushRequest.dispatch();
					if ( selectedBlocksModel.numBlocks > 0 ) {
						addHistoryRequest.dispatch();
						deselectAllBlocksRequest.dispatch();
					}
				} else if ( key == Keyboard.BACKSPACE ) {
					deleteBlockRequest.dispatch();
				} else if ( key == Keyboard.ALTERNATE ) {
					selectedBlocksModel.canDuplicate = true;
				} else if ( key == Keyboard.TAB ) {
					toggleLibraryRequest.dispatch();
				} else if ( key == Keyboard.A ) {
					brushModel.resetPlacement();
					brushBlockRequest.dispatch();
				}
				
				/*
				switch ( event.keyCode ) {
					case LEFT_ARROW:
						changeBlockTypeRequest.dispatch( new ChangeBlockTypeVO( -1 ) );
						break;
					case RIGHT_ARROW:
						changeBlockTypeRequest.dispatch( new ChangeBlockTypeVO( 1 ) );
						break;
				}*/
				
			}
		}
	}
}