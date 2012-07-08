package com.funbuilder.controller.commands {

	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.LoadSegmentRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.CurrentBlockModel;
	import com.funbuilder.model.CurrentSegmentModel;
	import com.funbuilder.model.HistoryModel;
	import com.funbuilder.model.vo.HistoryVO;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;

	public class UndoEditCommand extends Command {

		// Models.
		
		[Inject]
		public var historyModel:HistoryModel;
		
		[Inject]
		public var currentSegmentModel:CurrentSegmentModel;
		
		[Inject]
		public var currentBlockModel:CurrentBlockModel;
		
		// Commands.
		
		[Inject]
		public var loadSegmentRequest:LoadSegmentRequest;
		
		[Inject]
		public var selectBlockRequest:SelectBlockRequest;
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		override public function execute():void {
			trace("undo");
			// If at the end of history, save it.
			var offset:int = 0;
			if ( historyModel.indexIsAtEnd() ) {
				var snapshot:String = currentSegmentModel.getJson();
				var selectedBlockPos:Vector3D = ( currentBlockModel.hasBlock() ) ? currentBlockModel.getPositionClone() : null;
				addHistoryRequest.dispatch( new HistoryVO( snapshot, selectedBlockPos ) );
				offset = -1;
			}
			var history:HistoryVO = historyModel.undo( offset );
			if ( history ) {
				loadSegmentRequest.dispatch( history.snapshot );
				selectBlockRequest.dispatch( currentSegmentModel.getAtPos( history.selectedBlock ) );
			}
		}
	}
}
