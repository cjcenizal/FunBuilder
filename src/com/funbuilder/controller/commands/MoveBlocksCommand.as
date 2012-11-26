package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.cenizal.utils.Trig;
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.InvalidateHudRequest;
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.controller.signals.UpdateHandlesRequest;
	import com.funbuilder.model.HandlesModel;
	import com.funbuilder.model.MouseModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.View3dModel;
	import com.funbuilder.model.constants.Grid;
	import com.funrun.model.constants.Block;
	
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
		public var view3dModel:View3dModel;
		
		[Inject]
		public var mouseModel:MouseModel;
		
		// Commands.
		
		[Inject]
		public var addHistoryRequest:AddHistoryRequest;
		
		[Inject]
		public var invalidateSavedFileRequest:InvalidateSavedFileRequest;
		
		[Inject]
		public var updateHandlesRequest:UpdateHandlesRequest;
		
		[Inject]
		public var invalidateHudRequest:InvalidateHudRequest;
		
		override public function execute():void
		{
			
			// Get angle defined by projected handle and line positions.
			var handlePos:Vector3D = view3dModel.view.project( handlesModel.handlePosition );
			var linePos:Vector3D = view3dModel.view.project( handlesModel.linePosition );
			var axisAngle:Number = Trig.thetaFrom( handlePos.x, handlePos.y, linePos.x, linePos.y );
			
			// Get angle of mouse movement.
			var mousePos:Point = new Point( contextView.stage.mouseX, contextView.stage.mouseY );
			var mouseAngle:Number = Trig.thetaFrom( mousePos.x, mousePos.y, mouseModel.prevPosition.x, mouseModel.prevPosition.y );
			
			// See if the mouseAngle relative to a normalized axisAngle is moving in the same direction.
			var relativeMouseAngle:Number = Math.abs( mouseAngle - axisAngle );
			var direction:Number = ( relativeMouseAngle <= Trig.HALF_PI ) ? 1 : -1;
			var magnitude:Number = Trig.getDistanceFromPoints( mouseModel.prevPosition, mousePos );
			
			handlesModel.amountMoved += magnitude * direction;

			
			// Get diff vector.
			var diff:Vector3D = new Vector3D();
			switch ( handlesModel.axis ) {
				case "x":
					diff.x = Math.round( handlesModel.amountMoved / ( Block.SIZE * 1 ) ) * ( Block.SIZE * 1 );
					break;
				case "y":
					diff.y = Math.round( handlesModel.amountMoved / ( Block.SIZE * .2 ) ) * ( Block.SIZE * .2 );
					break;
				case "z":
					diff.z = Math.round( handlesModel.amountMoved / ( Block.SIZE * 1 ) ) * ( Block.SIZE * 1 );
					break;
			}
			
			if ( diff.length > 0 ) {
				// Save history if we move the block and it's the first time it gets moved.
				//if ( !selectedBlocksModel.isMoved && diff.length > 0 ) {
				//	addHistoryRequest.dispatch( false );
				//}
				
				// Move elevation.
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
					block = selectedBlocksModel.getAt( i );
					block.x += diff.x;
					block.y += diff.y;
					block.z += diff.z;
					indicator = segmentModel.getIndicatorFor( block );
					indicator.x = block.x;
					indicator.y = block.y;
					indicator.z = block.z;
				}
				selectedBlocksModel.setIsMoved( true );
				
				//invalidateSavedFileRequest.dispatch();
				
				// Update handle.
				updateHandlesRequest.dispatch();
				handlesModel.amountMoved = 0;
				
				// Update HUD.
				invalidateHudRequest.dispatch();
			}
		}
	}
}