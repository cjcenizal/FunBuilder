package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.tools.utils.Drag3D;
	import away3d.tools.utils.Ray;
	
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.model.BrushModel;
	import com.funbuilder.model.MouseModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.constants.SegmentConstants;
	
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateBrushCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var brushModel:BrushModel;
		
		[Inject]
		public var view3dModel:View3DModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		[Inject]
		public var mouseModel:MouseModel;
		
		// Commands.
		
		[Inject]
		public var addBlockRequest:AddBlockRequest;
		
		override public function execute():void {
			
			
			var preview:Mesh = brushModel.preview;
			if ( preview ) {
				// Position preview piled on top of ground plane.
				var drag:Drag3D = new Drag3D( view3dModel.view );
				var pos:Vector3D;
				if ( mouseModel.overBlock ) {
					pos = mouseModel.overBlock.position.clone();
					pos.y = 0;
				} else {
					pos = drag.getIntersect( view3dModel.view.mouseX, view3dModel.view.mouseY );
				}
				SegmentConstants.snapPositionToGrid( pos );
				brushModel.movePreview( pos.x, segmentModel.getMaxElevationAt( pos ), pos.z );
				
					
				/*
				var targetPos:Vector3D = cameraTargetModel.getPosition();
				preview.x = targetPos.x;
				preview.y = targetPos.y;
				preview.z = targetPos.z;
				SegmentConstants.snapObjectToGrid( preview );
				*/
				
				/*
				// Project plane in front of camera at X distance.
				// Intersect mouse ray with it and position block there.
				var cameraPos:Vector3D = view3dModel.getCameraPosition();
				var targetPos:Vector3D = cameraTargetModel.getPosition();
				var ray:Ray = new Ray();
				ray.dir = view3dModel.getMouseUnprojection().subtract( cameraPos );
				ray.orig = cameraPos;
				var planeNormal:Vector3D = targetPos.subtract( cameraPos );
				planeNormal.normalize();
				var push:Vector3D = planeNormal.clone();
				push.scaleBy( 1000 );
				var planePos:Vector3D = cameraPos.add( push );
				var pos:Vector3D = getIntersection( ray, planePos, planeNormal );
				trace(pos);
				block.x = pos.x;
				block.y = pos.y;
				block.z = pos.z;*/
				
				/*
				// Project x distance in front of the camera along mouse's vector and place a block.
				var cameraPos:Vector3D = view3dModel.getCameraPosition();
				var targetPos:Vector3D = cameraTargetModel.getPosition();
				// Get vectors to define plane of camera perpendicular to its target.
				// http://paulbourke.net/geometry/disk/
				var vectorToTarget:Vector3D = targetPos.subtract( cameraPos );
				var p:Vector3D = new Vector3D( -10000000, -10000000, -10000000 ); // Can be any point not on line from camera to target.
				var r:Vector3D = Trig.crossProduct( p.subtract( cameraPos ), vectorToTarget );
				var s:Vector3D = Trig.crossProduct( r, vectorToTarget );
				r.normalize();
				s.normalize();
				// Get mouse offset.
				var mouseX:Number = contextView.stage.mouseX - contextView.stage.width * .5;
				var mouseY:Number = contextView.stage.mouseY - contextView.stage.height * .5;
				mouseX *= -1;
				mouseY *= -1;
				var mousePos:Vector3D = new Vector3D();
				mousePos.x = cameraPos.x + mouseX * r.x + mouseY * s.x;
				mousePos.y = cameraPos.y + mouseX * r.y + mouseY * s.y;
				mousePos.z = cameraPos.z + mouseX * r.z + mouseY * s.z;
				// Get vector from camera to target.
				vectorToTarget.normalize();
				vectorToTarget.scaleBy( 1000 );
				mousePos.incrementBy( vectorToTarget );
				block.x = mousePos.x;
				block.y = mousePos.y;
				block.z = mousePos.z;*/
				
			}
		}
		
		
		private function getIntersection( ray:Ray, position:Vector3D, normal:Vector3D ):Vector3D {
			var k:Number;
			var t:Number;
			var point:Point;
			var toPoint:Vector3D;
			
			k = ray.dir.dotProduct( normal );
			if (k != 0.0) {
				t = ( position.subtract( ray.orig ) ).dotProduct( normal ) / k;
			} else {
				return null;
			}
			if (t < 0.0000001) {
				return null;
			}
			
			var pos:Vector3D = ray.orig.add( ray.dir );
			pos.scaleBy( t );
			return pos;
		}
	}
}