package com.funbuilder.controller.commands
{
	import away3d.cameras.Camera3D;
	
	import com.cenizal.utils.Trig;
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.HandlesModel;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.MouseModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.events.TimeEvent;
	
	import flash.geom.Point;
	
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
		
		[Inject]
		public var handlesModel:HandlesModel;
		
		// Commands.
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		override public function execute():void
		{
			
			// If a handle is grabbed, we are moving the selection.
			if ( handlesModel.isGrabbed ) {
				
			} else {
				// If shift key is down, then we're drag-adding/-removing to/from selection.
				if ( keysModel.shift ) {
				} else {
					// While mouse is down 
					if ( mouseModel.rightMouseDown || keysModel.command ) {
						// If shift key isn't down, then we're panning.
						if ( mouseModel.prevPosition ) {
							var camera:Camera3D = view3dModel.camera;
							var mousePos:Point = new Point( contextView.mouseX, contextView.mouseY );
							var cameraTheta:Number = Trig.thetaFrom(
								new Point( camera.position.z, camera.position.x ),
								new Point( cameraTargetModel.getPosition().z, cameraTargetModel.getPosition().x ) );
							var mouseTheta:Number = Trig.thetaFrom( mousePos, mouseModel.prevPosition );
							var len:Number = Math.abs( mouseModel.prevPosition.subtract( mousePos ).length );
							if ( len > 0 ) {
								var boost = view3dModel.cameraController.distance * .03;
								var distance = ( len + boost ) * -1;
								var angle = cameraTheta + mouseTheta;
								var moveX:Number = Math.cos( angle ) * distance;
								var moveZ:Number = Math.sin( angle ) * distance;
								camera.position.x += moveX;
								camera.position.z += moveZ;
								cameraTargetModel.move( moveX, 0, moveZ );
							}
						}
					} else if ( mouseModel.mouseDown ) {
						// Control the camera.
						view3dModel.cameraController.panAngle = .35 * ( contextView.stage.mouseX - view3dModel.lastMouseX ) + view3dModel.lastPanAngle;
						view3dModel.cameraController.tiltAngle = .35 * ( contextView.stage.mouseY - view3dModel.lastMouseY ) + view3dModel.lastTiltAngle;
					}
				}
			}
			
			// Update target.
			cameraTargetModel.update();
			
			// Render scene.
			view3dModel.render();
			
			// Store mouse pos.
			mouseModel.updatePrevPosition( contextView.stage.mouseX, contextView.stage.mouseY );
		}
		
	}
}