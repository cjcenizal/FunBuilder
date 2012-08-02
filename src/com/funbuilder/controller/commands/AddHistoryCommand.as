package com.funbuilder.controller.commands
{
	import com.funbuilder.model.HistoryModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.HistoryVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddHistoryCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var historyModel:HistoryModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		[Inject]
		public var selectedBlockModel:SelectedBlocksModel;
		
		override public function execute():void
		{
			
			var snapshot:String = segmentModel.getJson();
			var selectedBlockKeys:Array = [];
			for ( var i:int = 0; i < selectedBlockModel.numBlocks; i++ ) {
				selectedBlockKeys.push( segmentModel.getKeyFor( selectedBlockModel.getAt( i ) ) );
			}
			var history:HistoryVO = new HistoryVO( snapshot, selectedBlockKeys );
			
			// Save history snapshot if not identical to the current history snapshot.
			if ( historyModel.doesNotMatchCurrent( snapshot ) ) {
				historyModel.add( history );
			}
		}
	}
}