package com.funbuilder.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	public class AddHistoryCommand extends Command
	{
		override public function execute():void
		{
			trace(this);
			// Save history for:
			// - First type change
			// - Add new block
			// - Delete block
		}
	}
}