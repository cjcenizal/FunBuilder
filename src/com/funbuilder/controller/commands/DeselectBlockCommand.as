package com.funbuilder.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	public class DeselectBlockCommand extends Command
	{
		
		// Models.
		
		[Inject]
		public var currentBlockModel:CurrentBlockModel;
		
		override public function execute():void
		{
			// TO-DO:
			// Intersecting an existing block flashes red and doesn't allow you to leave it there
			// (i.e. deselect it)
			
			
			currentBlockModel.block = null;
		}
	}
}