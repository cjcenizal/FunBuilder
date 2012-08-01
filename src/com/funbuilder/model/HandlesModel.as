package com.funbuilder.model
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.ConeGeometry;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class HandlesModel extends Actor
	{
		
		public var xHandle:Mesh;
		public var yHandle:Mesh;
		public var zHandle:Mesh;
		private var _isGrabbed:Boolean = false;
		private var _axis:String = null;
		
		public function HandlesModel()
		{
			super();
			var radius:Number = 25;
			var height:Number = 75;
			xHandle = new Mesh( new ConeGeometry( radius, height ), new ColorMaterial( 0xff0000 ) );
			yHandle = new Mesh( new ConeGeometry( radius, height ), new ColorMaterial( 0x00ff00 ) );
			zHandle = new Mesh( new ConeGeometry( radius, height ), new ColorMaterial( 0x0000ff ) );
			xHandle.rotationZ = -90;
			zHandle.rotationX = 90;
			xHandle.mouseEnabled = yHandle.mouseEnabled = zHandle.mouseEnabled = true;
			moveTo( 0, 0, 0 );
			hide();
		}
		
		public function moveTo( x:Number, y:Number, z:Number ):void {
			var offset:Number = 250;
			xHandle.x = x + offset;
			xHandle.y = y;
			xHandle.z = z;
			yHandle.x = x;
			yHandle.y = y + offset;
			yHandle.z = z;
			zHandle.x = x;
			zHandle.y = y;
			zHandle.z = z + offset;
		}
		
		public function hide():void {
			xHandle.visible = yHandle.visible = zHandle.visible = false;
		}
		
		public function show():void {
			xHandle.visible = yHandle.visible = zHandle.visible = true;
		}
		
		public function grab( isGrabbed:Boolean, axis:String = null ):void {
			_isGrabbed = isGrabbed;
			_axis = axis;
		}
		
		public function get isGrabbed():Boolean {
			return _isGrabbed;
		}
		
		public function get axis():String {
			return _axis;
		}
	}
}