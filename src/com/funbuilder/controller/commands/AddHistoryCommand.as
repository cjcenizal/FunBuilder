package com.funbuilder.controller.commands
{
	import com.funbuilder.model.HistoryModel;
	import com.funbuilder.model.vo.HistoryVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddHistoryCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var history:HistoryVO;
		
		// Models.
		
		
		[Inject]
		public var historyModel:HistoryModel;
		
		override public function execute():void
		{
			// Save history for:
			// - First reposition
			// - First type change
			// - Add new block
			// - Delete block
			
			
			// Save history snapshot if not identical to the current history snapshot.
			var current:HistoryVO = historyModel.getCurrent();
			if ( !current || current.snapshot != history.snapshot ) {
				trace("add history");
				historyModel.add( history );
			}
		}
	}
}