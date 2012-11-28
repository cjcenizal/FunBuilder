package com.funbuilder.controller.commands	
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.controller.signals.RemoveBlockRequest;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class DeleteBlockCommand extends Command
	{
		// Models.
		
		[Inject]
		public var selectedBlockModel:SelectedBlocksModel;
		
		// Commands.
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var removeBlockRequest:RemoveBlockRequest;
		
		[Inject]
		public var invalidateSavedFileRequest:InvalidateSavedFileRequest;
		
		[Inject]
		public var m:SegmentModel;
		
		override public function execute():void
		{
			if ( selectedBlockModel.numBlocks > 0 ) {
				addHistoryRequest.dispatch();
				for ( var i:int = selectedBlockModel.numBlocks - 1; i >= 0; i-- ) {
					removeBlockRequest.dispatch( selectedBlockModel.getAt( i ) );
				}
				invalidateSavedFileRequest.dispatch();
			}
			trace(m.getJson());
		}
	}
}