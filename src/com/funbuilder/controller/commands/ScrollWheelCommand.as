package com.funbuilder.controller.commands
{
	import com.funbuilder.model.View3DModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class ScrollWheelCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var delta:int;
		
		// Models.
		
		[Inject]
		public var view3dModel:View3DModel;
		
		override public function execute():void
		{
			// Zoom.
			view3dModel.cameraController.distance -= delta * 20;
		}
	}
}