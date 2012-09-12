package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.SelectBlockVo;
	
	import org.robotlegs.mvcs.Command;
	
	public class SelectBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var selectData:SelectBlockVo;
		
		// Models.
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		// Commands.
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		override public function execute():void
		{
			if ( !selectedBlocksModel.contains( selectData.block ) ) {
				// Save history.
				if ( selectData.saveHistory ) {
					addHistoryRequest.dispatch();
				}
				// Select block.
				selectedBlocksModel.select( selectData.block );
				segmentModel.enableIndicatorFor( selectData.block, true );
			}
		}
	}
}