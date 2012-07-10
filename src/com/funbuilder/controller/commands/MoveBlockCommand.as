package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.controller.signals.UpdateElevationRequest;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlockModel;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	public class MoveBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var position:Vector3D;
		
		// Models.
		
		[Inject]
		public var selectedBlockModel:SelectedBlockModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		// Commands.
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var invalidateSavedFileRequest:InvalidateSavedFileRequest;
		
		[Inject]
		public var updateElevationRequest:UpdateElevationRequest;
		
		override public function execute():void
		{
			if ( !selectedBlockModel.isMoved && selectedBlockModel.willMoveTo( position ) ) {
				// Save history if we move the block and it's the first time it gets moved.
				addHistoryRequest.dispatch( false );
			}
			if ( selectedBlockModel.willMoveTo( position ) ) {
				segmentModel.move( selectedBlockModel.getBlock().position, position );
				selectedBlockModel.setPosition( position );
				invalidateSavedFileRequest.dispatch();
				updateElevationRequest.dispatch();
			}
		}
	}
}