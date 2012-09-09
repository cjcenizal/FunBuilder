package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import com.funbuilder.model.ElevationModel;
	import com.funbuilder.model.KeyboardModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.View3dModel;
	
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateElevationCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		[Inject]
		public var elevationModel:ElevationModel;
		
		[Inject]
		public var keyboardModel:KeyboardModel;
		
		[Inject]
		public var view3dModel:View3dModel;
		
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
					if ( keyboardModel.isDown( Keyboard.TAB ) ) {
						if ( map[ pos ].length > 0 ) {
							posMesh.visible = negMesh.visible = true;
						} else {
							posMesh.visible = negMesh.visible = false;
						}
					} else {
						posMesh.visible = negMesh.visible = false;
					}
				}
			}
			view3dModel.groundPlane.visible = ( keyboardModel.isDown( Keyboard.TAB ) );
		}
	}
}