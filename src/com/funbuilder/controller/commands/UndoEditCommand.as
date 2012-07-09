package com.funbuilder.controller.commands {

	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddHistoryRequest;
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
		
		[Inject]
		public var updateTargetAppearanceRequest:UpdateTargetAppearanceRequest;
		
		override public function execute():void {
			// If at the end of history, save it, but only if it hasn't been flash saved.
			if ( historyModel.canFlashSave() ) {
				addHistoryRequest.dispatch( true );
			}
			var history:HistoryVO = historyModel.undo();
			if ( history ) {
				loadSegmentRequest.dispatch( history.snapshot );
				if ( history.selectedBlockKey ) {
					var block:Mesh = currentSegmentModel.getWithKey( history.selectedBlockKey );
					selectBlockRequest.dispatch( block );
				}
			}
			updateTargetAppearanceRequest.dispatch();
		}
	}
}
