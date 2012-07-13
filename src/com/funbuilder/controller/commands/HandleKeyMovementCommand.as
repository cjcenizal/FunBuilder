package com.funbuilder.controller.commands
{
	import away3d.cameras.Camera3D;
	
	import com.funbuilder.controller.signals.HandleKeyMovementRequest;
	import com.funbuilder.controller.signals.MoveBlockRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.constants.SegmentConstants;
	
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;

	
	public class HandleKeyMovementCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var view3dModel:View3DModel;
		
		[Inject]
		public var cameraTargetModel:CameraTargetModel;
		
		[Inject]
		public var currentBlockModel:SelectedBlocksModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
		// Commands.
		
		[Inject]
		public var moveBlockRequest:MoveBlockRequest;
		
		override public function execute():void
		{
			var camera:Camera3D = view3dModel.camera;
			
			var divDegToRad:Number = 180 * Math.PI;
			var rads:Number = view3dModel.cameraController.panAngle / divDegToRad;
			
			var camPos:Vector3D = camera.position;
			var adjCamPos:Vector3D = new Vector3D( camPos.x, 0, camPos.z );
			var theta:Number = view3dModel.getTheta( camPos, cameraTargetModel.getPosition() );
			
			var moveBlocks:Boolean = keysModel.isShiftDown;
			
			if ( !keysModel.isCommandDown ) {
				for ( var key:String in keysModel.keysDown ) {
					var moveX:Number = 0;
					var moveY:Number = 0;
					var moveZ:Number = 0;
					var speed:Number = moveBlocks ? 1 : 20;
					switch ( int( key ) ) {
						case Keyboard.W:
							// Move along ground plane.
							moveX = Math.cos( theta ) * -speed;
							moveZ = Math.sin( theta ) * -speed;
							break;
						case Keyboard.S:
							// Move along ground plane.
							moveX = Math.cos( theta ) * speed;
							moveZ = Math.sin( theta ) * speed;
							break;
						case Keyboard.A:
							// Strafe left along ground plane.
							moveX = Math.cos( theta + Math.PI * .5 ) * -speed;
							moveZ = Math.sin( theta + Math.PI * .5 ) * -speed;
							break;
						case Keyboard.D:
							// Strafe right along ground plane.
							moveX = Math.cos( theta + Math.PI * .5 ) * speed;
							moveZ = Math.sin( theta + Math.PI * .5 ) * speed;
							break;
						case 189: // Minus
							// Decrease elevation.
							moveY = -speed;
							break;
						case 187: // Plus
							// Increase elevation.
							moveY = speed;
							break;
						case 219: // Left brace
							// Zoom out.
							view3dModel.cameraController.distance += speed;
							break;
						case 221: // Right brace
							// Zoom in.
							if ( view3dModel.cameraController.distance > speed * 2 ) {
								view3dModel.cameraController.distance -= speed;
							}
							break;
					}
					if ( moveBlocks ) {
						moveX = Math.round( moveX ) * SegmentConstants.BLOCK_SIZE;
						moveY = Math.round( moveY ) * SegmentConstants.BLOCK_SIZE;
						moveZ = Math.round( moveZ ) * SegmentConstants.BLOCK_SIZE;
						moveBlockRequest.dispatch( new Vector3D( moveX, moveY, moveZ ) );
					} else {
						camera.position.x += moveX;
						camera.position.y += moveY;
						camera.position.z += moveZ;
						cameraTargetModel.move( moveX, moveY, moveZ );
					}
				}
			}
		}
	}
}