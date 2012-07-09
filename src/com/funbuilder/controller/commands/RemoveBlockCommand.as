package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.controller.signals.RemoveObjectFromSceneRequest;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlockModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class RemoveBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var block:Mesh;
		
		// Models.
		
		[Inject]
		public var selectedBlockModel:SelectedBlockModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
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