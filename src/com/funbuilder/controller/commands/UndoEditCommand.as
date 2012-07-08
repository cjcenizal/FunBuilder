package com.funbuilder.controller.commands {

	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.LoadSegmentRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.SelectedBlockModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.HistoryModel;
	import com.funbuilder.model.vo.HistoryVO;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;

	public class UndoEditCommand extends Command {

		// Models.
		
		[Inject]
		public var historyModel:HistoryModel;
		
		[Inject]
		public var currentSegmentModel:SegmentModel;
		
		[Inject]
		public var currentBlockModel:SelectedBlockModel;
		
		// Commands.
		
		[Inject]
		public var loadSegmentRequest:LoadSegmentRequest;
		
		[Inject]
		public var selectBlockRequest:SelectBlockRequest;
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		override public function execute():void {
			// If at the end of history, save it, but only if it hasn't been flash saved.
			if ( historyModel.canFlashSave() ) {
				addHistoryRequest.dispatch( true );
			}
			var history:HistoryVO = historyModel.undo();
			if ( history ) {
				loadSegmentRequest.dispatch( history.snapshot );
				selectBlockRequest.dispatch( currentSegmentModel.getAtPos( history.selectedBlock ) );
			}
		}
	}
}
