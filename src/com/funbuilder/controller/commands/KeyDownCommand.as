package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.ChangeBlockStyleRequest;
	import com.funbuilder.controller.signals.ChangeBlockTypeRequest;
	import com.funbuilder.controller.signals.DeleteBlockRequest;
	import com.funbuilder.controller.signals.DeselectAllBlocksRequest;
	import com.funbuilder.controller.signals.DeselectBrushRequest;
	import com.funbuilder.controller.signals.ToggleLibraryRequest;
	import com.funbuilder.model.BrushModel;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.KeyboardModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.ChangeBlockStyleVo;
	import com.funbuilder.model.vo.ChangeBlockTypeVo;
	
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
		public var keysModel:KeyboardModel;
		
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
		public var changeBlockStyleRequest:ChangeBlockStyleRequest;
		
		[Inject]
		public var deselectAllBlocksRequest:DeselectAllBlocksRequest;
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var toggleLibraryRequest:ToggleLibraryRequest;
		
		[Inject]
		public var deselectBrushRequest:DeselectBrushRequest;
		
		// Private vars.
		
		private const LEFT_ARROW:int = 37;
		private const RIGHT_ARROW:int = 39;
		private const LEFT_BRACKET:int = 219;
		private const RIGHT_BRACKET:int = 221;
		
		override public function execute():void
		{
			
			keysModel.command = event.commandKey;
			keysModel.shift = event.shiftKey;
			keysModel.alt = event.altKey;
			keysModel.control = event.controlKey;
			
			var key:int = event.keyCode;
			if ( !keysModel.isDown( key ) ) {
				keysModel.down( key );
				switch ( key ) {
					case Keyboard.SPACE:
						// Snap camera to selected blocks.
						if ( selectedBlocksModel.numBlocks > 0 ) {
							cameraTargetModel.moveTo( selectedBlocksModel.centroid.x, cameraTargetModel.targetY, selectedBlocksModel.centroid.z );
						}
						break;
					case Keyboard.ESCAPE:
						// Deselect brush/selected blocks.
						deselectBrushRequest.dispatch();
						if ( selectedBlocksModel.numBlocks > 0 ) {
							addHistoryRequest.dispatch();
							deselectAllBlocksRequest.dispatch();
						}
						break;
					case Keyboard.BACKSPACE:
						// Delete selected blocks.
						deleteBlockRequest.dispatch();
						break;
					case Keyboard.ALTERNATE:
						// Drag-duplicate selected blocks.
						selectedBlocksModel.canDuplicate = true;
						break;
					case Keyboard.TAB:
						// Show library.
						toggleLibraryRequest.dispatch( true );
						break;
				}
				
				switch ( event.keyCode ) {
					case LEFT_ARROW:
						changeBlockTypeRequest.dispatch( new ChangeBlockTypeVo( -1 ) );
						break;
					case RIGHT_ARROW:
						changeBlockTypeRequest.dispatch( new ChangeBlockTypeVo( 1 ) );
						break;
					case LEFT_BRACKET:
						changeBlockStyleRequest.dispatch( new ChangeBlockStyleVo( -1 ) );
						break;
					case RIGHT_BRACKET:
						changeBlockStyleRequest.dispatch( new ChangeBlockStyleVo( 1 ) );
						break;
				}
				
			}
		}
	}
}