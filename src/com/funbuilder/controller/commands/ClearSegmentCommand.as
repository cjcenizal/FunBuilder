package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	
	import com.funbuilder.controller.signals.DeselectAllBlocksRequest;
	import com.funbuilder.controller.signals.RemoveBlockRequest;
	import com.funbuilder.model.ElevationModel;
	import com.funbuilder.model.SegmentModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class ClearSegmentCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		[Inject]
		public var elevationModel:ElevationModel;
		
		// Commands.
		
		[Inject]
		public var removeBlockRequest:RemoveBlockRequest;
		
		[Inject]
		public var deselectAllBlocksRequest:DeselectAllBlocksRequest;
		
		override public function execute():void {
			deselectAllBlocksRequest.dispatch();
			var keys:Array = segmentModel.getKeys();
			var block:Mesh;
			for ( var i:int = 0; i < keys.length; i++ ) {
				block = segmentModel.getWithKey( keys[ i ] );
				removeBlockRequest.dispatch( block );
			}
			segmentModel.clear();
			
			for ( var i:int = 0; i < elevationModel.count; i++ ) {
				elevationModel.getAt( i ).visible = false;
			}
		}
	}
}