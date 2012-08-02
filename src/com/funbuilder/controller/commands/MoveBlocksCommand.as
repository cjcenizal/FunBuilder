package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.controller.signals.UpdateElevationRequest;
	import com.funbuilder.model.HandlesModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.View3DModel;
	import com.funbuilder.model.constants.SegmentConstants;
	
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Command;
	
	public class MoveBlocksCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var selectedBlocksModel:SelectedBlocksModel;
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		[Inject]
		public var handlesModel:HandlesModel;
		
		[Inject]
		public var view3dModel:View3DModel;
		
		// Commands.
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var invalidateSavedFileRequest:InvalidateSavedFileRequest;
		
		[Inject]
		public var updateElevationRequest:UpdateElevationRequest;
		
		override public function execute():void
		{
			trace("move blocks along : " + handlesModel.axis);
			
			// Get vector defined by projected handle and line positions.
			var handlePos:Vector3D = view3dModel.view.project( handlesModel.handlePosition );
			var linePos:Vector3D = view3dModel.view.project( handlesModel.linePosition );
			
			
			// Figure out if mouse position is less than or greater than the perpendicular line.
			
			// Move along axis.
			
			
			
			/*
			if ( !selectedBlocksModel.isMoved && diff.length > 0 ) {
				// Save history if we move the block and it's the first time it gets moved.
				addHistoryRequest.dispatch( false );
			}
			if ( diff.length > 0 ) {
				var src:Vector3D;
				var dest:Vector3D;
				for ( var i:int = 0; i < selectedBlocksModel.numBlocks; i++ ) {
					src = selectedBlocksModel.getPositionAt( i );
					dest = src.add( diff );
					segmentModel.moveElevationPosition( src, dest );
				}
				// Set position of blocks and indicators.
				var block:Mesh;
				var indicator:Mesh;
				for ( var i:int = 0; i < selectedBlocksModel.numBlocks; i++ ) {
					block = selectedBlocksModel.getBlockAt( i );
					block.x += diff.x;
					block.y += diff.y;
					block.z += diff.z;
					indicator = segmentModel.getIndicatorFor( block );
					indicator.x = block.x;
					indicator.y = block.y + SegmentConstants.BLOCK_SIZE * .5;
					indicator.z = block.z;
				}
				selectedBlocksModel.setIsMoved( true );
				
				invalidateSavedFileRequest.dispatch();
				updateElevationRequest.dispatch();
			}*/
		}
	}
}