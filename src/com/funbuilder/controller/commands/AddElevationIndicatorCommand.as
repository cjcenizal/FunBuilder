package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.model.ElevationModel;
	import com.funbuilder.model.vo.AddElevationIndicatorVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddElevationIndicatorCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var data:AddElevationIndicatorVO;
		
		// Models.
		
		[Inject]
		public var elevationModel:ElevationModel;
		
		// Commands.
		
		[Inject]
		public var addObjectToSceneRequest:AddObjectToSceneRequest;
		
		override public function execute():void
		{
			
			// Add to model.
			elevationModel.add( data.indicator, data.isPositive );
			
			
			// Add to scene.
			addObjectToSceneRequest.dispatch( data.indicator );
		}
	}
}