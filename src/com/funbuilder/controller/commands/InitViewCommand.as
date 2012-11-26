package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.NewFileRequest;
	import com.funbuilder.model.LightsModel;
	import com.funbuilder.model.View3dModel;
	import com.funbuilder.model.constants.Grid;
	import com.funrun.model.BlockStylesModel;
	import com.funrun.model.constants.Segment;
	
	import org.robotlegs.mvcs.Command;
	
	public class InitViewCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var view3dModel:View3dModel;
		
		[Inject]
		public var lightsModel:LightsModel;
		
		[Inject]
		public var blockStylesModel:BlockStylesModel;
		
		// Commands.
		
		[Inject]
		public var newFileRequest:NewFileRequest;
		
		override public function execute():void {
			// Set current blocks style.
			blockStylesModel.currentStyle = blockStylesModel.getStyle( "default" );
			
			// Build scene.
			lightsModel.light.x = Segment.HALF_WIDTH;
			lightsModel.light.y = 700;
			lightsModel.light.z = -500; // Place the light at the front of the segment.
			
			view3dModel.cameraController.panAngle = 180 + 45;
			view3dModel.cameraController.tiltAngle = 20;
			view3dModel.cameraController.distance = 2000;
			
			newFileRequest.dispatch();
		}
	}
}