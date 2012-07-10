package com.funbuilder.model
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class CameraTargetModel extends Actor
	{
		
		public var lookUnselectedMaterial:ColorMaterial = new ColorMaterial( 0x00ccff, .1 );
		public var buildSelectedMaterial:ColorMaterial = new ColorMaterial( 0x00ff78, .2 );
		public var lookSelectedMaterial:ColorMaterial = new ColorMaterial( 0xffa200, .6 );
		public var buildUnselectedMaterial:ColorMaterial = new ColorMaterial( 0xfff000, .6 );
		
		private var _target:Mesh;
		
		public function CameraTargetModel()
		{
			super();
		}
		
		public function setMesh( target:Mesh ):void {
			_target = target;
		}
		
		public function move( x:Number, y:Number, z:Number ):void {
			_target.x += x;
			_target.y += y;
			_target.z += z;
		}
		
		public function setPos( x:Number, y:Number, z:Number ):void {
			_target.x = x;
			_target.y = y;
			_target.z = z;
		}
		
		public function setMaterial( material:ColorMaterial ):void {
			_target.material = material;
		}
		
		public function getPosition():Vector3D {
			return _target.position;
		}
		
		public function get targetX():Number {
			return _target.x;
		}
		
		public function get targetY():Number {
			return _target.y;
		}
		
		public function get targetZ():Number {
			return _target.z;
		}
	}
}