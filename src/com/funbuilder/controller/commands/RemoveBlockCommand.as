package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.controller.signals.RemoveObjectFromSceneRequest;
	import com.funbuilder.model.CurrentBlockModel;
	import com.funbuilder.model.CurrentSegmentModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class RemoveBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var block:Mesh;
		
		// Models.
		
		[Inject]
		public var selectedBlockModel:CurrentBlockModel;
		
		[Inject]
		public var segmentModel:CurrentSegmentModel;
		
		// Commands.
		
		[Inject]
		public var deselectBlockRequest:DeselectBlockRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		override public function execute():void
		{
			// Deselect block if necessary.
			if ( selectedBlockModel.isBlock( block ) ) {
				deselectBlockRequest.dispatch();
			}
			
			// Remove from model.
			segmentModel.remove( block );
			
			// Remove from scene.
			removeObjectFromSceneRequest.dispatch( block );
		}
	}
}