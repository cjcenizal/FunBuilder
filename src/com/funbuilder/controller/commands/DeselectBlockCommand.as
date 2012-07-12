package com.funbuilder.controller.commands
{
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
		
		override public function execute():void
		{
			// TO-DO: save history
			trace(this);
			segmentModel.enableIndicatorFor( deselectData.block, false );
			selectedBlocksModel.deselect( deselectData.block );
		}
	}
}