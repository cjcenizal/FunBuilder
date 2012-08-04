package com.funbuilder.model
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class CameraTargetModel extends Actor
	{
		
		public var target:Mesh;
		private var _position:Vector3D;
		
		public function CameraTargetModel()
		{
			super();
			_position = new Vector3D();
		}
		
		public function setMesh( target:Mesh ):void {
			this.target = target;
			target.material = new ColorMaterial( 0xffffff, .1 );
		}
		
		public function move( x:Number, y:Number, z:Number ):void {
			_position.x += x;
			_position.y += y;
			_position.z += z;
		}
		
		public function moveTo( x:Number, y:Number, z:Number ):void {
			_position.x = x;
			_position.y = y;
			_position.z = z;
		}
		
		public function setPos( x:Number, y:Number, z:Number ):void {
			_position.x = x;
			_position.y = y;
			_position.z = z;
		}
		
		public function update():void {
			target.x = _position.x;
			target.y = _position.y;
			target.z = _position.z;
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