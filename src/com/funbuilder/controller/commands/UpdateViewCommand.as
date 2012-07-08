package com.funbuilder.controller.commands
{
	import com.funbuilder.model.CameraTargetModel;
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
		
		override public function execute():void
		{
			// If we have a currently selected block, move the block to match the target.
			if ( currentBlockModel.block ) {
				// Move block.
				currentBlockModel.block.x = snapToGrid( cameraTargetModel.target.x ) - SegmentConstants.BLOCK_SIZE * .5;
				currentBlockModel.block.y = snapToGrid( cameraTargetModel.target.y ) - SegmentConstants.BLOCK_SIZE * .5;
				currentBlockModel.block.z = snapToGrid( cameraTargetModel.target.z ) - SegmentConstants.BLOCK_SIZE * .5;
			}
			
			view3DModel.render();
		}
		
		private function snapToGrid( val:Number ):int {
			return Math.round( val / SegmentConstants.BLOCK_SIZE ) * SegmentConstants.BLOCK_SIZE;
		}
	}
}