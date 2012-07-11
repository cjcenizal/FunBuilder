package com.funbuilder.controller.commands
{
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.SelectBlockVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class DeselectSingleBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var deselectData:SelectBlockVO;
		
		// Models.
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		override public function execute():void
		{
			selectedBlocksModel.deselect( deselectData.block );
		}
	}
}