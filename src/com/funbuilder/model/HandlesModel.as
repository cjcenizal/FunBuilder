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
			moveTo( 0, 0, 0 );
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
	}
}