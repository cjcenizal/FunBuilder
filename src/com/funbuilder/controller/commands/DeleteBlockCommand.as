package com.funbuilder.controller.commands	
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.controller.signals.RemoveBlockRequest;
	import com.funbuilder.model.SelectedBlockModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class DeleteBlockCommand extends Command
	{
		// Models.
		
		[Inject]
		public var selectedBlockModel:SelectedBlockModel;
		
		// Commands.
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var removeBlockRequest:RemoveBlockRequest;
		
		[Inject]
		public var invalidateSavedFileRequest:InvalidateSavedFileRequest;
		
		override public function execute():void
		{
			if ( selectedBlockModel.hasBlock() ) {
				addHistoryRequest.dispatch( false );
				removeBlockRequest.dispatch( selectedBlockModel.getBlock() );
				invalidateSavedFileRequest.dispatch();
			}
		}
	}
}