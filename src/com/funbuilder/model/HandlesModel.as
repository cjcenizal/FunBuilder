package com.funbuilder.model
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.ConeGeometry;
	import away3d.primitives.CylinderGeometry;
	import away3d.primitives.LineSegment;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class HandlesModel extends Actor
	{
		
		public var xHandle:Mesh;
		public var yHandle:Mesh;
		public var zHandle:Mesh;
		public var xLine:Mesh;
		public var yLine:Mesh;
		public var zLine:Mesh;
		private var _isGrabbed:Boolean = false;
		private var _axis:String = null;
		private var _pos:Vector3D = new Vector3D();
		private var _minSize:Number = 250;
		private var _size:Number = _minSize;
		public var amountMoved:Number = 0;
		
		public function HandlesModel()
		{
			super();
			var radius:Number = 25;
			var height:Number = 75;
			var xMaterial:ColorMaterial = new ColorMaterial( 0xff0000 );
			var yMaterial:ColorMaterial = new ColorMaterial( 0x00ff00 );
			var zMaterial:ColorMaterial = new ColorMaterial( 0x0000ff );
			xHandle = new Mesh( new ConeGeometry( radius, height ), xMaterial );
			yHandle = new Mesh( new ConeGeometry( radius, height ), yMaterial );
			zHandle = new Mesh( new ConeGeometry( radius, height ), zMaterial );
			var lineThickness:Number = 3;
			xLine = new Mesh( new CylinderGeometry( lineThickness, lineThickness, 1 ), xMaterial );
			yLine = new Mesh( new CylinderGeometry( lineThickness, lineThickness, 1 ), yMaterial );
			zLine = new Mesh( new CylinderGeometry( lineThickness, lineThickness, 1 ), zMaterial );
			xLine.rotationZ = xHandle.rotationZ = -90;
			zLine.rotationX = zHandle.rotationX = 90;
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
			xLine.scaleY = yLine.scaleY = zLine.scaleY = _size;
			xLine.x = _pos.x + _size * .5;
			xLine.y = _pos.y;
			xLine.z = _pos.z;
			yLine.x = _pos.x;
			yLine.y = _pos.y + _size * .5;
			yLine.z = _pos.z;
			zLine.x = _pos.x;
			zLine.y = _pos.y;
			zLine.z = _pos.z + _size * .5;
		}
		
		public function hide():void {
			xHandle.visible = yHandle.visible = zHandle.visible = false;
			xLine.visible = yLine.visible = zLine.visible = false;
		}
		
		public function show():void {
			xHandle.visible = yHandle.visible = zHandle.visible = true;
			xLine.visible = yLine.visible = zLine.visible = true;
		}
		
		public function grab( isGrabbed:Boolean, axis:String = null ):void {
			_isGrabbed = isGrabbed;
			_axis = axis;
			amountMoved = 0;
		}
		
		public function get handlePosition():Vector3D {
			switch ( _axis ) {
				case "x":
					return xHandle.position;
				case "y":
					return yHandle.position;
				case "z":
					return zHandle.position;
			}
			return null;
		}
		
		public function get linePosition():Vector3D {
			switch ( _axis ) {
				case "x":
					return xLine.position;
				case "y":
					return yLine.position;
				case "z":
					return zLine.position;
			}
			return null;
		}
		
		public function get isGrabbed():Boolean {
			return _isGrabbed;
		}
		
		public function get axis():String {
			return _axis;
		}
	}
}