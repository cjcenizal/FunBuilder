package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.DeselectBlockVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class DeselectAllBlocksCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		// Commands.
		
		[Inject]
		public var deselectBlockRequest:DeselectBlockRequest;
		
		override public function execute():void
		{
			while ( selectedBlocksModel.numBlocks > 0 ) {
				deselectBlockRequest.dispatch( new DeselectBlockVO( selectedBlocksModel.getAt( selectedBlocksModel.numBlocks - 1 ), false ) );
			}
		}
	}
}