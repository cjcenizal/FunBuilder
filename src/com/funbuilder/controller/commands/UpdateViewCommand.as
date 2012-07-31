package com.funbuilder.controller.commands
{
	import away3d.cameras.Camera3D;
	
	import com.cenizal.utils.Trig;
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.HandleKeyMovementRequest;
	import com.funbuilder.controller.signals.MoveBlockRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.MouseModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funbuilder.model.events.TimeEvent;
	
	import flash.geom.Point;
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
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
		[Inject]
		public var mouseModel:MouseModel;
		
		// Commands.
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var handleKeyMovementRequest:HandleKeyMovementRequest;
		
		override public function execute():void
		{
			
			// While mouse is down.
			if ( mouseModel.mouseDown ) {
				if ( keysModel.shift ) {
					// If shift key is down, then we're drag-adding to selection.
				} else {
					// If shift key isn't down, then we're controlling the camera.
					view3dModel.cameraController.panAngle = .35 * ( contextView.stage.mouseX - view3dModel.lastMouseX ) + view3dModel.lastPanAngle;
					view3dModel.cameraController.tiltAngle = .35 * ( contextView.stage.mouseY - view3dModel.lastMouseY ) + view3dModel.lastTiltAngle;
				}
			} else if ( mouseModel.rightMouseDown ) {
				// While right-mouse is down.
				if ( keysModel.shift ) {
					// If shift key is down, then we're drag-removing from selection.
				} else {
					// If shift key isn't down, then we're panning.
					var angle:Number = Trig.thetaFrom( new Point( contextView.mouseX, contextView.mouseY ), mouseModel.prev );
					if ( angle > 0 ) {
						if ( angle < Trig.QUARTER_PI ) {
							trace("up");
						} else if ( angle < Trig.THREE_QUARTER_PI ) {
							trace("left");
						} else {
							trace("down");
						}
					} else {
						if ( angle > -Trig.QUARTER_PI ) {
							trace("up");
						} else if ( angle > -Trig.THREE_QUARTER_PI ) {
							trace("right");
						} else {
							trace("down");
						}
					}
				}
			}
			
			handleKeyMovementRequest.dispatch();
			
			// Update target.
			cameraTargetModel.update();
			
			// Render scene.
			view3dModel.render();
			
			// Store mouse pos.
			mouseModel.prev.x = contextView.stage.mouseX;
			mouseModel.prev.y = contextView.stage.mouseY;
		}
		
		
	}
}