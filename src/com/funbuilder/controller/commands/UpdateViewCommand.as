package com.funbuilder.controller.commands
{
	import away3d.cameras.Camera3D;
	
	import com.cenizal.utils.Trig;
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.BrushBlockRequest;
	import com.funbuilder.controller.signals.UpdateBrushRequest;
	import com.funbuilder.controller.signals.UpdateCollisionsRequest;
	import com.funbuilder.controller.signals.UpdateElevationRequest;
	import com.funbuilder.controller.signals.UpdateGrabbedBlocksRequest;
	import com.funbuilder.controller.signals.UpdateHandlesRequest;
	import com.funbuilder.model.BrushModel;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.HandlesModel;
	import com.funbuilder.model.HudModel;
	import com.funbuilder.model.KeyboardModel;
	import com.funbuilder.model.MouseModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.View3dModel;
	import com.funbuilder.model.events.TimeEvent;
	
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateViewCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var event:TimeEvent;
		
		// Models.
		
		[Inject]
		public var view3dModel:View3dModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var keyboardModel:KeyboardModel;
		
		[Inject]
		public var mouseModel:MouseModel;
		
		[Inject]
		public var brushModel:BrushModel;
		
		[Inject]
		public var handlesModel:HandlesModel;
		
		[Inject]
		public var hudModel:HudModel;
		
		// Commands.
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var upgradeGrabbedBlocksRequest:UpdateGrabbedBlocksRequest;
		
		[Inject]
		public var updateHandlesRequest:UpdateHandlesRequest;
		
		[Inject]
		public var updateCollisionsRequest:UpdateCollisionsRequest;
		
		[Inject]
		public var updateElevationRequest:UpdateElevationRequest;
		
		[Inject]
		public var updateBrushRequest:UpdateBrushRequest;
		
		[Inject]
		public var brushBlockRequest:BrushBlockRequest;
		
		override public function execute():void
		{
			// Update brush.
			updateBrushRequest.dispatch();
			
			// Add blocks with brush.
			if ( brushModel.preview && keyboardModel.isDown( Keyboard.SPACE ) ) {
				// If we're in brush mode, then see if we need to place a block.
				if ( !mouseModel.isMoving && mouseModel.mouseDown && brushModel.canPlace() ) {
					brushBlockRequest.dispatch();
				}
			} else {
				// If a handle is grabbed, we are moving the selection.
				if ( handlesModel.isGrabbed ) {
					upgradeGrabbedBlocksRequest.dispatch();
				} else {
					// If shift or alt key is down, then we're drag-adding/-removing to/from selection.
					if ( keyboardModel.shift || keyboardModel.alt ) {
					} else {
						// While mouse is down 
						if ( mouseModel.rightMouseDown || keyboardModel.command ) {
							// If shift key isn't down, then we're panning.
							if ( mouseModel.prevPosition ) {
								var camera:Camera3D = view3dModel.camera;
								var mousePos:Point = new Point( contextView.mouseX, contextView.mouseY );
								var cameraTheta:Number = Trig.thetaFromPoints(
									new Point( camera.position.z, camera.position.x ),
									new Point( cameraTargetModel.getPosition().z, cameraTargetModel.getPosition().x ) );
								var mouseTheta:Number = Trig.thetaFromPoints( mousePos, mouseModel.prevPosition );
								var len:Number = Trig.getDistanceFromPoints( mouseModel.prevPosition, mousePos );
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
			}
			
			// Update target.
			cameraTargetModel.update();
			
			// Render scene.
			view3dModel.render();
			
			// Update handles.
			updateHandlesRequest.dispatch();
			
			if ( !hudModel.isValid ) {
				hudModel.isValid = true;
				
				// Update collisions.
				//updateCollisionsRequest.dispatch();
			}
			
			// Store mouse pos.
			mouseModel.moveMouse( contextView.stage.mouseX, contextView.stage.mouseY );
		}
		
	}
}