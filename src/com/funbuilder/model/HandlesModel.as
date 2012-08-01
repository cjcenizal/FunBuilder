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
		private var _pos:Vector3D = new Vector3D();
		private var _minSize:Number = 250;
		private var _size:Number = _minSize;
		
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
			_pos.x = x;
			_pos.y = y;
			_pos.z = z;
			draw();
		}
		
		public function setSize( size:Number ):void {
			_size = size + _minSize;
			draw();
		}
		
		private function draw():void {
			xHandle.x = _pos.x + _size;
			xHandle.y = _pos.y;
			xHandle.z = _pos.z;
			yHandle.x = _pos.x;
			yHandle.y = _pos.y + _size;
			yHandle.z = _pos.z;
			zHandle.x = _pos.x;
			zHandle.y = _pos.y;
			zHandle.z = _pos.z + _size;
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