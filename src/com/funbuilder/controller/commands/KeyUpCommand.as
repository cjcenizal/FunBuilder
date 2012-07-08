package com.funbuilder.controller.commands
{
	import flash.ui.Keyboard;
	
	import org.robotlegs.mvcs.Command;
	
	public class KeyUpCommand extends Command
	{
		// Arguments.
		
		[Inject]
		public var code:int;
		
		override public function execute():void
		{
			
		}
	}
}