package com.funbuilder.controller.commands {

	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.controller.signals.LoadSegmentRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.controller.signals.UpdateTargetAppearanceRequest;
	import com.funbuilder.model.HistoryModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlockModel;
	import com.funbuilder.model.vo.HistoryVO;
	
	import org.robotlegs.mvcs.Command;

	public class UndoEditCommand extends Command {

		// Models.
		
		[Inject]
		public var historyModel:HistoryModel;
		
		[Inject]
		public var currentBlockModel:SelectedBlockModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		[Inject]
		public var selectedBlockModel:SelectedBlockModel;
		
		// Commands.
		
		[Inject]
		public var loadSegmentRequest:LoadSegmentRequest;
		
		[Inject]
		public var selectBlockRequest:SelectBlockRequest;
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var updateTargetAppearanceRequest:UpdateTargetAppearanceRequest;
		
		[Inject]
		public var invalidateSavedFileRequest:InvalidateSavedFileRequest;
		
		override public function execute():void {
			var newHistory:HistoryVO;
			if ( historyModel.indexIsAtLatest() ) {
				var snapshot:String = segmentModel.getJson();
				var selectedBlockKey:String = ( selectedBlockModel.hasBlock() ) ? segmentModel.getKeyFor( selectedBlockModel.getBlock() ) : null;
				newHistory = new HistoryVO( snapshot, selectedBlockKey );
			}
			var history:HistoryVO = historyModel.undo( newHistory );
			if ( history ) {
				loadSegmentRequest.dispatch( history.snapshot );
				if ( history.selectedBlockKey ) {
					var block:Mesh = segmentModel.getWithKey( history.selectedBlockKey );
					selectBlockRequest.dispatch( block );
				}
			}
			updateTargetAppearanceRequest.dispatch();
			invalidateSavedFileRequest.dispatch();
		}
	}
}
