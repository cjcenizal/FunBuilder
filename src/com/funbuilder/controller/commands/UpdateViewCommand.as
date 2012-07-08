package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.CurrentBlockModel;
	import com.funbuilder.model.EditingModeModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funbuilder.model.events.TimeEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateViewCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var event:TimeEvent;
		
		// Models.
		
		[Inject]
		public var view3DModel:View3DModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var currentBlockModel:CurrentBlockModel;
		
		// Commands.
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		override public function execute():void
		{
			// If we have a currently selected block, move the block to match the target.
			if ( currentBlockModel.hasBlock() ) {
				// Move block.
				var x:Number = snapToGrid( cameraTargetModel.target.x - SegmentConstants.BLOCK_SIZE * .5 ) + SegmentConstants.BLOCK_SIZE * .5;
				var y:Number = snapToGrid( cameraTargetModel.target.y ) - SegmentConstants.BLOCK_SIZE * .5;
				var z:Number = snapToGrid( cameraTargetModel.target.z - SegmentConstants.BLOCK_SIZE * .5 ) + SegmentConstants.BLOCK_SIZE * .5;
				var wasMoved:Boolean = currentBlockModel.hasBeenMoved;
				var isMoved:Boolean = currentBlockModel.setPosition( x, y, z );
				if ( !wasMoved && isMoved  ) {
					// Save history if we move the block and it's the first time it gets moved.
					addHistoryRequest.dispatch();
				}
			}
			
			// Render scene.
			view3DModel.render();
		}
		
		private function snapToGrid( val:Number ):int {
			return Math.round( val / SegmentConstants.BLOCK_SIZE ) * SegmentConstants.BLOCK_SIZE;
		}
	}
}