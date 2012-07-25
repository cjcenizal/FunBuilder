package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.MoveBlockRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.constants.SegmentConstants;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	public class ScrollWheelCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var delta:int;
		
		// Models.
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var view3dModel:View3DModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
		// Commands.
		
		[Inject]
		public var moveBlockRequest:MoveBlockRequest;
		
		override public function execute():void
		{
			// Zoom.
			view3dModel.cameraController.distance -= delta * 20;
			
			// Crane the camera.
			//cameraTargetModel.setPos( cameraTargetModel.targetX, cameraTargetModel.targetY + delta * 20, cameraTargetModel.targetZ );
		}
	}
}