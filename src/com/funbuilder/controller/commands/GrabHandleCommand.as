package com.funbuilder.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	public class GrabHandleCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var axis:String;
		
		override public function execute():void {
			
		}
	}
}