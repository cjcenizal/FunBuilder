package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.RemoveObjectFromSceneRequest;
	import com.funbuilder.model.ElevationModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class HideAllElevationCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var elevationModel:ElevationModel;
		
		// Commands.
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		override public function execute():void
		{
			for ( var i:int = 0; i < elevationModel.count; i++ ) {
				removeObjectFromSceneRequest.dispatch( elevationModel.getAt( i ) );
			}
		}
	}
}