package com.funbuilder.controller.commands {

	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.controller.signals.LoadSegmentRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.model.HistoryModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.vo.HistoryVO;
	import com.funbuilder.model.vo.SelectBlockVO;
	
	import org.robotlegs.mvcs.Command;

	public class UndoEditCommand extends Command {

		// Models.
		
		[Inject]
		public var historyModel:HistoryModel;
		
		[Inject]
		public var currentBlockModel:SelectedBlocksModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		[Inject]
		public var selectedBlockModel:SelectedBlocksModel;
		
		// Commands.
		
		[Inject]
		public var loadSegmentRequest:LoadSegmentRequest;
		
		[Inject]
		public var selectBlockRequest:SelectBlockRequest;
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var invalidateSavedFileRequest:InvalidateSavedFileRequest;
		
		override public function execute():void {
			var newHistory:HistoryVO;
			if ( historyModel.indexIsAtLatest() ) {
				var snapshot:String = segmentModel.getJson();
				var selectedBlockKeys:Array = [];
				for ( var i:int = 0; i < selectedBlockModel.numBlocks; i++ ) {
					selectedBlockKeys.push( segmentModel.getKeyFor( selectedBlockModel.getAt( i ) ) );
				}
				newHistory = new HistoryVO( snapshot, selectedBlockKeys );
			}
			var history:HistoryVO = historyModel.undo( newHistory );
			if ( history ) {
				loadSegmentRequest.dispatch( history.snapshot );
				var block:Mesh
				for ( var i:int = 0; i < history.selectedBlockKeys.length; i++ ) {
					block = segmentModel.getWithKey( history.selectedBlockKeys[ i ] );
					selectBlockRequest.dispatch( new SelectBlockVO( block, true, false ) );
				}
			}
			invalidateSavedFileRequest.dispatch();
		}
	}
}
