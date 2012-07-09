package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.RemoveBlockRequest;
	import com.funbuilder.model.SegmentModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class ClearSegmentCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var segmentModel:SegmentModel;
		
		// Commands.
		
		[Inject]
		public var removeBlockRequest:RemoveBlockRequest;
		
		override public function execute():void {
			var keys:Array = segmentModel.getKeys();
			var block:Mesh;
			for ( var i:int = 0; i < keys.length; i++ ) {
				block = segmentModel.getWithKey( keys[ i ] );
				removeBlockRequest.dispatch( block );
			}
			segmentModel.clear();
		}
	}
}