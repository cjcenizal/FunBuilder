package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.UpdateHandlesRequest;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.DeselectBlockVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class DeselectBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var deselectData:DeselectBlockVO;
		
		// Models.
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		// Commands.
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var updateHandlesRequest:UpdateHandlesRequest;
		
		override public function execute():void
		{
			if ( deselectData.saveHistory ) {
				addHistoryRequest.dispatch();
			}
			segmentModel.enableIndicatorFor( deselectData.block, false );
			selectedBlocksModel.deselect( deselectData.block );
			updateHandlesRequest.dispatch();
		}
	}
}