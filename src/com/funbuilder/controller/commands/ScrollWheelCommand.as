package com.funbuilder.controller.commands
{
	import com.funbuilder.model.CameraTargetModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class ScrollWheelCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var delta:int;
		
		// Models.
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		override public function execute():void
		{
			// Crane the camera.
			cameraTargetModel.setPos( cameraTargetModel.targetX, cameraTargetModel.targetY + delta * 20, cameraTargetModel.targetZ );
		}
	}
}