package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import com.funbuilder.model.ElevationModel;
	import com.funbuilder.model.SegmentModel;
	
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateElevationCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		[Inject]
		public var elevationModel:ElevationModel;
		
		override public function execute():void
		{
			var map:Dictionary = segmentModel.getElevationMap();
			var position:Vector3D;
			var posMesh:Mesh;
			var negMesh:Mesh;
			for ( var pos:Object in map ) {
				position = pos as Vector3D;
				posMesh = elevationModel.getAtPos( position, true );
				negMesh = elevationModel.getAtPos( position, false );
				if ( posMesh && negMesh ) {
					if ( map[ pos ].length > 0 ) {
						posMesh.visible = negMesh.visible = true;
						//( posMesh.material as ColorMaterial ).alpha = .8;
						//( negMesh.material as ColorMaterial ).alpha = .8;
					} else {
						posMesh.visible = negMesh.visible = false;
						//( posMesh.material as ColorMaterial ).alpha = .8;
						//( negMesh.material as ColorMaterial ).alpha = .8;
					}
				}
			}
		}
	}
}