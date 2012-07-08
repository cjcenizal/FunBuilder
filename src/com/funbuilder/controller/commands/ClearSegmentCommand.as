package com.funbuilder.controller.commands
{
	import away3d.entities.Mesh;
	
	import com.funbuilder.controller.signals.RemoveBlockRequest;
	import com.funbuilder.model.CurrentSegmentModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class ClearSegmentCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var segmentModel:CurrentSegmentModel;
		
		// Commands.
		
		[Inject]
		public var removeBlockRequest:RemoveBlockRequest;
		
		override public function execute():void {
			var blocks:Object = segmentModel.getObject();
			var block:Mesh;
			for ( var key:String in blocks ) {
				block = segmentModel.getWithKey( key );
				removeBlockRequest.dispatch( block );
			}
			segmentModel.clear();
		}
	}
}