package com.funbuilder.controller.commands
{
	import away3d.cameras.Camera3D;
	
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.MoveBlockRequest;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.KeysModel;
	import com.funbuilder.model.SelectedBlockModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.constants.SegmentConstants;
	import com.funbuilder.model.events.TimeEvent;
	
	import flash.ui.Keyboard;
	import flash.geom.Vector3D;
	
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
		public var currentBlockModel:SelectedBlockModel;
		
		[Inject]
		public var keysModel:KeysModel;
		
		// Commands.
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var moveBlockRequest:MoveBlockRequest;
		
		override public function execute():void
		{
			var camera:Camera3D = view3dModel.camera;
			
			var divDegToRad:Number = 180 * Math.PI;
			var rads:Number = view3dModel.cameraController.panAngle / divDegToRad;
			
			var camPos:Vector3D = camera.position;
			var adjCamPos:Vector3D = new Vector3D( camPos.x, 0, camPos.z );
			var theta:Number = getTheta( camPos, cameraTargetModel.target.position );
			var speed:Number = 20;
			
			for ( var key:String in keysModel.keysDown ) {
				trace( key );
				var moveX:Number = 0;
				var moveY:Number = 0;
				var moveZ:Number = 0;
				switch ( int( key ) ) {
					case Keyboard.W:
						// Move towards target along ground plane.
						moveX = Math.cos( theta ) * -speed;
						moveZ = Math.sin( theta ) * -speed;
						break;
					case Keyboard.S:
						// Move away from target along ground plane.
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
				camera.position.x += moveX;
				camera.position.y += moveY;
				camera.position.z += moveZ;
				cameraTargetModel.target.x += moveX;
				cameraTargetModel.target.y += moveY;
				cameraTargetModel.target.z += moveZ;
			}
			
			// If we have a currently selected block, move the block to match the target.
			if ( currentBlockModel.hasBlock() ) {
				// Move block.
				var snappedPos:Vector3D = SegmentConstants.snapPointGrid( cameraTargetModel.target.x, cameraTargetModel.target.y, cameraTargetModel.target.z );
				if ( !snappedPos.equals( currentBlockModel.getBlock().position ) ) {
					moveBlockRequest.dispatch( snappedPos );
				}
			}
			
			// Render scene.
			view3dModel.render();
		}
		
		
		private function getTheta( posA:Vector3D, posB:Vector3D ):Number {
			var deltaZ:Number = posA.z - posB.z;
			var deltaX:Number = posA.x - posB.x;
			var angle:Number = Math.atan2(deltaZ, deltaX);
			return angle;
		}
		
	}
}