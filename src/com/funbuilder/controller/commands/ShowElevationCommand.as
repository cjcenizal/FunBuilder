package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.model.ElevationModel;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	public class ShowElevationCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var position:Vector3D;
		
		// Models.
		
		[Inject]
		public var elevationModel:ElevationModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		override public function execute():void
		{
			var posMesh:Mesh = elevationModel.getAtPos( position, true );
			if ( posMesh ) {
				addObjectToSceneRequest.dispatch( posMesh );
			}
			var negMesh:Mesh = elevationModel.getAtPos( position, false );
			if ( negMesh ) {
				addObjectToSceneRequest.dispatch( negMesh );
			}
		}
	}
}