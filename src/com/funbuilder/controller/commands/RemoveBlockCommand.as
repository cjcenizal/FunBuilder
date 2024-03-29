package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.controller.signals.InvalidateHudRequest;
	import com.funbuilder.controller.signals.RemoveObjectFromSceneRequest;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.DeselectBlockVo;
	
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
		public var deselectBlockRequest:DeselectBlockRequest;
		
		[Inject]
		public var removeObjectFromSceneRequest:RemoveObjectFromSceneRequest;
		
		[Inject]
		public var invalidateHudRequest:InvalidateHudRequest;
		
		override public function execute():void
		{
			// Deselect block if necessary.
			if ( selectedBlockModel.contains( block ) ) {
				deselectBlockRequest.dispatch( new DeselectBlockVo( block ) );
			}
			
			// Remove from scene.
			removeObjectFromSceneRequest.dispatch( block );
			removeObjectFromSceneRequest.dispatch( segmentModel.getIndicatorFor( block ) );
			
			// Remove from model.
			segmentModel.remove( block );
			
			// Update HUD.
			invalidateHudRequest.dispatch();
		}
	}
}