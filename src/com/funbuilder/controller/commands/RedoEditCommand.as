package com.funbuilder.controller.commands {
	
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.LoadSegmentRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.controller.signals.UpdateTargetAppearanceRequest;
	import com.funbuilder.model.HistoryModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.vo.HistoryVO;
	
	import flash.geom.Vector3D;
	
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
		public var updateTargetAppearanceRequest:UpdateTargetAppearanceRequest;
		
		override public function execute():void {
			var history:HistoryVO = historyModel.redo();
			if ( history ) {
				loadSegmentRequest.dispatch( history.snapshot );
				if ( history.selectedBlock ) {
					var block:Mesh = currentSegmentModel.getAtPos( history.selectedBlock );
					selectBlockRequest.dispatch( block );
				}
			}
			updateTargetAppearanceRequest.dispatch();
		}
	}
}
