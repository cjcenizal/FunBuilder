package com.funbuilder.model
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import org.robotlegs.mvcs.Actor;
	
	public class CameraTargetModel extends Actor
	{
		
		public var target:Mesh;
		public var lookUnselectedMaterial:ColorMaterial = new ColorMaterial( 0x00ccff, .1 );
		public var lookSelectedMaterial:ColorMaterial = new ColorMaterial( 0x00ff78, .2 );
		public var buildUnselectedMaterial:ColorMaterial = new ColorMaterial( 0xffa200, .1 );
		public var buildSelectedMaterial:ColorMaterial = new ColorMaterial( 0xfff000, .2 );
		
		public function CameraTargetModel()
		{
			super();
		}
	}
}