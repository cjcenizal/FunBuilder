package com.funbuilder.controller.commands
{
	import away3d.cameras.Camera3D;
	
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.MoveBlockRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funbuilder.model.events.TimeEvent;
	
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	
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
		public var currentBlockModel:SelectedBlocksModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
		// Commands.
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var moveBlockRequest:MoveBlockRequest;
		
		override public function execute():void
		{
			
			
			// If we have a currently selected block, move the block to match the target.
			//if ( currentBlockModel.hasAnySelected() ) {
				// Move block.
				//var snappedPos:Vector3D = SegmentConstants.snapPointGrid( cameraTargetModel.targetX, cameraTargetModel.targetY, cameraTargetModel.targetZ );
				//if ( !snappedPos.equals( currentBlockModel.getFocalPosition() ) ) {
				//	moveBlockRequest.dispatch( snappedPos );
				//}
			//}
			
			// Update target.
			cameraTargetModel.update();
			
			// Render scene.
			view3dModel.render();
		}
		
		
	}
}