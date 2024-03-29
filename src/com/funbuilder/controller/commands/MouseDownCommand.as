package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.BrushBlockRequest;
	import com.funbuilder.model.BrushModel;
	import com.funbuilder.model.MouseModel;
	import com.funbuilder.model.View3dModel;
	
	import flash.geom.Point;
	
	import org.robotlegs.mvcs.Command;
	
	public class MouseDownCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var mouseModel:MouseModel;
		
		[Inject]
		public var view3dModel:View3dModel;
		
		[Inject]
		public var brushModel:BrushModel;
		
		// Commands.
		
		[Inject]
		public var brushBlockRequest:BrushBlockRequest;
		
		override public function execute():void {
			mouseModel.setMouseDown( contextView.stage.mouseX, contextView.stage.mouseY );
			view3dModel.lastPanAngle = view3dModel.cameraController.panAngle;
			view3dModel.lastTiltAngle = view3dModel.cameraController.tiltAngle;
			view3dModel.lastMouseX = contextView.stage.mouseX;
			view3dModel.lastMouseY = contextView.stage.mouseY;
			
			brushModel.resetPlacement();
			brushBlockRequest.dispatch();
			
		}
	}
}