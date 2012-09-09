package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.NewFileRequest;
	import com.funbuilder.model.LightsModel;
	import com.funbuilder.model.View3dModel;
	import com.funbuilder.model.constants.SegmentConstants;
	
	import org.robotlegs.mvcs.Command;
	
	public class InitViewCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var view3dModel:View3dModel;
		
		[Inject]
		public var lightsModel:LightsModel;
		
		// Commands.
		
		[Inject]
		public var newFileRequest:NewFileRequest;
		
		override public function execute():void {
			lightsModel.light.x = SegmentConstants.SEGMENT_HALF_WIDTH;
			lightsModel.light.y = 700;
			lightsModel.light.z = -500; // Place the light at the front of the segment.
			
			view3dModel.cameraController.panAngle = 180 + 45;
			view3dModel.cameraController.tiltAngle = 20;
			view3dModel.cameraController.distance = 2000;
			
			newFileRequest.dispatch();
		}
	}
}