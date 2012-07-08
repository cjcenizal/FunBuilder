package com.funbuilder.model
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import org.robotlegs.mvcs.Actor;
	
	public class CameraTargetModel extends Actor
	{
		
		public var target:Mesh;
		public var selectingMaterial:ColorMaterial = new ColorMaterial( 0x00FF00, .2 );
		public var selectedMaterial:ColorMaterial = new ColorMaterial( 0x00FF00, .4 );
		public var unselectedMaterial:ColorMaterial = new ColorMaterial( 0x0044FF, .2 );
		
		public function CameraTargetModel()
		{
			super();
		}
	}
}