package com.funbuilder.controller.commands
{
	import org.robotlegs.mvcs.Command;
	
	public class AddHistorySnapshotCommand extends Command
	{
		override public function execute():void
		{
			// Save history for:
			// - First type change
			// - First position change
			// - Add new block
			// - Save segment
			// - Delete block
		}
	}
}