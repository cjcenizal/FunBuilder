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
			/* else */if ( mouseModel.rightMouseDown || keysModel.command ) {
				// If shift key isn't down, then we're panning.
				if ( mouseModel.prev ) {
					var camera:Camera3D = view3dModel.camera;
					var mousePos:Point = new Point( contextView.mouseX, contextView.mouseY );
					var userTheta:Number = Trig.thetaFrom( mousePos, mouseModel.prev );
					var groundTheta:Number = Trig.thetaFrom3( camera.position, cameraTargetModel.getPosition() );
					var len:Number = Math.abs( mouseModel.prev.subtract( mousePos ).length );
					if ( len > 0 ) {
						var speed = -len;
						var moveX:Number = Math.cos( userTheta + groundTheta ) * speed;
						var moveZ:Number = Math.sin( userTheta + groundTheta ) * speed;
						camera.position.x += moveX;
						camera.position.z += moveZ;
						cameraTargetModel.move( moveX, 0, moveZ );
					}
				}
				/*
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
				}*/
			} else if ( mouseModel.mouseDown ) {
				if ( keysModel.shift ) {
					// If shift key is down, then we're drag-adding/-removing to/from selection.
				} else {
					// If shift key isn't down, then we're controlling the camera.
					view3dModel.cameraController.panAngle = .35 * ( contextView.stage.mouseX - view3dModel.lastMouseX ) + view3dModel.lastPanAngle;
					view3dModel.cameraController.tiltAngle = .35 * ( contextView.stage.mouseY - view3dModel.lastMouseY ) + view3dModel.lastTiltAngle;
				}
			}
			
			//handleKeyMovementRequest.dispatch();
			
			// Update target.
			cameraTargetModel.update();
			
			// Render scene.
			view3dModel.render();
			
			// Store mouse pos.
			if ( mouseModel.prev ) {
				mouseModel.prev.x = contextView.stage.mouseX;
				mouseModel.prev.y = contextView.stage.mouseY;
			}
		}
		
		
	}
}