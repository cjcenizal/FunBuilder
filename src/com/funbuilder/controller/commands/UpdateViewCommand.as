package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.MoveBlockRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.SelectedBlockModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funbuilder.model.events.TimeEvent;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateViewCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var event:TimeEvent;
		
		// Models.
		
		[Inject]
		public var view3dModel:View3DModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var currentBlockModel:SelectedBlockModel;
		
		// Commands.
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var moveBlockRequest:MoveBlockRequest;
		
		override public function execute():void
		{
			// If we have a currently selected block, move the block to match the target.
			if ( currentBlockModel.hasBlock() ) {
				// Move block.
				var x:Number = SegmentConstants.snapToGrid( cameraTargetModel.target.x - SegmentConstants.BLOCK_SIZE * .5 ) + SegmentConstants.BLOCK_SIZE * .5;
				var y:Number = SegmentConstants.snapToGrid( cameraTargetModel.target.y - SegmentConstants.BLOCK_SIZE * .5 );
				var z:Number = SegmentConstants.snapToGrid( cameraTargetModel.target.z - SegmentConstants.BLOCK_SIZE * .5 ) + SegmentConstants.BLOCK_SIZE * .5;
				moveBlockRequest.dispatch( new Vector3D( x, y, z ) );
			}
			
			// Render scene.
			view3dModel.render();
		}
		
	}
}