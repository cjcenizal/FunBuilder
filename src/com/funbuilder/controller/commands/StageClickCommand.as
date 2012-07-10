package com.funbuilder.controller.commands
{
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	
	import org.robotlegs.mvcs.Command;
	
	public class StageClickCommand extends Command
	{
		
		
		// Commands.
		
		[Inject]
		public var deselectBlockRequest:DeselectBlockRequest;
		
		override public function execute():void
		{
			deselectBlockRequest.dispatch();
		}
	}
}