package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.controller.signals.UpdateElevationRequest;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	public class MoveBlockCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var position:Vector3D;
		
		// Models.
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
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
			if ( !selectedBlocksModel.isMoved && selectedBlocksModel.willMoveTo( position ) ) {
				// Save history if we move the block and it's the first time it gets moved.
				addHistoryRequest.dispatch( false );
			}
			if ( selectedBlocksModel.willMoveTo( position ) ) {
				var src:Vector3D;
				var dest:Vector3D;
				var diff:Vector3D = selectedBlocksModel.getDiff( position );
				for ( var i:int = 0; i < selectedBlocksModel.numBlocks; i++ ) {
					src = selectedBlocksModel.getPositionAt( i );
					dest = src.add( diff );
					segmentModel.moveElevationPosition( src, dest );
				}
				selectedBlocksModel.setPosition( position );
				invalidateSavedFileRequest.dispatch();
				updateElevationRequest.dispatch();
			}
		}
	}
}