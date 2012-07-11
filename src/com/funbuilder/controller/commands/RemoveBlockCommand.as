package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.DeselectSingleBlockRequest;
	import com.funbuilder.controller.signals.RemoveObjectFromSceneRequest;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.SelectBlockVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class RemoveBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var block:Mesh;
		
		// Models.
		
		[Inject]
		public var selectedBlockModel:SelectedBlocksModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		// Commands.
		
		[Inject]
		public var deselectBlockRequest:DeselectSingleBlockRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		override public function execute():void
		{
			// Deselect block if necessary.
			if ( selectedBlockModel.contains( block ) ) {
				deselectBlockRequest.dispatch( new SelectBlockVO( block ) );
			}
			
			// Remove from model.
			segmentModel.remove( block );
			
			// Remove from scene.
			removeObjectFromSceneRequest.dispatch( block );
		}
	}
}