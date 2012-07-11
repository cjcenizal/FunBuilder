package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.DeselectAllBlocksRequest;
	
	import org.robotlegs.mvcs.Command;
	
	public class StageClickCommand extends Command
	{
		
		
		// Commands.
		
		[Inject]
		public var deselectAllBlocksRequest:DeselectAllBlocksRequest;
		
		override public function execute():void
		{
		//	deselectAllBlocksRequest.dispatch();
		}
	}
}