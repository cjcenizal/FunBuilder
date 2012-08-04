package com.funbuilder.controller.commands {
	
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.controller.signals.LoadSegmentRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.HistoryModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.vo.HistoryVO;
	import com.funbuilder.model.vo.SelectBlockVO;
	
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
		
		[Inject]
		public var invalidateSavedFileRequest:InvalidateSavedFileRequest;
		
		override public function execute():void {
			var history:HistoryVO = historyModel.redo();
			if ( history ) {
				loadSegmentRequest.dispatch( history.snapshot );
				var block:Mesh;
				for ( var i:int = 0; i < history.selectedBlockKeys.length; i++ ) {
					block = currentSegmentModel.getWithKey( history.selectedBlockKeys[ i ] );
					selectBlockRequest.dispatch( new SelectBlockVO( block, true, false ) );
				}
			}
			invalidateSavedFileRequest.dispatch();
		}
	}
}
