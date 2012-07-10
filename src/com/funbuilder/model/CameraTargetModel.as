package com.funbuilder.model
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import com.funbuilder.model.constants.SegmentConstants;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class CameraTargetModel extends Actor
	{
		
		public var lookUnselectedMaterial:ColorMaterial = new ColorMaterial( 0x00ccff, .1 );
		public var buildSelectedMaterial:ColorMaterial = new ColorMaterial( 0x00ff78, .2 );
		public var lookSelectedMaterial:ColorMaterial = new ColorMaterial( 0xffa200, .6 );
		public var buildUnselectedMaterial:ColorMaterial = new ColorMaterial( 0xfff000, .6 );
		
		private var _target:Mesh;
		private var _position:Vector3D;
		
		public function CameraTargetModel()
		{
			super();
			_position = new Vector3D();
		}
		
		public function setMesh( target:Mesh ):void {
			_target = target;
		}
		
		public function move( x:Number, y:Number, z:Number ):void {
			_position.x += x;
			_position.y += y;
			_position.z += z;
		}
		
		public function setPos( x:Number, y:Number, z:Number ):void {
			_position.x = x;
			_position.y = y;
			_position.z = z;
		}
		
		public function setMaterial( material:ColorMaterial ):void {
			_target.material = material;
		}
		
		public function update( snap:Boolean = false ):void {
			var pos:Vector3D = ( snap ) ? SegmentConstants.snapPointGrid( _position.x, _position.y, _position.z ) : _position;
			_target.x = pos.x;
			_target.y = pos.y;
			_target.z = pos.z;
		}
		
		public function getPosition():Vector3D {
			return _position;
		}
		
		public function get targetX():Number {
			return _position.x;
		}
		
		public function get targetY():Number {
			return _position.y;
		}
		
		public function get targetZ():Number {
			return _position.z;
		}
	}
}