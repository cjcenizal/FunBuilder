package com.funbuilder.controller.commands {
	
	import com.funbuilder.controller.signals.LoadSegmentRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.HistoryModel;
	import com.funbuilder.model.vo.HistoryVO;
	
	import org.robotlegs.mvcs.Command;
	
	public class RedoEditCommand extends Command {
		
		// Models.
		
		[Inject]
		public var historyModel:HistoryModel;
		
		[Inject]
		public var currentSegmentModel:SegmentModel;
		
		// Commands.
		
		[Inject]
		public var loadSegmentRequest:LoadSegmentRequest;
		
		[Inject]
		public var selectBlockRequest:SelectBlockRequest;
		
		override public function execute():void {
			var history:HistoryVO = historyModel.redo();
			if ( history ) {
				loadSegmentRequest.dispatch( history.snapshot );
				selectBlockRequest.dispatch( currentSegmentModel.getAtPos( history.selectedBlock ) );
			}
		}
	}
}
