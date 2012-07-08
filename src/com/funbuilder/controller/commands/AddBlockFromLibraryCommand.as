package com.funbuilder.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	public class AddBlockFromLibraryCommand extends Command
	{
		
		// Arguments.
		
		[Inject]
		public var id:String;
		
		override public function execute():void
		{
			trace(id);
		}
	}
}